import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'progress_step4_model.dart';
export 'progress_step4_model.dart';

class ProgressStep4Widget extends StatefulWidget {
  const ProgressStep4Widget({
    super.key,
    bool? active,
  }) : this.active = active ?? true;

  final bool active;

  @override
  State<ProgressStep4Widget> createState() => _ProgressStep4WidgetState();
}

class _ProgressStep4WidgetState extends State<ProgressStep4Widget> {
  late ProgressStep4Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProgressStep4Model());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4.0,
      decoration: BoxDecoration(
        color: valueOrDefault<Color>(
          valueOrDefault<bool>(
            widget.active,
            true,
          )
              ? Color(0xFFFF6500)
              : Color(0xFFE5E5E7),
          Color(0xFFFF6500),
        ),
        borderRadius: BorderRadius.circular(2.0),
        shape: BoxShape.rectangle,
      ),
    );
  }
}
