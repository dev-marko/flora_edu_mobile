part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final FormzSubmissionStatus formStatus;
  final Email email;
  final Password password;
  final ConfirmedPassword confirmPassword;
  final bool isValid;

  const RegisterState({
    this.formStatus = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmedPassword.pure(),
    this.isValid = false,
  });

  RegisterState copyWith({
    FormzSubmissionStatus? formStatus,
    Email? email,
    Password? password,
    ConfirmedPassword? confirmPassword,
    bool? isValid,
    bool? goToRegisterScreen,
  }) {
    return RegisterState(
      formStatus: formStatus ?? this.formStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [formStatus, email, password, confirmPassword];
}
