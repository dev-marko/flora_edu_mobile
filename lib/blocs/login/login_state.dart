part of 'login_bloc.dart';

final class LoginState extends Equatable {
  final FormzSubmissionStatus formStatus;
  final Email email;
  final Password password;
  final bool isValid;
  final bool goToRegisterScreen;

  const LoginState({
    this.formStatus = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.goToRegisterScreen = false,
  });

  LoginState copyWith({
    FormzSubmissionStatus? formStatus,
    Email? email,
    Password? password,
    bool? isValid,
    bool? goToRegisterScreen,
  }) {
    return LoginState(
      formStatus: formStatus ?? this.formStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      goToRegisterScreen: goToRegisterScreen ?? this.goToRegisterScreen,
    );
  }

  @override
  List<Object?> get props => [formStatus, email, password, goToRegisterScreen];
}
