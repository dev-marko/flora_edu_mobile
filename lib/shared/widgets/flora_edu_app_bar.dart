import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../features/authentication/blocs/auth/auth_bloc.dart';

class FloraEduAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const FloraEduAppBar({this.title = 'ФлораЕду', super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.yesevaOne(),
      ),
      centerTitle: true,
      actions: [
        MenuAnchor(
          menuChildren: [
            MenuItemButton(
              child: const Text('Мој профил'),
              onPressed: () {},
            ),
            MenuItemButton(
              child: const Text('Поставки'),
              onPressed: () {},
            ),
            MenuItemButton(
              child: const Text('Одјава'),
              onPressed: () =>
                  context.read<AuthBloc>().add(AuthLogoutRequested()),
            ),
          ],
          builder:
              (BuildContext context, MenuController controller, Widget? child) {
            return IconButton(
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              icon: const Icon(Icons.account_circle),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
