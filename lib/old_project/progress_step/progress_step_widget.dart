import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'progress_step_model.dart';
export 'progress_step_model.dart';

class ProgressStepWidget extends StatefulWidget {
  const ProgressStepWidget({
    super.key,
    bool? active,
  }) : this.active = active ?? true;

  final bool active;

  @override
  State<ProgressStepWidget> createState() => _ProgressStepWidgetState();
}

class _ProgressStepWidgetState extends State<ProgressStepWidget> {
  late ProgressStepModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProgressStepModel());

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
              : Color(0x3385858D),
          Color(0xFFFF6500),
        ),
        borderRadius: BorderRadius.circular(9999.0),
        shape: BoxShape.rectangle,
      ),
    );
  }
}
