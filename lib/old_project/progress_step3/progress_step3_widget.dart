import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'progress_step3_model.dart';
export 'progress_step3_model.dart';

class ProgressStep3Widget extends StatefulWidget {
  const ProgressStep3Widget({
    super.key,
    bool? active,
  }) : this.active = active ?? true;

  final bool active;

  @override
  State<ProgressStep3Widget> createState() => _ProgressStep3WidgetState();
}

class _ProgressStep3WidgetState extends State<ProgressStep3Widget> {
  late ProgressStep3Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProgressStep3Model());

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
        borderRadius: BorderRadius.circular(9999.0),
        shape: BoxShape.rectangle,
      ),
    );
  }
}
