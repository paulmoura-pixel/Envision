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

class EnvisionBottomNav extends StatefulWidget {
  const EnvisionBottomNav({
    super.key,
    this.width,
    this.height,
    this.onHome,
    this.onPlus,
    this.onCoach,
    this.homeActive,
  });

  final double? width;
  final double? height;
  final Future Function()? onHome;
  final Future Function()? onPlus;
  final Future Function()? onCoach;
  final bool? homeActive;

  @override
  State<EnvisionBottomNav> createState() => _EnvisionBottomNavState();
}

class _EnvisionBottomNavState extends State<EnvisionBottomNav> {
  @override
  Widget build(BuildContext context) {
    return _EnvisionBottomNavView(
      width: widget.width,
      height: widget.height,
      onHome: widget.onHome,
      onPlus: widget.onPlus,
      onCoach: widget.onCoach,
      homeActive: widget.homeActive ?? true,
    );
  }
}

class _EnvisionBottomNavView extends StatelessWidget {
  const _EnvisionBottomNavView({
    super.key,
    this.width,
    this.height,
    this.onHome,
    this.onPlus,
    this.onCoach,
    this.homeActive = true,
  });

  final double? width;
  final double? height;
  final Future Function()? onHome;
  final Future Function()? onPlus;
  final Future Function()? onCoach;
  final bool homeActive;

  @override
  Widget build(BuildContext context) {
    const orange = Color(0xFFFF6500);
    const ink = Color(0xFF0B0B0B);
    const gray = Color(0xFF85858D);
    return SizedBox(
      width: width,
      height: height ?? 84,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 64,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFEEEEF0))),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _item(Icons.home_outlined, 'Home', homeActive ? ink : gray,
                    onHome),
                _item(Icons.people_outline, 'Coach', gray, onCoach),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            child: GestureDetector(
              onTap: onPlus == null ? null : () => onPlus!(),
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: orange,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x33FF6500),
                        blurRadius: 14,
                        offset: Offset(0, 6))
                  ],
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String label, Color c, Future Function()? tap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: tap == null ? null : () => tap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: c, size: 26),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 11, color: c)),
        ],
      ),
    );
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the `</>` button on the right!
