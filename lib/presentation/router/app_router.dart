import 'package:flutter/material.dart';

import '../screens/test_screen.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/test':
        return TestScreen.route();
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
