import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/login/login_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ФлораЕду',
          style: GoogleFonts.yesevaOne(),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (context) {
              return LoginBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context),
              );
            },
            child: const LoginForm(),
          ),
        ),
      ),
    );
  }
}
