import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'progress_bar_model.dart';
export 'progress_bar_model.dart';

class ProgressBarWidget extends StatefulWidget {
  const ProgressBarWidget({super.key});

  @override
  State<ProgressBarWidget> createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget> {
  late ProgressBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProgressBarModel());

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
          child: Row(
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
            ].divide(SizedBox(width: 4.0)),
          ),
        ),
      ].divide(SizedBox(width: 4.0)),
    );
  }
}
