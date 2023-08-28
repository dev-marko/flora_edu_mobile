part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthStatus status;
  final FloraEduUser user;

  const AuthState._(
      {this.status = AuthStatus.unknown, this.user = FloraEduUser.empty});

  const AuthState.unknown() : this._(status: AuthStatus.unknown);

  const AuthState.authenticated() : this._(status: AuthStatus.authenticated);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  const AuthState.registering() : this._(status: AuthStatus.registering);

  @override
  List<Object> get props => [status, user];
}
