import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../blocs/login/login_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.formStatus.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Серверска грешка!'),
              ),
            );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 8.0,
        child: Container(
          height: deviceSize.height * 0.5,
          width: deviceSize.width * 0.75,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _EmailInput(),
              const SizedBox(height: 8.0),
              _PasswordInput(),
              const SizedBox(height: 16.0),
              _LoginButton(),
              const SizedBox(height: 8.0),
              _NavigateToRegisterScreenButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) =>
              context.read<LoginBloc>().add(LoginEmailChanged(email)),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Е-пошта',
            icon: const Icon(Icons.email),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            errorText:
                state.email.displayError != null ? 'Невалидна е-пошта' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Лозинка',
            icon: const Icon(Icons.password),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            errorText: state.password.displayError != null
                ? 'Невалидна лозинка'
                : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: state.isValid
                    ? () =>
                        context.read<LoginBloc>().add(const LoginSubmitted())
                    : null,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 8.0,
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.primary),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text('Најави се'),
              );
      },
    );
  }
}

class _NavigateToRegisterScreenButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.goToRegisterScreen != current.goToRegisterScreen,
      builder: (context, state) {
        return TextButton(
          onPressed: () => context
              .read<LoginBloc>()
              .add(const LoginRegisterScreenRequested(true)),
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            foregroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.primary,
            ),
          ),
          child: const Text(
            'Кликнете тука за регистрација!',
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
