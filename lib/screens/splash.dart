import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme.dart';
import 'welcome.dart';

/// Dark performance-led splash with subtle kinetic energy.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(seconds: 6))
        ..repeat();

  // dx, dy (fraction of width/height from centre), diameter, phase
  static const _bubbles = <List<double>>[
    [0.10, -0.20, 132, 0.0],
    [-0.20, -0.08, 84, 1.3],
    [0.30, -0.02, 62, 2.1],
    [-0.02, -0.34, 40, 3.0],
    [0.20, -0.38, 24, 0.8],
    [-0.30, -0.28, 28, 2.6],
    [0.02, -0.02, 20, 1.9],
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3200), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, __, ___) => const WelcomeScreen(),
        transitionsBuilder: (_, a, __, child) =>
            FadeTransition(opacity: a, child: child),
      ));
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF111A13), Color(0xFF0B0D0C), Color(0xFF050605)],
          ),
        ),
        child: Stack(children: [
          // sun glow
          Positioned(
            left: -80,
            top: -80,
            child: Container(
              width: 340,
              height: 340,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  Colors.white.withOpacity(0.55),
                  Colors.white.withOpacity(0.0)
                ]),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _c,
            builder: (_, __) => Stack(children: [
              for (final b in _bubbles)
                Positioned(
                  left: size.width / 2 +
                      b[0] * size.width -
                      b[2] / 2 +
                      math.sin(_c.value * 2 * math.pi + b[3]) * 6,
                  top: size.height * 0.42 +
                      b[1] * size.height -
                      b[2] / 2 +
                      math.cos(_c.value * 2 * math.pi + b[3]) * 10,
                  child: _Bubble(b[2]),
                ),
            ]),
          ),
          Align(
            alignment: const Alignment(0, 0.42),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: EC.orange,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                            color: EC.orange.withOpacity(.28), blurRadius: 34)
                      ]),
                  child: Icon(Icons.bolt_rounded, color: EC.bg, size: 40)),
              const SizedBox(height: 8),
              Text('ENVISION',
                  style: ts(19, w: FontWeight.w800, color: EC.text, ls: 5)),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final double d;
  const _Bubble(this.d);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: d,
      height: d,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: EC.orange.withOpacity(0.24), width: 1.2),
        gradient: RadialGradient(
          center: const Alignment(-0.4, -0.45),
          radius: 0.95,
          colors: [
            EC.orange.withOpacity(0.20),
            EC.orange.withOpacity(0.04),
            const Color(0xFF172016).withOpacity(0.16),
          ],
          stops: const [0.0, 0.45, 1.0],
        ),
        boxShadow: [
          BoxShadow(
              color: EC.orange.withOpacity(0.08),
              blurRadius: d * 0.25,
              offset: Offset(0, d * 0.1)),
        ],
      ),
      // iridescent tint
      foregroundDecoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(colors: [
          const Color(0xFFFFC6E8).withOpacity(0.18),
          const Color(0xFFC6F0FF).withOpacity(0.18),
          const Color(0xFFFFF3C6).withOpacity(0.15),
          const Color(0xFFFFC6E8).withOpacity(0.18),
        ]),
      ),
    );
  }
}
