import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      children: const [
        _AboutCompanySection(),   // NEW top section (replaces Hero + Stats)
        SizedBox(height: 28),
        _ValuesSection(),
        SizedBox(height: 28),
        _CapabilitiesGrid(),
        SizedBox(height: 28),
        _TrustBadges(),
        SizedBox(height: 28),
        _ContactCtaCard(),
      ],
    );
  }
}

/// ====================== ABOUT COMPANY (NEW) ======================
class _AboutCompanySection extends StatelessWidget {
  const _AboutCompanySection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final txt = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: LayoutBuilder(builder: (context, c) {
          final isNarrow = c.maxWidth < 980;

          final left = Column(
            crossAxisAlignment:
            isNarrow ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Text(
                'About Company',
                textAlign: isNarrow ? TextAlign.center : TextAlign.start,
                style: txt.headlineSmall?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Hashbay Technology is a full-stack software company delivering high-quality solutions across web, mobile, and cloud. '
                    'We combine engineering excellence with security-first practices and clear, business-outcome driven execution.',
                textAlign: isNarrow ? TextAlign.center : TextAlign.start,
                style: txt.titleMedium,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: const [
                  _CheckChip(text: 'Custom Web & Mobile Apps'),
                  _CheckChip(text: 'Cloud, DevOps & Observability'),
                  _CheckChip(text: 'ERP/CRM & Integrations'),
                  _CheckChip(text: 'Cyber Security: VAPT & Hardening'),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'We ship iteratively with an emphasis on maintainability, performance, and security. '
                    'From MVPs to enterprise platforms, our teams partner with you to plan the roadmap, deliver reliably, and support post-launch growth.',
                textAlign: isNarrow ? TextAlign.center : TextAlign.start,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: () => Navigator.of(context).pushNamed('/contact'),
                    icon: const Icon(Icons.send),
                    label: const Text('Talk to Us'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/services'),
                    icon: const Icon(Icons.apps),
                    label: const Text('Explore Services'),
                  ),
                ],
              ),
            ],
          );

          final right = Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/logo.png', // your logo path
                  height: 130,
                  width: 130,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              _KeyFacts(cs: cs),
            ],
          );

          return isNarrow
              ? Column(
            children: [
              right,
              const SizedBox(height: 18),
              left,
            ],
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: left),
              const SizedBox(width: 24),
              right,
            ],
          );
        }),
      ),
    );
  }
}

class _KeyFacts extends StatelessWidget {
  const _KeyFacts({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('60+', 'Projects Delivered'),
      ('4.9/5', 'Client Rating'),
      ('99.9%', 'Uptime Targets'),
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: items
          .map(
            (e) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: cs.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(e.$1,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w800)),
              Text(e.$2, style: TextStyle(color: cs.onSecondaryContainer)),
            ],
          ),
        ),
      )
          .toList(),
    );
  }
}

class _CheckChip extends StatelessWidget {
  const _CheckChip({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: cs.secondaryContainer,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.check_circle_outline,
            size: 16, color: cs.onSecondaryContainer),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: cs.onSecondaryContainer)),
      ]),
    );
  }
}

/// =========================== VALUES ===========================
class _ValuesSection extends StatelessWidget {
  const _ValuesSection();

  @override
  Widget build(BuildContext context) {
    final values = const [
      ('Quality', 'Clean architecture, reviews and CI ensure long-term maintainability.', Icons.verified),
      ('Security', 'Threat modeling, VAPT and hardening by default.', Icons.security),
      ('Ownership', 'We act like partners—clear communication, predictable delivery.', Icons.handshake),
      ('Velocity', 'Agile sprints, frequent demos and rapid iteration.', Icons.bolt),
      ('Transparency', 'Roadmaps, sprint notes and metrics you can see.', Icons.visibility),
    ];

    return _SectionCard(
      title: 'Our Values',
      subtitle: 'Principles that guide how we work and deliver.',
      child: LayoutBuilder(builder: (context, c) {
        final cols = c.maxWidth > 1100 ? 3 : c.maxWidth > 740 ? 2 : 1;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: values.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            mainAxisExtent: 150,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemBuilder: (_, i) {
            final (title, desc, icon) = values[i];
            return _BulletCard(icon: icon, title: title, desc: desc);
          },
        );
      }),
    );
  }
}

/// ======================= CAPABILITIES =======================
class _CapabilitiesGrid extends StatelessWidget {
  const _CapabilitiesGrid();

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('Product & UX', 'User research, wireframes, prototypes.', Icons.design_services),
      ('Web & Mobile', 'Flutter, React, APIs, app stores.', Icons.phone_android),
      ('Cloud & DevOps', 'CI/CD, Terraform, containers, observability.', Icons.cloud),
      ('Data & BI', 'ETL, warehouses, dashboards.', Icons.analytics_outlined),
      ('Integrations', 'Payments, logistics, ERP/CRM.', Icons.hub),
      ('Cyber Security', 'VAPT, SOC/SIEM, hardening & training.', Icons.shield_moon),
    ];

    return _SectionCard(
      title: 'What We Do',
      subtitle:
      'Custom software, modern websites & apps, cloud engineering and security services.',
      child: LayoutBuilder(builder: (context, c) {
        final cols = c.maxWidth > 1100 ? 3 : c.maxWidth > 740 ? 2 : 1;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            mainAxisExtent: 160,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemBuilder: (_, i) {
            final (title, desc, icon) = items[i];
            return _BulletCard(
              icon: icon,
              title: title,
              desc: desc,
              cta: TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/contact'),
                child: const Text('Discuss'),
              ),
            );
          },
        );
      }),
    );
  }
}

/// ========================= TRUST =========================
class _TrustBadges extends StatelessWidget {
  const _TrustBadges();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final badges = const [
      (Icons.verified_user, 'ISO-ready practices'),
      (Icons.lock_clock, 'Secure SDLC'),
      (Icons.settings_backup_restore, 'Disaster Recovery'),
      (Icons.support, 'SLA Support'),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: badges
              .map(
                (b) => Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: cs.secondaryContainer,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: cs.outlineVariant),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(b.$1, size: 18, color: cs.onSecondaryContainer),
                const SizedBox(width: 8),
                Text(b.$2, style: TextStyle(color: cs.onSecondaryContainer)),
              ]),
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}

/// =========================== CTA ===========================
class _ContactCtaCard extends StatelessWidget {
  const _ContactCtaCard();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: LayoutBuilder(builder: (context, c) {
          final isNarrow = c.maxWidth < 900;

          final left = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Let’s build something great.',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: cs.primary, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              const Text(
                'Tell us about your goals—product, platform or transformation. We’ll propose a path with timelines and costs.',
              ),
              const SizedBox(height: 14),
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
                        Navigator.of(context).pushNamed('/services'),
                    icon: const Icon(Icons.apps),
                    label: const Text('Explore Services'),
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
        }),
      ),
    );
  }
}

/// ========================= HELPERS =========================
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w800,
                )),
            const SizedBox(height: 6),
            Text(subtitle),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _BulletCard extends StatelessWidget {
  const _BulletCard({
    required this.icon,
    required this.title,
    required this.desc,
    this.cta,
  });

  final IconData icon;
  final String title;
  final String desc;
  final Widget? cta;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(icon, color: cs.primary),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style:
                const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
          ]),
          const SizedBox(height: 8),
          Text(desc),
          const Spacer(),
          if (cta != null) Align(alignment: Alignment.bottomRight, child: cta!),
        ]),
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
