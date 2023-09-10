import 'package:flutter/material.dart';

import '../../features/plants/presentation/screens/plants_list_screen.dart';
import '../screens/splash_screen.dart';

class FloraEduAppDrawer extends StatelessWidget {
  const FloraEduAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Навигација'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(PlantsListScreen.route());
            },
            leading: const Icon(Icons.grass),
            title: const Text('Растенија'),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(SplashScreen.route());
            },
            leading: const Icon(Icons.abc),
            title: const Text('Test'),
          ),
        ],
      ),
    );
  }
}
