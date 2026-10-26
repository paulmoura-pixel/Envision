import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'theme.dart';

/// White rounded card with soft shadow.
class EnvCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color? color;
  final VoidCallback? onTap;
  const EnvCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: onTap != null,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color ?? EC.card,
            borderRadius: BorderRadius.circular(EC.r),
            border: Border.all(color: EC.border),
            boxShadow: EC.shadow,
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Full-width orange pill button (56px).
class PillButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool dark;
  final IconData? icon;
  const PillButton(
      {super.key,
      required this.label,
      required this.onTap,
      this.dark = false,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 54,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: dark ? EC.card2 : EC.orange,
            borderRadius: BorderRadius.circular(14),
            border: dark ? Border.all(color: EC.border) : null,
            boxShadow: dark
                ? null
                : [
                    BoxShadow(
                        color: EC.orange.withOpacity(0.18),
                        blurRadius: 12,
                        offset: const Offset(0, 5))
                  ],
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: dark ? EC.text : EC.bg),
              const SizedBox(width: 8),
            ],
            Text(label,
                style:
                    ts(17, w: FontWeight.w700, color: dark ? EC.text : EC.bg)),
          ]),
        ),
      ),
    );
  }
}

/// Animated circular progress ring.
class RingGauge extends StatelessWidget {
  final double progress; // 0..1
  final double size;
  final double stroke;
  final Color color;
  final Widget? child;
  const RingGauge({
    super.key,
    required this.progress,
    this.size = 120,
    this.stroke = 10,
    this.color = EC.orange,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: progress.clamp(0.0, 1.0)),
      duration: const Duration(milliseconds: 1100),
      curve: Curves.easeOutCubic,
      builder: (_, v, __) => SizedBox(
        width: size,
        height: size,
        child: Stack(alignment: Alignment.center, children: [
          CustomPaint(
              size: Size.square(size), painter: _RingPainter(v, stroke, color)),
          if (child != null) child!,
        ]),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double p;
  final double stroke;
  final Color color;
  _RingPainter(this.p, this.stroke, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset(stroke / 2, stroke / 2) &
        Size(size.width - stroke, size.height - stroke);
    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = color.withOpacity(0.13);
    canvas.drawArc(rect, 0, math.pi * 2, false, track);
    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = color;
    canvas.drawArc(rect, -math.pi / 2, math.pi * 2 * p, false, arc);
  }

  @override
  bool shouldRepaint(_RingPainter o) =>
      o.p != p || o.color != color || o.stroke != stroke;
}

/// Floating rounded bottom nav with centre "+" action.
class FloatingNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTab;
  final VoidCallback onAdd;
  const FloatingNav(
      {super.key,
      required this.index,
      required this.onTab,
      required this.onAdd});

  @override
  Widget build(BuildContext context) {
    Widget tab(int i, IconData icon, String label) {
      final on = i == index;
      return Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onTab(i),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 24, color: on ? EC.orangeDeep : EC.text2),
            const SizedBox(height: 3),
            Text(label,
                style: ts(11,
                    w: on ? FontWeight.w700 : FontWeight.w500,
                    color: on ? EC.orangeDeep : EC.text2)),
          ]),
        ),
      );
    }

    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: EC.isLight ? EC.card : const Color(0xF2171A18),
        borderRadius: BorderRadius.circular(36),
        border: Border.all(color: EC.border),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(EC.isLight ? 0.06 : 0.09),
              blurRadius: EC.isLight ? 12 : 30,
              offset: Offset(0, EC.isLight ? 4 : 12))
        ],
      ),
      child: Row(children: [
        tab(0, Icons.home_rounded, 'Home'),
        tab(1, Icons.fitness_center_rounded, 'Training'),
        GestureDetector(
          onTap: onAdd,
          child: Container(
            width: 56,
            height: 56,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: EC.orange,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: EC.orange.withOpacity(0.24),
                    blurRadius: 16,
                    offset: const Offset(0, 6))
              ],
            ),
            child: Icon(
              Icons.add_rounded,
              color: EC.isLight ? EC.text : EC.bg,
              size: 30,
            ),
          ),
        ),
        tab(2, Icons.restaurant_rounded, 'Nutrition'),
        tab(3, Icons.show_chart_rounded, 'Progress'),
      ]),
    );
  }
}
