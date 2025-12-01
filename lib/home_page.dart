import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context);

    // Brand theme (teal + amber)
    final brandScheme = base.colorScheme.copyWith(
      primary: const Color(0xFF0F9D8F),
      secondary: const Color(0xFFFFB300),
      onPrimary: Colors.white,
    );

    return Theme(
      data: base.copyWith(
        colorScheme: brandScheme,
        textTheme: base.textTheme.apply(
          bodyColor: base.colorScheme.onSurface,
          displayColor: base.colorScheme.onSurface,
        ),
        chipTheme: base.chipTheme.copyWith(
          side: BorderSide(color: base.colorScheme.outlineVariant),
        ),
        cardTheme: base.cardTheme.copyWith(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: base.dividerColor),
          ),
        ),
        useMaterial3: true,
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        children: const [

          _CompanyHighlight(), // NEW: Big section for Hashbay Technology
    /*      SizedBox(height: 32),
          _LogoBanner(),*/
          SizedBox(height: 32),
          _Hero(),
          SizedBox(height: 28),
          _ServicesStrip(),
          SizedBox(height: 32),
          _SoftwareSolutions(),
          SizedBox(height: 32),
          _CyberSecurityHighlights(),
          SizedBox(height: 32),
          _ProcessStrip(),
          SizedBox(height: 24),
          _TechStackChips(),
          SizedBox(height: 32),
          _BottomSection(),
           _Footer(),
        ],
      ),
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

/// ========================= HERO =========================
class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Build. Launch. Secure.',
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(color: cs.primary, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Text(
            'We craft custom software, modern web & mobile apps, provide IT consulting, and keep your business secure with dedicated cyber security services.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton(
                onPressed: () => Navigator.of(context).pushNamed('/services'),
                child: const Text('Our Services'),
              ),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pushNamed('/contact'),
                child: const Text('Contact Us'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// =================== COMPANY HIGHLIGHT (NEW) ===================
class _CompanyHighlight extends StatelessWidget {
  const _CompanyHighlight();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 18),
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("assets/images/1.jpg"), // your image path
    fit: BoxFit.cover, // adjust how the image fits
    ),
    ),
      child: LayoutBuilder(
        builder: (context, c) {
          final isNarrow = c.maxWidth < 900;

          final logo = ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/logo.png',
              height: 250,
              width: 250,
              fit: BoxFit.cover,
            ),
          );

          final textCol = Column(
            crossAxisAlignment:
            isNarrow ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Text(
                'Hashbay Technology',
                textAlign: isNarrow ? TextAlign.center : TextAlign.start,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Innovating Digital Solutions for Your Business Growth',
                textAlign: isNarrow ? TextAlign.center : TextAlign.start,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
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
                        Navigator.of(context).pushNamed('/services'),
                    icon: const Icon(Icons.apps),
                    label: const Text('Explore Services'),
                  ),
                ],
              ),
            ],
          );

          return isNarrow
              ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              logo,
              const SizedBox(height: 20),
              textCol,
            ],
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              logo,
              const SizedBox(width: 24),
              Expanded(child: textCol),
            ],
          );
        },
      ),
    );
  }
}

/// ======================== LOGO BANNER ========================
/*class _LogoBanner extends StatelessWidget {
  const _LogoBanner();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: LayoutBuilder(
          builder: (context, c) {
            final isNarrow = c.maxWidth < 720;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/logo.png',
                          height: 56,
                          width: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Flexible(
                        child: Text(
                          'Your Software Company',
                          style: Theme.of(context).textTheme.headlineSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isNarrow) const SizedBox(width: 16),
                if (!isNarrow)
                  Text(
                    'Custom Software • Web • Mobile • IT Consulting • Cyber Security',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}*/

/// ====================== SERVICES STRIP ======================
class _ServicesStrip extends StatelessWidget {
  const _ServicesStrip();

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('Custom Software Development', Icons.handyman),
      ('Web Development', Icons.web),
      ('Mobile App Development', Icons.phone_android),
      ('IT Consulting', Icons.support_agent),
      ('Cyber Security', Icons.security),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount =
        constraints.maxWidth > 1000 ? 5 : constraints.maxWidth > 700 ? 3 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 3.2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (_, i) {
            final (label, icon) = items[i];
            return Card(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

/// =================== SOFTWARE SOLUTIONS ===================
class _SoftwareSolutions extends StatelessWidget {
  const _SoftwareSolutions();

  @override
  Widget build(BuildContext context) {
    final items = const [
      (
      'ERP / CRM Systems',
      'End-to-end business suites: sales, inventory, billing, and analytics.'
      ),
      (
      'E-commerce Platforms',
      'High-performance storefronts, payment gateways, and OMS integration.'
      ),
      (
      'SaaS Product Development',
      'Multi-tenant architecture, subscriptions, metering & billing.'
      ),
      (
      'API & System Integration',
      'Connect ERPs, CRMs, payment, and logistics providers securely.'
      ),
      (
      'Cloud & DevOps',
      'CI/CD, IaC, auto-scaling, observability, and cost optimization.'
      ),
      (
      'Data & Dashboards',
      'ETL pipelines, warehousing, and insight-driven BI dashboards.'
      ),
    ];

    return _SectionCard(
      title: 'Software Solutions',
      subtitle: 'Robust, scalable, and maintainable software tailored to your business.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cols = constraints.maxWidth > 1100
              ? 3
              : constraints.maxWidth > 740
              ? 2
              : 1;
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
              final (title, desc) = items[i];
              return _BulletCard(
                icon: Icons.developer_mode,
                title: title,
                desc: desc,
                cta: TextButton(
                  onPressed: () => Navigator.of(context).pushNamed('/contact'),
                  child: const Text('Discuss'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// ================= CYBER SECURITY HIGHLIGHTS =================
class _CyberSecurityHighlights extends StatelessWidget {
  const _CyberSecurityHighlights();

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('VAPT (Web/Mobile/API/Network)', 'Identify & exploit vulnerabilities, then guide remediation.'),
      ('Managed SOC & SIEM', '24×7 monitoring, alert triage, and incident response.'),
      ('Cloud Security', 'Secure configs, IAM, workload protections & posture checks.'),
      ('Endpoint & Network Hardening', 'Policies, patching, EDR/AV, zero-trust, and least privilege.'),
      ('Compliance & Audits', 'ISO 27001, SOC 2, GDPR readiness and gap assessments.'),
      ('Security Training', 'Phishing drills and developer secure-coding workshops.'),
    ];

    return _SectionCard(
      title: 'Cyber Security',
      subtitle: 'Proactive defense to protect your apps, data, and customers.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cols = constraints.maxWidth > 1100
              ? 3
              : constraints.maxWidth > 740
              ? 2
              : 1;
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
              final (title, desc) = items[i];
              return _BulletCard(
                icon: Icons.security,
                title: title,
                desc: desc,
                cta: TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/cyber-security'),
                  child: const Text('Learn more'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// ========================= PROCESS STRIP =========================
class _ProcessStrip extends StatelessWidget {
  const _ProcessStrip();

  @override
  Widget build(BuildContext context) {
    final steps = const [
      ('Discover', 'Requirements, goals & stakeholder interviews.'),
      ('Design', 'UX/UI, architecture, backlog & milestones.'),
      ('Build', 'Agile sprints, demos, QA & automation.'),
      ('Secure', 'Threat modeling, tests & hardening.'),
      ('Launch', 'Release, monitor & optimize.'),

    ];

    return _SectionCard(
      title: 'Our Process',
      subtitle: 'Transparent, iterative and outcome-focused.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWrap = constraints.maxWidth < 1000;
          final children =
          steps.map((s) => _StepPill(title: s.$1, desc: s.$2)).toList();
          return isWrap
              ? Wrap(
            spacing: 12,
            runSpacing: 12,
            children: children,
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          );
        },
      ),
    );
  }
}

/// ========================= TECH STACK =========================
class _TechStackChips extends StatelessWidget {
  const _TechStackChips();

  @override
  Widget build(BuildContext context) {
    final chips = const [
      'Flutter',
      'Dart',
      'React',
      'Node.js',
      'Express',
      'MongoDB',
      'PostgreSQL',
      'Firebase',
      'AWS',
      'GCP',
      'Docker',
      'Kubernetes',
      'Grafana',
      'Prometheus',
      'Terraform',
      'NGINX'
    ];
    return _SectionCard(
      title: 'Tech Stack',
      subtitle: 'Modern tools for performance, reliability, and speed.',
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: chips
            .map(
              (t) => Chip(
            label: Text(t),
            avatar: const Icon(Icons.blur_on, size: 16),
          ),
        )
            .toList(),
      ),
    );
  }
}

/// ========================= BOTTOM SECTION =========================
class _BottomSection extends StatelessWidget {
  const _BottomSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: LayoutBuilder(builder: (context, c) {
          final isNarrow = c.maxWidth < 900;
          final left = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Why Choose Us',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              SizedBox(height: 8),
              _CheckLine('Product-grade architecture & clean code'),
              _CheckLine('Security first: reviews, tests & hardening'),
              _CheckLine('Clear communication and sprint demos'),
              _CheckLine('Post-launch support with SLAs'),
            ],
          );

          final right = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ready to start?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
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
              const SizedBox(height: 12),
              const _ContactMini(),
            ],
          );

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
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: cs.primary, fontWeight: FontWeight.w800)),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(icon, color: cs.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
            ]),
            const SizedBox(height: 8),
            Text(desc),
            const Spacer(),
            if (cta != null)
              Align(alignment: Alignment.bottomRight, child: cta!),
          ],
        ),
      ),
    );
  }
}

class _StepPill extends StatelessWidget {
  const _StepPill({required this.title, required this.desc});
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Theme.of(context).dividerColor),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.check_circle_outline, size: 18),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _CheckLine extends StatelessWidget {
  const _CheckLine(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.verified_outlined,
              size: 18, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
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
