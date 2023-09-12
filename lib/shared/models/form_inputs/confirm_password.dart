import 'package:formz/formz.dart';

import 'password.dart';
import 'validators.dart';

class ConfirmedPassword extends FormzInput<String, PasswordValidationError> {
  const ConfirmedPassword.pure()
      : original = const Password.pure(),
        super.pure('');
  const ConfirmedPassword.dirty({required this.original, String value = ''})
      : super.dirty(value);

  final Password original;

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    if (value != original.value) return PasswordValidationError.mismatch;
    return null;
  }
}
