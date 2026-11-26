// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:math' as math;

class EnvisionCalorieRing extends StatefulWidget {
  const EnvisionCalorieRing({
    super.key,
    this.width,
    this.height,
    required this.consumed,
    required this.goal,
  });

  final double? width;
  final double? height;
  final int consumed;
  final int goal;

  @override
  State<EnvisionCalorieRing> createState() => _EnvisionCalorieRingState();
}

class _EnvisionCalorieRingState extends State<EnvisionCalorieRing> {
  @override
  Widget build(BuildContext context) {
    return _RingView(
      width: widget.width,
      height: widget.height,
      consumed: widget.consumed,
      goal: widget.goal,
    );
  }
}

class _RingView extends StatelessWidget {
  const _RingView({
    super.key,
    this.width,
    this.height,
    required this.consumed,
    required this.goal,
  });

  final double? width;
  final double? height;
  final int consumed;
  final int goal;

  @override
  Widget build(BuildContext context) {
    final pct = goal <= 0 ? 0.0 : (consumed / goal).clamp(0.0, 1.0);
    final size = math.min(width ?? 140, height ?? 140);
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RingPainter(pct),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${(pct * 100).round()}%',
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0B0B0B))),
              const Text('of goal',
                  style: TextStyle(fontSize: 12, color: Color(0xFF85858D))),
            ],
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter(this.pct);
  final double pct;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 12.0;
    final rect = Rect.fromLTWH(
        stroke / 2, stroke / 2, size.width - stroke, size.height - stroke);
    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = const Color(0xFFEEEEF0);
    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFFF6500);
    canvas.drawArc(rect, 0, 2 * math.pi, false, track);
    if (pct > 0) {
      canvas.drawArc(rect, -math.pi / 2, 2 * math.pi * pct, false, arc);
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.pct != pct;
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the `</>` button on the right!
