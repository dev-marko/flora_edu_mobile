import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/register/register_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import '../widgets/forms/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => const RegisterScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (context) {
              return RegisterBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context),
              );
            },
            child: const RegisterForm(),
          ),
        ),
      ),
    );
  }
}
