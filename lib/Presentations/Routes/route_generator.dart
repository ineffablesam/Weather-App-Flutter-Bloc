import 'package:flutter/material.dart';
import 'package:weather/Presentations/Screens/account_page.dart';
import 'package:weather/Presentations/Screens/home_page.dart';
import 'package:weather/Presentations/Screens/welcome_page.dart';

class RoutesGenerators {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/account':
        return MaterialPageRoute(builder: (_) => const AccountPage());
      default:
        return MaterialPageRoute(
            builder: (_) => _NoRoute(
                  settings: settings,
                ),
            settings: settings);
    }
  }
}

class _NoRoute extends StatelessWidget {
  final RouteSettings settings;
  const _NoRoute({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'No route defined for ${settings.name}',
        ),
      ),
    );
  }
}
