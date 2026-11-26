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

import 'package:camera/camera.dart';

class EnvisionCameraView extends StatefulWidget {
  const EnvisionCameraView(
      {super.key, this.width, this.height, this.onCaptured, this.onGallery});
  final double? width;
  final double? height;
  final void Function(String path)? onCaptured;
  final VoidCallback? onGallery;
  @override
  State<EnvisionCameraView> createState() => _EnvisionCameraViewState();
}

class _EnvisionCameraViewState extends State<EnvisionCameraView>
    with WidgetsBindingObserver {
  CameraController? _c;
  List<CameraDescription> _cams = [];
  int _idx = 0;
  String? _err;
  bool _busy = false;
  double _zoom = 1;
  double _base = 1;
  double _minZ = 1;
  double _maxZ = 1;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  Future<void> _init() async {
    try {
      _cams = await availableCameras();
      if (_cams.isEmpty) {
        if (mounted)
          setState(() => _err = 'No camera available on this device.');
        return;
      }
      _idx =
          _cams.indexWhere((c) => c.lensDirection == CameraLensDirection.back);
      if (_idx < 0) _idx = 0;
      await _start();
    } on CameraException catch (e) {
      if (mounted)
        setState(() => _err = e.code.toLowerCase().contains('denied')
            ? 'Camera access is off. Turn it on in Settings to scan meals.'
            : 'Camera unavailable (${e.code}).');
    } catch (_) {
      if (mounted) setState(() => _err = 'Camera unavailable.');
    }
  }

  Future<void> _start() async {
    final old = _c;
    final c = CameraController(_cams[_idx], ResolutionPreset.high,
        enableAudio: false);
    _c = null;
    if (mounted) setState(() {});
    await old?.dispose();
    await c.initialize();
    _minZ = await c.getMinZoomLevel();
    _maxZ = await c.getMaxZoomLevel();
    _zoom = _minZ;
    if (!mounted) {
      await c.dispose();
      return;
    }
    setState(() {
      _c = c;
      _err = null;
    });
  }

  Future<void> _flip() async {
    if (_cams.length < 2 || _busy) return;
    _busy = true;
    try {
      _idx = (_idx + 1) % _cams.length;
      await _start();
    } catch (_) {
      if (mounted) setState(() => _err = 'Camera unavailable.');
    }
    _busy = false;
  }

  Future<void> _shoot() async {
    final c = _c;
    if (c == null || !c.value.isInitialized || c.value.isTakingPicture) return;
    try {
      final f = await c.takePicture();
      widget.onCaptured?.call(f.path);
    } catch (_) {}
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState s) {
    if (s == AppLifecycleState.inactive) {
      final c = _c;
      _c = null;
      c?.dispose();
      if (mounted) setState(() {});
    } else if (s == AppLifecycleState.resumed &&
        _c == null &&
        _err == null &&
        _cams.isNotEmpty) {
      _start().catchError((_) {});
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _c?.dispose();
    super.dispose();
  }

  Widget _ctl(IconData i, VoidCallback? f) => GestureDetector(
      onTap: f,
      child: Container(
          width: 52,
          height: 52,
          decoration: const BoxDecoration(
              color: Color(0xFFF1F1F3), shape: BoxShape.circle),
          child: Icon(i, color: const Color(0xFF0B0B0B))));
  @override
  Widget build(BuildContext context) {
    final c = _c;
    Widget view;
    if (_err != null) {
      view = Center(
          child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.no_photography_outlined,
                    size: 40, color: Color(0xFF85858D)),
                const SizedBox(height: 12),
                Text(_err!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, color: Color(0xFF85858D))),
                const SizedBox(height: 12),
                TextButton(
                    onPressed: () {
                      setState(() => _err = null);
                      _init();
                    },
                    child: const Text('Try again'))
              ])));
    } else if (c == null || !c.value.isInitialized) {
      view = const Center(
          child: CircularProgressIndicator(color: Color(0xFFFF6500)));
    } else {
      view = FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
              width: c.value.previewSize!.height,
              height: c.value.previewSize!.width,
              child: CameraPreview(c)));
    }
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
              height: widget.height ?? 360,
              width: double.infinity,
              color: const Color(0xFF1B1B1B),
              child: GestureDetector(
                  onScaleStart: (_) => _base = _zoom,
                  onScaleUpdate: (d) {
                    final cc = _c;
                    if (cc == null || !cc.value.isInitialized) return;
                    final z = (_base * d.scale).clamp(_minZ, _maxZ).toDouble();
                    _zoom = z;
                    cc.setZoomLevel(z);
                  },
                  child: view))),
      const SizedBox(height: 18),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _ctl(Icons.photo_library_outlined, widget.onGallery),
        GestureDetector(
            onTap: _shoot,
            child: Container(
                width: 78,
                height: 78,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFFFF6500), width: 4)),
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle)))),
        _ctl(Icons.cameraswitch_outlined, _flip)
      ])
    ]);
  }
} //'dart:ui' as ui; import 'package:image_picker/image_picker.dart';, define your parameter, and then add the
// boilerplate code using the `</>` button on the right!
