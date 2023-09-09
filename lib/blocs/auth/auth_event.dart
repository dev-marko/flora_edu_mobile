part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class _AuthStatusChanged extends AuthEvent {
  final AuthStatus status;
  const _AuthStatusChanged(this.status);
}

final class AuthLogoutRequested extends AuthEvent {}
