import 'package:flutter/material.dart';

import '../../features/plants/presentation/screens/plants_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const PlantsListScreen();
  }
}
