import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavBar({super.key, required this.currentRoute});
  final String currentRoute;

  bool get isHome => currentRoute == '/';

  static const double _barHeight = 68;

  @override
  Size get preferredSize => const Size.fromHeight(_barHeight);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 900;
    final cs = Theme.of(context).colorScheme;

    return AppBar(
      toolbarHeight: _barHeight,
      elevation: 0,
      scrolledUnderElevation: 3,
      surfaceTintColor: Colors.transparent,
      backgroundColor: cs.surface,
      foregroundColor: cs.onSurface,
      centerTitle: false,
      titleSpacing: 16,
      leading: isWide
          ? null
          : Builder(
        builder: (ctx) => IconButton(
          tooltip: 'Menu',
          onPressed: () => Scaffold.of(ctx).openDrawer(),
          icon: const Icon(Icons.menu),
        ),
      ),
      title: InkWell(
        onTap: () => _go(context, '/'),
        borderRadius: BorderRadius.circular(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/logo.png',
                height: 32,
                width: 32,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            // Brand typography: bold + slight size boost
            Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: 'Hashbay ',
                  style: TextStyle(
                    color: cs.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextSpan(
                  text: 'Technology ',
                  style: TextStyle(
                    color: Color(0xFFf97c8a),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ]),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20, // ↑ size
                letterSpacing: .2,
              ),
            ),
          ],
        ),
      ),
      actions: isWide
          ? [
        _NavAction(label: 'Home', route: '/', currentRoute: currentRoute),
        _NavAction(
            label: 'About', route: '/about', currentRoute: currentRoute),
        _NavAction(
            label: 'Our Services',
            route: '/services',
            currentRoute: currentRoute),
        _NavAction(
            label: 'Cyber Security',
            route: '/cyber-security',
            currentRoute: currentRoute),
        _NavAction(
            label: 'Contact',
            route: '/contact',
            currentRoute: currentRoute),
        const SizedBox(width: 8),
        // Right-side CTA
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: FilledButton.icon(
            onPressed: () => _go(context, '/contact'),
            icon: const Icon(Icons.send, size: 18),
            label: const Text('Get a Quote'),
            style: FilledButton.styleFrom(
              padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                letterSpacing: .2,
              ),
            ),
          ),
        ),
      ]
          : null,
      // Subtle bottom divider (Material look)
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          height: 1,
          thickness: 1,
          color: cs.outlineVariant,
        ),
      ),
    );
  }

  void _go(BuildContext context, String route) {
    if (ModalRoute.of(context)?.settings.name != route) {
      Navigator.of(context).pushNamed(route);
    }
  }
}

class _NavAction extends StatelessWidget {
  const _NavAction({
    required this.label,
    required this.route,
    required this.currentRoute,
  });

  final String label;
  final String route;
  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bool selected = currentRoute == route;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: () {
          if (ModalRoute.of(context)?.settings.name != route) {
            Navigator.of(context).pushNamed(route);
          }
        },
        style: ButtonStyle(
          // “Pill” background for the active item
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (selected) return cs.secondaryContainer;
            if (states.contains(MaterialState.hovered)) {
              return cs.secondaryContainer.withOpacity(.35);
            }
            return Colors.transparent;
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (selected) return cs.onSecondaryContainer;
            return cs.onSurface;
          }),
          overlayColor: MaterialStatePropertyAll(cs.primary.withOpacity(.08)),
          padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          ),
          shape: MaterialStatePropertyAll(
            StadiumBorder(
              side: BorderSide(
                color: selected ? Colors.transparent : cs.outlineVariant,
              ),
            ),
          ),
          textStyle: MaterialStatePropertyAll(
            TextStyle(
              fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
              fontSize: 14, // ↑ clearer nav size
              letterSpacing: .2,
            ),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
