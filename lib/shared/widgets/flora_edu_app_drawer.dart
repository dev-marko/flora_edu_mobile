import 'package:flora_edu_mobile/presentation/screens/plants/plants_list_screen.dart';
import 'package:flora_edu_mobile/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

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
