import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _company = TextEditingController();
  final _message = TextEditingController();

  String? _service;
  String? _budget;
  String _timeline = 'ASAP';
  bool _agree = true;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _company.dispose();
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final txt = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      children: [
        // ===== Hero =====
        Container(
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [cs.primary, cs.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Let’s talk',
                  style: txt.headlineMedium?.copyWith(
                    color: cs.onPrimary,
                    fontWeight: FontWeight.w900,
                  )),
              const SizedBox(height: 6),
              Text(
                'Tell us about your project. We usually reply within one business day.',
                style: txt.titleMedium?.copyWith(color: cs.onPrimary),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: () => Navigator.of(context).pushNamed('/services'),
                    icon: const Icon(Icons.apps),
                    label: const Text('Explore Services'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).pushNamed('/about'),
                    icon: const Icon(Icons.info_outline),
                    label: const Text('About Company'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: cs.onPrimary,
                      side: BorderSide(color: cs.onPrimary.withOpacity(.7)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // ===== Content columns (Form + Info) =====
        LayoutBuilder(builder: (context, c) {
          final isWide = c.maxWidth >= 980;

          final formCard = _ContactFormCard(
            formKey: _formKey,
            name: _name,
            email: _email,
            phone: _phone,
            company: _company,
            message: _message,
            service: _service,
            budget: _budget,
            timeline: _timeline,
            agree: _agree,
            onServiceChanged: (v) => setState(() => _service = v),
            onBudgetChanged: (v) => setState(() => _budget = v),
            onTimelineChanged: (v) => setState(() => _timeline = v),
            onAgreeChanged: (v) => setState(() => _agree = v ?? false),
            onSubmit: _submit,
          );

          final infoCol = const _ContactSidebar();

          return isWide
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 6, child: formCard),
              const SizedBox(width: 16),
              Expanded(flex: 4, child: infoCol),
            ],
          )
              : Column(
            children: [
              formCard,
              const SizedBox(height: 16),
              infoCol,
            ],
          );
        }),
      ],
    );
  }

  void _submit() {
    if ((_formKey.currentState?.validate() ?? false) && _agree) {
      final name = _name.text.trim();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Thanks, $name! We’ll get back to you soon."),
        ),
      );
      _formKey.currentState?.reset();
      _name.clear();
      _email.clear();
      _phone.clear();
      _company.clear();
      _message.clear();
      setState(() {
        _service = null;
        _budget = null;
        _timeline = 'ASAP';
        _agree = true;
      });
    } else if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to be contacted.')),
      );
    }
  }
}

/// ============================ FORM CARD ============================
class _ContactFormCard extends StatelessWidget {
  const _ContactFormCard({
    required this.formKey,
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
    required this.message,
    required this.service,
    required this.budget,
    required this.timeline,
    required this.agree,
    required this.onServiceChanged,
    required this.onBudgetChanged,
    required this.onTimelineChanged,
    required this.onAgreeChanged,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController phone;
  final TextEditingController company;
  final TextEditingController message;

  final String? service;
  final String? budget;
  final String timeline;
  final bool agree;

  final ValueChanged<String?> onServiceChanged;
  final ValueChanged<String?> onBudgetChanged;
  final ValueChanged<String> onTimelineChanged;
  final ValueChanged<bool?> onAgreeChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Contact Us',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: cs.primary, fontWeight: FontWeight.w800)),
              const SizedBox(height: 14),

              // Name + Email
              _Row2(
                left: _field(
                  context,
                  label: 'Name',
                  controller: name,
                  textInputAction: TextInputAction.next,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Enter your name'
                      : null,
                ),
                right: _field(
                  context,
                  label: 'Email',
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    final t = v?.trim() ?? '';
                    final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(t);
                    return ok ? null : 'Enter a valid email';
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Phone + Company
              _Row2(
                left: _field(
                  context,
                  label: 'Phone',
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    final t = (v ?? '').replaceAll(RegExp(r'\s+'), '');
                    return (t.length >= 7 && t.length <= 15)
                        ? null
                        : 'Enter a valid phone';
                  },
                ),
                right: _field(
                  context,
                  label: 'Company (optional)',
                  controller: company,
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(height: 12),

              // Service + Budget
              _Row2(
                left: DropdownButtonFormField<String>(
                  value: service,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Service',
                    hintText: 'e.g., Web Development',
                  ),
                  items: const [
                    'Web Development',
                    'Mobile App Development',
                    'Custom Software / ERP / CRM',
                    'Cloud & DevOps',
                    'Cyber Security (VAPT/SOC)',
                    'Data & Dashboards',
                    'Other',
                  ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: onServiceChanged,
                ),
                right: DropdownButtonFormField<String>(
                  value: budget,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Budget',
                    hintText: 'Select an estimated range',
                  ),
                  items: const [
                    '₹50k – ₹2L',
                    '₹2L – ₹5L',
                    '₹5L – ₹10L',
                    '₹10L+',
                    'Undecided',
                  ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: onBudgetChanged,
                ),
              ),
              const SizedBox(height: 12),

              // Timeline chips
              Text('Timeline', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final t in const ['ASAP', '1–2 months', '3–6 months', 'Exploring'])
                    ChoiceChip(
                      label: Text(t),
                      selected: timeline == t,
                      onSelected: (_) => onTimelineChanged(t),
                    )
                ],
              ),
              const SizedBox(height: 12),

              // Message
              _field(
                context,
                label: 'Message',
                controller: message,
                maxLines: 6,
                hint:
                'Briefly describe your goals, scope, and any links (if available).',
              ),
              const SizedBox(height: 12),

              // Consent
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: agree,
                onChanged: onAgreeChanged,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text(
                    'I agree to be contacted about my inquiry (email/phone).'),
              ),
              const SizedBox(height: 8),

              // Actions
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: onSubmit,
                    icon: const Icon(Icons.send),
                    label: const Text('Send'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).pushNamed('/services'),
                    icon: const Icon(Icons.apps),
                    label: const Text('Explore Services'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
      BuildContext context, {
        required String label,
        String? hint,
        TextEditingController? controller,
        TextInputType? keyboardType,
        TextInputAction? textInputAction,
        int maxLines = 1,
        String? Function(String?)? validator,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }
}

class _Row2 extends StatelessWidget {
  const _Row2({required this.left, required this.right});
  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final isNarrow = c.maxWidth < 600;
      return isNarrow
          ? Column(
        children: [
          left,
          const SizedBox(height: 12),
          right,
        ],
      )
          : Row(
        children: [
          Expanded(child: left),
          const SizedBox(width: 12),
          Expanded(child: right),
        ],
      );
    });
  }
}

/// ============================ SIDEBAR INFO ============================
class _ContactSidebar extends StatelessWidget {
  const _ContactSidebar();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      children: [
        // Quick contact cards
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                _InfoChip(icon: Icons.phone, title: 'Call', value: '+91 7899347270'),
                _InfoChip(icon: Icons.mail, title: 'Email', value: 'support@hashbaytechnology.co.in'),

                _InfoChip(icon: Icons.place, title: 'Location', value: 'Bangalore, Karnataka, India'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Availability / SLA
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: cs.secondaryContainer,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: cs.outlineVariant),
                  ),
                  child: Icon(Icons.schedule, color: cs.onSecondaryContainer),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Availability: Mon–Sat, 10:00–18:00 IST\nTypical first response: < 1 business day',
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Map placeholder / office card
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: cs.secondaryContainer,
                height: 140,
                alignment: Alignment.center,
                child: Icon(Icons.map, size: 48, color: cs.onSecondaryContainer),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Our office is in Bangalore, Karnataka. Remote-friendly; we work with clients across India & globally.',
                ),
              )
            ],
          ),



        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.title, required this.value});
  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cs.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 18, color: cs.onSecondaryContainer),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: cs.onSecondaryContainer)),
            Text(value, style: TextStyle(color: cs.onSecondaryContainer)),
          ],
        ),
      ]),
    );
  }
}
