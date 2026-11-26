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

// Set your widget name, define your parameter, and then add the
// boilerplate code using the `</>` button on the right!
import 'dart:async';

/// Quiet brand splash: centered logo, parallel fade + scale intro,
/// readiness-gated exit fade.
///
/// Holds no navigation or business logic.
class EnvisionSplash extends StatefulWidget {
  const EnvisionSplash({
    super.key,
    this.width,
    this.height,
    required this.logoAsset,
    required this.isReady,
    this.backgroundColor,
    this.fadeInMs = 500,
    this.scaleMs = 600,
    this.introMs = 1100,
    this.reducedHoldMs = 600,
    this.exitFadeMs = 350,
  });

  final double? width;
  final double? height;
  final String logoAsset;
  final bool isReady;
  final Color? backgroundColor;

  final int fadeInMs;
  final int scaleMs;
  final int introMs;
  final int reducedHoldMs;
  final int exitFadeMs;

  @override
  State<EnvisionSplash> createState() => _EnvisionSplashState();
}

class _EnvisionSplashState extends State<EnvisionSplash>
    with TickerProviderStateMixin {
  late final AnimationController _fade;
  late final AnimationController _scale;
  late final AnimationController _exit;
  late final Animation<double> _opacity;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _exitOpacity;

  Timer? _introTimer;
  ImageProvider? _provider;
  bool _started = false;
  bool _reduceMotion = false;
  bool _introDone = false;
  bool _exiting = false;
  bool _removed = false;

  @override
  void initState() {
    super.initState();
    _fade = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.fadeInMs));
    _scale = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.scaleMs));
    _exit = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.exitFadeMs));
    _opacity = CurvedAnimation(parent: _fade, curve: Curves.easeOutQuad);
    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
        CurvedAnimation(parent: _scale, curve: const _EaseOutBack(1.2)));
    _exitOpacity = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _exit, curve: Curves.easeInOutQuad));
    _provider = _resolveProvider(widget.logoAsset);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    _reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    _loadThenBegin();
  }

  @override
  void didUpdateWidget(covariant EnvisionSplash oldWidget) {
    super.didUpdateWidget(oldWidget);
    _maybeExit();
  }

  ImageProvider? _resolveProvider(String path) {
    if (path.isEmpty) return null;
    if (path.startsWith('http')) return NetworkImage(path);
    return AssetImage(path);
  }

  Future<void> _loadThenBegin() async {
    final provider = _provider;
    if (provider != null) {
      try {
        await precacheImage(provider, context, onError: (_, __) {})
            .timeout(const Duration(milliseconds: 1500));
      } catch (_) {
        // Fail gracefully: continue without the asset.
      }
    }
    if (!mounted) return;
    _begin();
  }

  void _begin() {
    if (_reduceMotion) {
      _fade.value = 1.0;
      _scale.value = 1.0;
    } else {
      _fade.forward();
      _scale.forward();
    }
    final holdMs = _reduceMotion ? widget.reducedHoldMs : widget.introMs;
    _introTimer = Timer(Duration(milliseconds: holdMs), () {
      _introDone = true;
      _maybeExit();
    });
  }

  void _maybeExit() {
    if (_exiting || !_introDone || !widget.isReady || !mounted) return;
    _exiting = true;
    _exit.forward().whenComplete(() {
      if (!mounted) return;
      setState(() => _removed = true);
    });
  }

  @override
  void dispose() {
    _introTimer?.cancel();
    _fade.dispose();
    _scale.dispose();
    _exit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_removed) return const SizedBox.shrink();
    final box = MediaQuery.sizeOf(context).shortestSide * 0.55;
    final provider = _provider;
    return FadeTransition(
      opacity: _exitOpacity,
      child: ColoredBox(
        color: widget.backgroundColor ?? const Color(0xFFFFFFFF),
        child: SizedBox.expand(
          child: Center(
            child: FadeTransition(
              opacity: _opacity,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: SizedBox(
                  width: box,
                  height: box,
                  child: provider == null
                      ? const SizedBox.shrink()
                      : Image(
                          image: provider,
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                          filterQuality: FilterQuality.high,
                          gaplessPlayback: true,
                          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// easeOutBack with an explicit overshoot ("tension") value.
class _EaseOutBack extends Curve {
  const _EaseOutBack(this.s);
  final double s;

  @override
  double transformInternal(double t) {
    final p = t - 1.0;
    return p * p * ((s + 1.0) * p + s) + 1.0;
  }
}
