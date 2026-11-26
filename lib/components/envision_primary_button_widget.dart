import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'envision_primary_button_model.dart';
export 'envision_primary_button_model.dart';

class EnvisionPrimaryButtonWidget extends StatefulWidget {
  const EnvisionPrimaryButtonWidget({
    super.key,
    this.onTap,
  });

  final Future Function()? onTap;

  @override
  State<EnvisionPrimaryButtonWidget> createState() =>
      _EnvisionPrimaryButtonWidgetState();
}

class _EnvisionPrimaryButtonWidgetState
    extends State<EnvisionPrimaryButtonWidget> {
  late EnvisionPrimaryButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnvisionPrimaryButtonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: () async {
        logFirebaseEvent('ENVISION_PRIMARY_BUTTON_Button_ON_TAP');
        logFirebaseEvent('Button_execute_callback');
        await widget.onTap?.call();
      },
      text: 'Continue',
      icon: Icon(
        Icons.arrow_forward_rounded,
        size: 20.0,
      ),
      options: FFButtonOptions(
        width: double.infinity,
        height: 56.0,
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        iconAlignment: IconAlignment.end,
        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        iconColor: FlutterFlowTheme.of(context).secondaryBackground,
        color: FlutterFlowTheme.of(context).primaryText,
        textStyle: TextStyle(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
        ),
        borderRadius: BorderRadius.circular(28.0),
      ),
    );
  }
}
