import 'package:flutter/material.dart';

class CyberSecurityPage extends StatelessWidget {
  const CyberSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      children: const [
        _HeroBannerAlt(),
        SizedBox(height: 22),
        _RedBlueCards(),
        SizedBox(height: 22),
        _OfferingAccordion(),
        SizedBox(height: 22),
        _PackagesSection(),
        SizedBox(height: 22),
        _ComplianceStrip(),
        SizedBox(height: 22),
        _InlineCTA(),
      ],
    );
  }
}

/// ======================= DARK HERO (Different look) =======================
class _HeroBannerAlt extends StatelessWidget {
  const _HeroBannerAlt();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final txt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primary.withOpacity(.95), Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: LayoutBuilder(
        builder: (context, c) {
          final isNarrow = c.maxWidth < 900;

          final left = Column(
            crossAxisAlignment:
            isNarrow ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Text(
                'Cyber Security',
                style: txt.displaySmall?.copyWith(
                  color: cs.onPrimary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: .4,
                ),
                textAlign: isNarrow ? TextAlign.center : TextAlign.start,
              ),
              const SizedBox(height: 8),
              Text(
                'Offense + Defense = Resilience',
                style: txt.titleMedium?.copyWith(
                  color: cs.onPrimary.withOpacity(.9),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: isNarrow ? TextAlign.center : TextAlign.start,
              ),
              const SizedBox(height: 12),
              Text(
                'From VAPT to managed detection & response, we harden apps, clouds and endpoints with a security-first approach.',
                style: txt.bodyLarge?.copyWith(color: cs.onPrimary),
                textAlign: isNarrow ? TextAlign.center : TextAlign.start,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/contact'),
                    icon: const Icon(Icons.shield),
                    label: const Text('Request Assessment'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/about'),
                    icon: const Icon(Icons.info_outline),
                    label: const Text('About Company'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: cs.onPrimary,
                      side: BorderSide(color: cs.onPrimary.withOpacity(.6)),
                    ),
                  ),
                ],
              ),
            ],
          );

          final right = Opacity(
            opacity: .18,
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.shield_moon, size: 160, color: cs.onPrimary),
            ),
          );

          return isNarrow
              ? Column(children: [left, const SizedBox(height: 12), right])
              : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: left),
              const SizedBox(width: 20),
              SizedBox(width: 160, child: right),
            ],
          );
        },
      ),
    );
  }
}

/// ======================= RED vs BLUE (distinct layout) =======================
class _RedBlueCards extends StatelessWidget {
  const _RedBlueCards();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return LayoutBuilder(builder: (context, c) {
      final twoCol = c.maxWidth >= 900;
      final red = _SideCard(
        title: 'Red Team (Offense)',
        color: cs.error,
        items: const [
          'Vulnerability Assessment & Pentest (Web/Mobile/API)',
          'Auth bypass, IDOR, RCE & data-exfiltration attempts',
          'Exploit proofs, risk rating & fixes',
        ],
        icon: Icons.flag,
      );
      final blue = _SideCard(
        title: 'Blue Team (Defense)',
        color: cs.primary,
        items: const [
          'Managed SOC & SIEM — alert triage & incident response',
          'Cloud & endpoint hardening, patch SLAs',
          'Zero-trust network segments & IAM least privilege',
        ],
        icon: Icons.security,
      );

      return twoCol
          ? Row(children: [
        Expanded(child: red),
        const SizedBox(width: 16),
        Expanded(child: blue),
      ])
          : Column(children: [
        red,
        const SizedBox(height: 16),
        blue,
      ]);
    });
  }
}

class _SideCard extends StatelessWidget {
  const _SideCard({
    required this.title,
    required this.items,
    required this.color,
    required this.icon,
  });

  final String title;
  final List<String> items;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cs.outlineVariant),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 6,
            child: Container(color: color),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: color.withOpacity(.12),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: color.withOpacity(.35)),
                    ),
                    child: Icon(icon, color: color),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                  ),
                ]),
                const SizedBox(height: 10),
                ...items.map((t) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle_outline,
                          size: 16, color: color),
                      const SizedBox(width: 8),
                      Expanded(child: Text(t)),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ======================= OFFERINGS as ACCORDION (no grid) =======================
class _OfferingAccordion extends StatefulWidget {
  const _OfferingAccordion();

  @override
  State<_OfferingAccordion> createState() => _OfferingAccordionState();
}

class _OfferingAccordionState extends State<_OfferingAccordion> {
  final List<_AccordionItem> _items = const [
    _AccordionItem(
      id: 1,
      header: 'VAPT — Web, Mobile, API & Network',
      bodyBullets: [
        'Coverage aligned to OWASP ASVS & Top 10',
        'Authenticated + role-based testing',
        'Exploit proofs, risk rating, and remediation',
      ],
      icon: Icons.search,
    ),
    _AccordionItem(
      id: 2,
      header: 'Managed SOC & SIEM',
      bodyBullets: [
        'Log pipelines (apps, infra, cloud)',
        'Correlation rules, alert triage and IR playbooks',
        'Weekly reports & posture tuning',
      ],
      icon: Icons.shield,
    ),
    _AccordionItem(
      id: 3,
      header: 'Cloud Security (AWS/GCP/Azure/K8s)',
      bodyBullets: [
        'CIS Benchmarks, IAM least privilege',
        'Workload protections & image scanning',
        'Posture management & guardrails',
      ],
      icon: Icons.cloud,
    ),
    _AccordionItem(
      id: 4,
      header: 'Endpoint & Network Hardening',
      bodyBullets: [
        'EDR baselines & patch SLAs',
        'Zero-trust segmentation',
        'Policy reviews & MDM',
      ],
      icon: Icons.memory,
    ),
    _AccordionItem(
      id: 5,
      header: 'Compliance & Audits',
      bodyBullets: [
        'ISO 27001 / SOC 2 / GDPR gap assessment',
        'Controls mapping & evidence prep',
        'Audit readiness & run-books',
      ],
      icon: Icons.verified_user,
    ),
    _AccordionItem(
      id: 6,
      header: 'Security Training',
      bodyBullets: [
        'Role-based tracks & phishing drills',
        'Developer secure-coding workshops',
        'Hands-on labs & code reviews',
      ],
      icon: Icons.school,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionPanelList.radio(
        dividerColor: Theme.of(context).dividerColor,
        elevation: 0,
        expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 2),
        animationDuration: const Duration(milliseconds: 200),
        children: _items
            .map((it) => ExpansionPanelRadio(
          value: it.id,
          canTapOnHeader: true,
          headerBuilder: (ctx, isOpen) => ListTile(
            leading: _IconBadge(icon: it.icon),
            title: Text(
              it.header,
              style: const TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
          body: Padding(
            padding:
            const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              children: [
                ...it.bodyBullets.map(
                      (b) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle_outline,
                            size: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .primary),
                        const SizedBox(width: 8),
                        Expanded(child: Text(b)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/contact'),
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Request Scope & Quote'),
                  ),
                ),
              ],
            ),
          ),
        ))
            .toList(),
      ),
    );
  }
}

class _AccordionItem {
  final int id;
  final String header;
  final List<String> bodyBullets;
  final IconData icon;
  const _AccordionItem({
    required this.id,
    required this.header,
    required this.bodyBullets,
    required this.icon,
  });
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: cs.secondaryContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Icon(icon, color: cs.onSecondaryContainer),
    );
  }
}

/// ======================= PRICING / PACKAGES (new visual) =======================
class _PackagesSection extends StatelessWidget {
  const _PackagesSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final cards = const [
      _Pkg(
        name: 'Essential VAPT',
        blurb:
        'One-time security test for a product (web/app/API). Includes retest.',
        bullets: [
          'OWASP coverage',
          'Exploit proofs',
          'Remediation guidance',
        ],
      ),
      _Pkg(
        name: 'Managed SOC',
        blurb:
        'Continuous monitoring and incident response with monthly reporting.',
        bullets: [
          'SIEM + rules',
          'Alert triage',
          'IR playbooks',
        ],
        highlight: true,
      ),
      _Pkg(
        name: 'Complete Shield',
        blurb:
        'Cloud + endpoints + monitoring + training. A full-spectrum program.',
        bullets: [
          'Hardening & baselines',
          'SOC/SIEM + IR',
          'Phishing + training',
        ],
      ),
    ];

    return LayoutBuilder(builder: (context, c) {
      final cols = c.maxWidth > 1100 ? 3 : c.maxWidth > 740 ? 2 : 1;
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cards.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.05,
        ),
        itemBuilder: (_, i) {
          final p = cards[i];
          return Card(
            elevation: p.highlight ? 3 : 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: p.highlight ? cs.primary : cs.outlineVariant,
                width: p.highlight ? 1.5 : 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (p.highlight)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: cs.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Most Popular',
                        style: TextStyle(
                            color: cs.onPrimaryContainer,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  if (p.highlight) const SizedBox(height: 10),
                  Text(p.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 18)),
                  const SizedBox(height: 8),
                  Text(p.blurb, maxLines: 3, overflow: TextOverflow.ellipsis),
                  const Spacer(),
                  ...p.bullets.map(
                        (b) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle_outline,
                              size: 16, color: cs.primary),
                          const SizedBox(width: 6),
                          Expanded(child: Text(b)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FilledButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/contact'),
                      child: const Text('Get Proposal'),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

class _Pkg {
  final String name;
  final String blurb;
  final List<String> bullets;
  final bool highlight;
  const _Pkg({
    required this.name,
    required this.blurb,
    required this.bullets,
    this.highlight = false,
  });
}

/// ======================= COMPLIANCE STRIP =======================
class _ComplianceStrip extends StatelessWidget {
  const _ComplianceStrip();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const items = [
      'OWASP ASVS',
      'MITRE ATT&CK',
      'CIS Benchmarks',
      'ISO 27001',
      'SOC 2',
      'NIST CSF',
      'GDPR',
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: items
              .map((t) => Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: cs.secondaryContainer,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.verified, size: 16),
              const SizedBox(width: 6),
              Text(t, style: TextStyle(color: cs.onSecondaryContainer)),
            ]),
          ))
              .toList(),
        ),
      ),
    );
  }
}

/// ======================= INLINE CTA =======================
class _InlineCTA extends StatelessWidget {
  const _InlineCTA();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: LayoutBuilder(builder: (context, c) {
          final narrow = c.maxWidth < 900;

          final left = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ready to raise your security bar?',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: cs.primary, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 6),
              const Text(
                'Send us your app scope and environments. We’ll share a prioritized plan with timelines and cost.',
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
                    label: const Text('Request Security Assessment'),
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

          return narrow
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
