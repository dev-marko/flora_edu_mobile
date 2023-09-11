import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../shared/models/form_inputs/confirm_password.dart';
import '../../../../shared/models/form_inputs/email.dart';
import '../../../../shared/models/form_inputs/password.dart';
import '../../data/repositories/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;

  RegisterBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const RegisterState()) {
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate(
          [email, state.password, state.confirmPassword],
        ),
      ),
    );
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate(
          [state.email, password, state.confirmPassword],
        ),
      ),
    );
  }

  void _onConfirmPasswordChanged(
    RegisterConfirmPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final confirmPassword = ConfirmedPassword.dirty(
      original: state.password,
      value: event.confirmPassword,
    );
    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        isValid: Formz.validate(
          [state.email, state.password, confirmPassword],
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
      try {
        await _authRepository.register(
          email: state.email.value,
          password: state.password.value,
        );
        emit(state.copyWith(formStatus: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(formStatus: FormzSubmissionStatus.failure));
      }
    }
  }
}
