import 'package:flutter/material.dart';

import '../theme.dart';
import 'home.dart';
import 'onboarding.dart';

class AuthScreen extends StatelessWidget {
  final bool createAccount;
  const AuthScreen({super.key, this.createAccount = true});

  void _continue(BuildContext context) {
    final next = createAccount ? const AccountTypeScreen() : const HomeScreen();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => next),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/coach-role.png', fit: BoxFit.cover),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x42000000), Color(0xFF0B0D0C)],
                stops: [0.05, 0.62],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton.filledTonal(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  const Spacer(),
                  Text('ENVISION', style: ts(11, w: FontWeight.w800, ls: 3)),
                  const SizedBox(height: 14),
                  Text(
                    createAccount
                        ? 'Start building\nyour strongest self.'
                        : 'Welcome back.',
                    style: ts(40, w: FontWeight.w800, h: 1.02, ls: -1.5),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    createAccount
                        ? 'Your plan, coach, nutrition, and progress—connected from day one.'
                        : 'Sign in to pick up exactly where you left off.',
                    style: ts(15, color: EC.text2, h: 1.45),
                  ),
                  const SizedBox(height: 28),
                  _ProviderButton(
                    label: 'Continue with Apple',
                    icon: Icons.apple,
                    filled: true,
                    onTap: () => _continue(context),
                  ),
                  const SizedBox(height: 10),
                  _ProviderButton(
                    label: 'Continue with Google',
                    letter: 'G',
                    onTap: () => _continue(context),
                  ),
                  const SizedBox(height: 10),
                  _ProviderButton(
                    label: 'Continue with email',
                    icon: Icons.mail_outline_rounded,
                    onTap: () => _continue(context),
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: Text(
                      'By continuing, you agree to our Terms and Privacy Policy.',
                      textAlign: TextAlign.center,
                      style: ts(11, color: EC.text2, h: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProviderButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final String? letter;
  final bool filled;
  final VoidCallback onTap;
  const _ProviderButton({
    required this.label,
    required this.onTap,
    this.icon,
    this.letter,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          backgroundColor: filled ? EC.text : EC.card2,
          foregroundColor: filled ? EC.bg : EC.text,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: filled ? EC.text : EC.border),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, size: 22),
            if (letter != null)
              Text(letter!, style: ts(18, w: FontWeight.w800)),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: ts(
                  15,
                  w: FontWeight.w700,
                  color: filled ? EC.bg : EC.text,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
