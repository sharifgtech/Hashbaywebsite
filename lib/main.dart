import 'package:flutter/material.dart';
import 'package:hashbaytech/services_page.dart';
import 'about_page.dart';
import 'app_scaffold.dart';
import 'contact_page.dart';
import 'cyber_security_page.dart';
import 'home_page.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Software Company',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generate,
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case '/':
        page = const HomePage();
        break;
      case '/about':
        page = const AboutPage();
        break;
      case '/services':
        page = const ServicesPage();
        break;
      case '/cyber-security':
        page = const CyberSecurityPage();
        break;
      case '/contact':
        page = const ContactPage();
        break;
      default:
        page = const _NotFoundPage();
    }
    return MaterialPageRoute(
      builder: (context) => AppScaffold(child: page, currentRoute: settings.name ?? '/'),
      settings: settings,
    );
  }
}

class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64),
          const SizedBox(height: 12),
          Text('Page not found', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed('/'),
            child: const Text('Go Home'),
          ),
        ],
      ),
    );
  }
}
