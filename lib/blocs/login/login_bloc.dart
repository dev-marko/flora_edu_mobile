import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../data/models/form_inputs/models.dart';
import '../../data/repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginRegisterScreenRequested>(_onRegisterScreenRequested);
  }

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate(
          [state.password, email],
        ),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate(
          [state.email, password],
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
      try {
        await _authRepository.logIn(
          email: state.email.value,
          password: state.password.value,
        );
        emit(state.copyWith(formStatus: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(formStatus: FormzSubmissionStatus.failure));
      }
    }
  }

  void _onRegisterScreenRequested(
    LoginRegisterScreenRequested event,
    Emitter<LoginState> emit,
  ) {
    _authRepository.setRegisteringStatus();
    emit(state.copyWith(goToRegisterScreen: event.goToRegisterScreen));
  }
}
