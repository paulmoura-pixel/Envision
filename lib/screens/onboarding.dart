import 'package:flutter/material.dart';

import '../theme.dart';
import 'coach_dashboard.dart';
import 'home.dart';

class _OnboardingShell extends StatelessWidget {
  final int step;
  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget content;
  final Widget? footer;

  const _OnboardingShell({
    required this.step,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.content,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EC.bg,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                  child: Row(
                    children: [
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () => Navigator.maybePop(context),
                        icon: const Icon(Icons.arrow_back_rounded, size: 22),
                      ),
                      const Spacer(),
                      Text('$step of 3', style: ts(12, color: EC.text2)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: List.generate(3, (index) {
                      return Expanded(
                        child: Container(
                          height: 3,
                          margin: EdgeInsets.only(right: index == 2 ? 0 : 6),
                          color: index < step ? EC.orange : EC.border,
                        ),
                      );
                    }),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(24, 36, 24, 28),
                    children: [
                      Text(eyebrow.toUpperCase(),
                          style: ts(11,
                              w: FontWeight.w800,
                              color: EC.orangeDeep,
                              ls: 1.4)),
                      const SizedBox(height: 10),
                      Text(title,
                          style: ts(38, w: FontWeight.w800, h: 1.02, ls: -1.4)),
                      const SizedBox(height: 12),
                      Text(subtitle, style: ts(16, color: EC.text2, h: 1.45)),
                      const SizedBox(height: 32),
                      content,
                    ],
                  ),
                ),
                if (footer != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 10, 24, 18),
                    child: footer!,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _OnboardingShell(
      step: 1,
      eyebrow: 'Your experience',
      title: 'How will you use Envision?',
      subtitle:
          'Choose your starting point. You can connect with more people later.',
      content: Column(
        children: [
          _RoleCard(
            image: 'assets/images/coach-role.png',
            title: 'I coach people',
            subtitle:
                'Build programs, guide clients, and see progress between sessions.',
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const CoachSetupScreen())),
          ),
          const SizedBox(height: 16),
          _RoleCard(
            image: 'assets/images/welcome-coach.png',
            title: 'I’m training',
            subtitle:
                'Follow your plan, log nutrition, and stay connected to your coach.',
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ClientJoinScreen())),
          ),
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _RoleCard({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: title,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          height: 210,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xE6000000)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(children: [
                  Expanded(
                    child: Text(title,
                        style: ts(24,
                            w: FontWeight.w800, color: Colors.white, ls: -.5)),
                  ),
                  const Icon(Icons.arrow_forward_rounded,
                      color: Colors.white, size: 22),
                ]),
                const SizedBox(height: 6),
                Text(subtitle,
                    style: ts(13.5,
                        color: Colors.white.withOpacity(.78), h: 1.35)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CoachSetupScreen extends StatefulWidget {
  const CoachSetupScreen({super.key});

  @override
  State<CoachSetupScreen> createState() => _CoachSetupScreenState();
}

class _CoachSetupScreenState extends State<CoachSetupScreen> {
  int _type = 0;

  @override
  Widget build(BuildContext context) {
    return _OnboardingShell(
      step: 2,
      eyebrow: 'Coach setup',
      title: 'Create your training space',
      subtitle:
          'This becomes the private home for your clients, programs, and progress.',
      content: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const _Field(label: 'Training space name', value: 'Riverside Strength'),
        const SizedBox(height: 24),
        Text('How do you coach?', style: ts(14, w: FontWeight.w700)),
        const SizedBox(height: 10),
        Row(
          children: List.generate(3, (index) {
            final labels = ['In person', 'Online', 'Hybrid'];
            final selected = _type == index;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: index == 2 ? 0 : 8),
                child: InkWell(
                  onTap: () => setState(() => _type = index),
                  child: Container(
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected ? EC.orangeTint : EC.card,
                      border:
                          Border.all(color: selected ? EC.orange : EC.border),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(labels[index],
                        style: ts(12,
                            w: FontWeight.w700,
                            color: selected ? EC.orangeDeep : EC.text2)),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 24),
        const _Field(
            label: 'Primary specialty', value: 'Strength & conditioning'),
      ]),
      footer: _PrimaryAction(
        label: 'Create training space',
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const ReadyScreen(coach: true))),
      ),
    );
  }
}

class ClientJoinScreen extends StatelessWidget {
  const ClientJoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _OnboardingShell(
      step: 2,
      eyebrow: 'Connect with a coach',
      title: 'Join your training space',
      subtitle:
          'Enter the code your coach shared. You’ll confirm their identity before joining.',
      content: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const _Field(label: 'Invite code', value: 'RSF728'),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: EC.card,
            border: Border.all(color: EC.border),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(children: [
            Container(
              width: 48,
              height: 48,
              color: const Color(0xFFE9E2D8),
              child: const Icon(Icons.fitness_center_rounded, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text('Riverside Strength', style: ts(15, w: FontWeight.w700)),
                  const SizedBox(height: 3),
                  Text('Coach Taylor Kim · In-person coaching',
                      style: ts(12, color: EC.text2)),
                ])),
            const Icon(Icons.check_circle_rounded, color: EC.green, size: 21),
          ]),
        ),
        const SizedBox(height: 18),
        TextButton(
          onPressed: () => _finish(context),
          child: Text('I’ll connect later',
              style: ts(14, w: FontWeight.w700, color: EC.text2)),
        ),
      ]),
      footer: _PrimaryAction(
          label: 'Join training space',
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const ReadyScreen(coach: false)))),
    );
  }

  void _finish(BuildContext context) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const HomeScreen()), (_) => false);
  }
}

class ReadyScreen extends StatelessWidget {
  final bool coach;
  const ReadyScreen({super.key, required this.coach});

  @override
  Widget build(BuildContext context) {
    return _OnboardingShell(
      step: 3,
      eyebrow: 'You’re ready',
      title: coach ? 'Riverside Strength is ready.' : 'You’re connected.',
      subtitle: coach
          ? 'Share this private code with clients so they can request access to your space.'
          : 'Coach Taylor can now share programs and see only the data you choose to share.',
      content: Column(children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32),
          decoration: BoxDecoration(
            color: EC.card,
            border: Border.all(color: EC.border),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(children: [
            Icon(coach ? Icons.qr_code_2_rounded : Icons.verified_rounded,
                size: 74, color: EC.orange),
            const SizedBox(height: 16),
            Text(coach ? 'RSF728' : 'RIVERSIDE STRENGTH',
                style: ts(24, w: FontWeight.w800, ls: 2)),
          ]),
        ),
      ]),
      footer: _PrimaryAction(
        label: 'Go to dashboard',
        onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    coach ? const CoachDashboardScreen() : const HomeScreen()),
            (_) => false),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String value;
  const _Field({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: ts(13, w: FontWeight.w700)),
      const SizedBox(height: 8),
      TextFormField(
        initialValue: value,
        style: ts(15, w: FontWeight.w600),
        decoration: InputDecoration(
          filled: true,
          fillColor: EC.card,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: EC.border),
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: EC.orange),
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ]);
  }
}

class _PrimaryAction extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryAction({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: EC.orange,
          foregroundColor: EC.bg,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: ts(15, w: FontWeight.w800, color: EC.bg),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(label),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_rounded, size: 18),
        ]),
      ),
    );
  }
}
