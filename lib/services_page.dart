import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const services = [
      _Service(
        'Custom Software Development',
        'Bespoke web & desktop systems, ERPs, CRMs, and integrations tailored to your workflows.',
        Icons.handyman,
        tags: ['ERP/CRM', 'Integrations', 'Scalable'],
        featured: true,
      ),
      _Service(
        'Web Development',
        'Marketing sites, portals, and full-stack web apps using modern stacks.',
        Icons.web,
        tags: ['SEO', 'Responsive', 'Full-Stack'],
      ),
      _Service(
        'Mobile App Development',
        'Android & iOS apps with Flutter for rapid, native-feeling experiences.',
        Icons.phone_android,
        tags: ['Flutter', 'Android', 'iOS'],
        featured: true,
      ),
      _Service(
        'IT Consulting',
        'Architecture reviews, cloud migration, DevOps, and technology strategy.',
        Icons.support_agent,
        tags: ['Cloud', 'DevOps', 'Roadmap'],
      ),
      _Service(
        'Cyber Security (See dedicated tab)',
        'VAPT, penetration testing, SOC setup, SIEM, endpoint hardening, and audits.',
        Icons.security,
        tags: ['VAPT', 'SOC/SIEM', 'Hardening'],
      ),
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      children: [
        const _ServicesHero(),
        const SizedBox(height: 18),
        const _QuickChips(),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final cols = constraints.maxWidth > 1100
                ? 3
                : constraints.maxWidth > 740
                ? 2
                : 1;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: services.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                mainAxisExtent: 260, // ↑ taller to prevent overflow
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (_, i) => _ServiceCard(s: services[i]),
            );
          },
        ),
        const SizedBox(height: 24),
        const _BottomCTA(),
      ],
    );
  }
}

/// ===== Top hero with brand gradient & logo =====
class _ServicesHero extends StatelessWidget {
  const _ServicesHero();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final txt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primary, cs.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: LayoutBuilder(
        builder: (context, c) {
          final isNarrow = c.maxWidth < 900;

          final logo = ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/logo.png', // your logo
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          );

          final textCol = Column(
            crossAxisAlignment:
            isNarrow ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Text(
                'Our Services',
                textAlign: isNarrow ? TextAlign.center : TextAlign.start,
                style: txt.headlineMedium?.copyWith(
                  color: cs.onPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Design → Build → Secure → Scale',
                textAlign: isNarrow ? TextAlign.center : TextAlign.start,
                style: txt.titleMedium?.copyWith(
                  color: cs.onPrimary.withOpacity(.95),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Product-grade engineering with security-first practices. Web, mobile, cloud and DevOps — delivered iteratively.',
                textAlign: isNarrow ? TextAlign.center : TextAlign.start,
                style: txt.bodyLarge?.copyWith(color: cs.onPrimary),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/contact'),
                    icon: const Icon(Icons.rocket_launch),
                    label: const Text('Start a Project'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/about'),
                    icon: const Icon(Icons.info_outline),
                    label: const Text('About Us'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: cs.onPrimary,
                      side: BorderSide(color: cs.onPrimary.withOpacity(.7)),
                    ),
                  ),
                ],
              ),
            ],
          );

          return isNarrow
              ? Column(children: [
            logo,
            const SizedBox(height: 14),
            textCol,
          ])
              : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              logo,
              const SizedBox(width: 18),
              Expanded(child: textCol),
            ],
          );
        },
      ),
    );
  }
}

/// ===== Decorative quick chips =====
class _QuickChips extends StatelessWidget {
  const _QuickChips();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const chips = [
      'Flutter',
      'React',
      'Node.js',
      'Cloud & DevOps',
      'VAPT',
      'Dashboards',
    ];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: chips
          .map((t) => Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: cs.secondaryContainer,
          border: Border.all(color: cs.outlineVariant),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.blur_on, size: 16),
          const SizedBox(width: 6),
          Text(
            t,
            style: TextStyle(color: cs.onSecondaryContainer),
          ),
        ]),
      ))
          .toList(),
    );
  }
}

/// ===== Model =====
class _Service {
  final String title;
  final String desc;
  final IconData icon;
  final List<String> tags;
  final bool featured;
  const _Service(this.title, this.desc, this.icon,
      {this.tags = const [], this.featured = false});
}

/// ===== Card (animated + hover, safe text clamps) =====
class _ServiceCard extends StatefulWidget {
  const _ServiceCard({required this.s});
  final _Service s;

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final s = widget.s;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 140),
        scale: _hover ? 1.02 : 1.0,
        child: Card(
          elevation: _hover ? 3 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: _hover ? cs.primary.withOpacity(.35) : cs.outlineVariant,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed('/contact'),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  // tiny top accent bar
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 3,
                      color: s.featured
                          ? cs.primary
                          : cs.primary.withOpacity(.25),
                    ),
                  ),
                  // badge
                  if (s.featured)
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: cs.primaryContainer,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                    /*    child: Text(
                          '',
                          style: TextStyle(
                            color: cs.onPrimaryContainer,
                            fontWeight: FontWeight.w700,
                          ),
                        ),*/
                      ),
                    ),
                  // content
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _IconBadge(icon: s.icon),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              s.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        s.desc,
                        maxLines: 3, // clamp to avoid overflow
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      if (s.tags.isNotEmpty) ...[
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: s.tags
                              .take(3) // limit pills
                              .map((t) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            decoration: BoxDecoration(
                              color: cs.secondaryContainer,
                              border: Border.all(
                                  color: cs.outlineVariant),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              t,
                              style: TextStyle(
                                color: cs.onSecondaryContainer,
                                fontSize: 12,
                              ),
                            ),
                          ))
                              .toList(),
                        ),
                      ],
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton.icon(
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/contact'),
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Get Quote'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// circular icon with brand tint
class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: cs.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Icon(icon, color: cs.onSecondaryContainer),
    );
  }
}

/// ===== Bottom CTA =====
class _BottomCTA extends StatelessWidget {
  const _BottomCTA();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: LayoutBuilder(
          builder: (context, c) {
            final isNarrow = c.maxWidth < 900;
            final left = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Not sure where to start?',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                      color: cs.primary, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Tell us your goals and constraints. We’ll map a pragmatic approach with scope, timelines and costs.',
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/contact'),
                      icon: const Icon(Icons.send),
                      label: const Text('Get a Quote'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/about'),
                      icon: const Icon(Icons.info_outline),
                      label: const Text('About Company'),
                    ),
                  ],
                ),
              ],
            );

            final right = const _ContactMini();

            return isNarrow
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                left,
                const SizedBox(height: 16),
                right,
              ],
            )
                : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: left),
                const SizedBox(width: 24),
                Expanded(child: right),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ContactMini extends StatelessWidget {
  const _ContactMini();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: const [
        _IconText(icon: Icons.phone, text: '+91 7899347270'),
        _IconText(icon: Icons.mail, text: 'support@hashbaytechnology.co.in'),
      ],
    );
  }
}

class _IconText extends StatelessWidget {
  const _IconText({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 18),
      const SizedBox(width: 8),
      Text(text),
    ]);
  }
}
