import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets.dart';
import 'auth.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _enter(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => const AuthScreen(createAccount: false),
    ));
  }

  void _createAccount(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => const AuthScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EC.bg,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/welcome-coach.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, .46, .72, 1],
                    colors: [
                      Color(0x22000000),
                      Color(0x08000000),
                      Color(0xC60B0D0C),
                      Color(0xFF0B0D0C)
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        'Build the body.\nProve the work.',
                        style: ts(44, w: FontWeight.w800, h: .96, ls: -1.8),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Personal coaching, adaptive training, and nutrition that moves with you.',
                        style: ts(17, color: EC.text2, h: 1.4),
                      ),
                      const SizedBox(height: 26),
                      PillButton(
                        label: 'Get started',
                        icon: Icons.arrow_forward_rounded,
                        onTap: () => _createAccount(context),
                      ),
                      const SizedBox(height: 12),
                      PillButton(
                        label: 'Log in',
                        dark: true,
                        onTap: () => _enter(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
