import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'progress_step5_model.dart';
export 'progress_step5_model.dart';

class ProgressStep5Widget extends StatefulWidget {
  const ProgressStep5Widget({
    super.key,
    bool? active,
  }) : this.active = active ?? true;

  final bool active;

  @override
  State<ProgressStep5Widget> createState() => _ProgressStep5WidgetState();
}

class _ProgressStep5WidgetState extends State<ProgressStep5Widget> {
  late ProgressStep5Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProgressStep5Model());

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
