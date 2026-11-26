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

class EnvisionMacroBar extends StatefulWidget {
  const EnvisionMacroBar({
    super.key,
    this.width,
    this.height,
    required this.label,
    required this.current,
    required this.goal,
    this.unit,
  });

  final double? width;
  final double? height;
  final String label;
  final double current;
  final double goal;
  final String? unit;

  @override
  State<EnvisionMacroBar> createState() => _EnvisionMacroBarState();
}

class _EnvisionMacroBarState extends State<EnvisionMacroBar> {
  @override
  Widget build(BuildContext context) {
    final unit = widget.unit ?? 'g';
    final pct =
        widget.goal <= 0 ? 0.0 : (widget.current / widget.goal).clamp(0.0, 1.0);
    return SizedBox(
      width: widget.width,
      height: widget.height ?? 44,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.label,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0B0B0B))),
              Text('${widget.current.round()} / ${widget.goal.round()} $unit',
                  style:
                      const TextStyle(fontSize: 13, color: Color(0xFF85858D))),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 8,
              backgroundColor: const Color(0xFFEEEEF0),
              valueColor: const AlwaysStoppedAnimation(Color(0xFFFF6500)),
            ),
          ),
        ],
      ),
    );
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the `</>` button on the right!
