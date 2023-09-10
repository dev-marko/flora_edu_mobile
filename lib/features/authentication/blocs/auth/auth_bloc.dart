import 'dart:async';

import 'package:equatable/equatable.dart';
import '../../data/models/flora_edu_user.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthStatus> _authStatusSubscription;

  AuthBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const AuthState.unknown()) {
    on<_AuthStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthLogoutRequested>(_onAuthenticationLogoutRequested);
    _authStatusSubscription = _authRepository.status
        .listen((status) => add(_AuthStatusChanged(status)));
  }

  Future<void> _onAuthenticationStatusChanged(
    _AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    switch (event.status) {
      case AuthStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthStatus.authenticated:
        {
          emit(const AuthState.authenticated());
        }
      case AuthStatus.registering:
        return emit(const AuthState.registering());
      case AuthStatus.unknown:
        {
          bool loggedIn = await _authRepository.isLoggedIn();
          if (loggedIn) {
            emit(const AuthState.authenticated());
          } else {
            emit(const AuthState.unauthenticated());
          }
        }
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    _authRepository.logOut();
  }

  Future<FloraEduUser?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    return super.close();
  }
}
