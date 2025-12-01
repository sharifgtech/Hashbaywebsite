import 'package:flutter/material.dart';
import 'top_navbar.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.child, required this.currentRoute});

  final Widget child;
  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 900;

    return Scaffold(
      appBar: TopNavBar(currentRoute: currentRoute),
      drawer: isWide ? null : Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.security, size: 40),
                  SizedBox(height: 8),
                  Text('Your Software Company', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            _drawerItem(context, 'Home', '/', currentRoute),
            _drawerItem(context, 'About', '/about', currentRoute),
            _drawerItem(context, 'Our Services', '/services', currentRoute),
            _drawerItem(context, 'Cyber Security', '/cyber-security', currentRoute),
            _drawerItem(context, 'Contact', '/contact', currentRoute),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                colors: [Color(0xFFE0F2FE), Color(0xFFFFFFFF)]
            )
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: child,
            ),
          ),
        ),
      ),
   /*   bottomNavigationBar: const _Footer(),*/
    );
  }

  ListTile _drawerItem(BuildContext context, String label, String route, String current) {
    final selected = current == route;
    return ListTile(
      selected: selected,
      leading: selected ? const Icon(Icons.check_circle) : const Icon(Icons.circle_outlined),
      title: Text(label),
      onTap: () {
        Navigator.of(context).pop();
        if (ModalRoute.of(context)?.settings.name != route) {
          Navigator.of(context).pushNamed(route);
        }
      },
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 12,
        children: [
          Text('© ' + year.toString() + ' Hashbay Technology — All rights reserved.'),
          const Text(''),
        ],
      ),
    );
  }
}
