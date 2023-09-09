import '../screens/home_screen.dart';
import '../screens/plants/plants_list_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/' || '/home':
        return HomeScreen.route();
      case '/plants':
        return PlantsListScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }

  void dispose() {
    // ? Used to close cubits/blocs
  }
}
