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

import 'dart:ui' as ui;

class EnvisionTrendChart extends StatefulWidget {
  const EnvisionTrendChart({
    super.key,
    this.width,
    this.height,
    required this.values,
    this.labels,
    this.unit,
  });

  final double? width;
  final double? height;
  final List<double> values;
  final List<String>? labels;
  final String? unit;

  @override
  State<EnvisionTrendChart> createState() => _EnvisionTrendChartState();
}

class _EnvisionTrendChartState extends State<EnvisionTrendChart> {
  @override
  Widget build(BuildContext context) {
    return _EnvisionTrendChartView(
      width: widget.width,
      height: widget.height,
      values: widget.values,
      labels: widget.labels,
      unit: widget.unit ?? '',
    );
  }
}

class _EnvisionTrendChartView extends StatelessWidget {
  const _EnvisionTrendChartView({
    super.key,
    this.width,
    this.height,
    required this.values,
    this.labels,
    this.unit = '',
  });

  final double? width;
  final double? height;
  final List<double> values; // oldest -> newest
  final List<String>? labels; // optional x labels, same length
  final String unit;

  @override
  Widget build(BuildContext context) {
    if (values.length < 2) {
      return SizedBox(
        width: width,
        height: height ?? 180,
        child: const Center(
          child: Text('Log at least two entries to see a trend',
              style: TextStyle(fontSize: 13, color: Color(0xFF85858D))),
        ),
      );
    }
    return SizedBox(
      width: width,
      height: height ?? 180,
      child: CustomPaint(
        painter: _TrendPainter(values, labels, unit),
        size: Size.infinite,
      ),
    );
  }
}

class _TrendPainter extends CustomPainter {
  _TrendPainter(this.values, this.labels, this.unit);
  final List<double> values;
  final List<String>? labels;
  final String unit;

  @override
  void paint(Canvas canvas, Size size) {
    const padL = 36.0, padB = 22.0, padT = 8.0, padR = 8.0;
    final w = size.width - padL - padR;
    final h = size.height - padT - padB;
    var minV = values.reduce((a, b) => a < b ? a : b);
    var maxV = values.reduce((a, b) => a > b ? a : b);
    if (minV == maxV) {
      minV -= 1;
      maxV += 1;
    }
    final span = maxV - minV;
    Offset pt(int i) => Offset(padL + w * i / (values.length - 1),
        padT + h * (1 - (values[i] - minV) / span));

    final grid = Paint()
      ..color = const Color(0xFFEEEEF0)
      ..strokeWidth = 1;
    for (var g = 0; g < 4; g++) {
      final y = padT + h * g / 3;
      canvas.drawLine(Offset(padL, y), Offset(padL + w, y), grid);
      final v = maxV - span * g / 3;
      _text(
          canvas, v.toStringAsFixed(v % 1 == 0 ? 0 : 1), Offset(0, y - 6), 11);
    }

    final path = Path()..moveTo(pt(0).dx, pt(0).dy);
    for (var i = 1; i < values.length; i++) {
      final a = pt(i - 1), b = pt(i);
      final mx = (a.dx + b.dx) / 2;
      path.cubicTo(mx, a.dy, mx, b.dy, b.dx, b.dy);
    }
    final fill = Path.from(path)
      ..lineTo(pt(values.length - 1).dx, padT + h)
      ..lineTo(pt(0).dx, padT + h)
      ..close();
    canvas.drawPath(
        fill,
        Paint()
          ..shader = const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0x33FF6500), Color(0x00FF6500)],
          ).createShader(Rect.fromLTWH(padL, padT, w, h)));
    canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..strokeCap = StrokeCap.round
          ..color = const Color(0xFFFF6500));
    final last = pt(values.length - 1);
    canvas.drawCircle(last, 5, Paint()..color = const Color(0xFFFF6500));
    canvas.drawCircle(last, 2.5, Paint()..color = Colors.white);

    final l = labels;
    if (l != null && l.length == values.length) {
      final idx = <int>{0, values.length ~/ 2, values.length - 1};
      for (final i in idx) {
        _text(canvas, l[i], Offset(pt(i).dx - 14, padT + h + 6), 11);
      }
    }
  }

  void _text(Canvas c, String s, Offset o, double fs) {
    final tp = TextPainter(
      text: TextSpan(
          text: s,
          style: TextStyle(fontSize: fs, color: const Color(0xFF85858D))),
      textDirection: ui.TextDirection.ltr,
    )..layout();
    tp.paint(c, o);
  }

  @override
  bool shouldRepaint(_TrendPainter o) =>
      o.values != values || o.labels != labels;
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the `</>` button on the right!
