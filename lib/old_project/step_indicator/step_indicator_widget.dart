import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'step_indicator_model.dart';
export 'step_indicator_model.dart';

class StepIndicatorWidget extends StatefulWidget {
  const StepIndicatorWidget({
    super.key,
    double? activeStep,
  }) : this.activeStep = activeStep ?? 1.0;

  final double activeStep;

  @override
  State<StepIndicatorWidget> createState() => _StepIndicatorWidgetState();
}

class _StepIndicatorWidgetState extends State<StepIndicatorWidget> {
  late StepIndicatorModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StepIndicatorModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 4.0,
            decoration: BoxDecoration(
              color: Color(0xFFFF6500),
              borderRadius: BorderRadius.circular(9999.0),
              shape: BoxShape.rectangle,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 4.0,
            decoration: BoxDecoration(
              color: Color(0xFFE5E5E7),
              borderRadius: BorderRadius.circular(9999.0),
              shape: BoxShape.rectangle,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 4.0,
            decoration: BoxDecoration(
              color: Color(0xFFE5E5E7),
              borderRadius: BorderRadius.circular(9999.0),
              shape: BoxShape.rectangle,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 4.0,
            decoration: BoxDecoration(
              color: Color(0xFFE5E5E7),
              borderRadius: BorderRadius.circular(9999.0),
              shape: BoxShape.rectangle,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 4.0,
            decoration: BoxDecoration(
              color: Color(0xFFE5E5E7),
              borderRadius: BorderRadius.circular(9999.0),
              shape: BoxShape.rectangle,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 4.0,
            decoration: BoxDecoration(
              color: Color(0xFFE5E5E7),
              borderRadius: BorderRadius.circular(9999.0),
              shape: BoxShape.rectangle,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 4.0,
            decoration: BoxDecoration(
              color: Color(0xFFE5E5E7),
              borderRadius: BorderRadius.circular(9999.0),
              shape: BoxShape.rectangle,
            ),
          ),
        ),
      ].divide(SizedBox(width: 4.0)),
    );
  }
}
