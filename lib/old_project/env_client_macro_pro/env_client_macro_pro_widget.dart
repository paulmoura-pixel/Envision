import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'env_client_macro_pro_model.dart';
export 'env_client_macro_pro_model.dart';

/// DSL component EnvClientMacroPro
class EnvClientMacroProWidget extends StatefulWidget {
  const EnvClientMacroProWidget({
    super.key,
    this.value,
    this.label,
    this.color,
  });

  final String? value;
  final String? label;
  final Color? color;

  @override
  State<EnvClientMacroProWidget> createState() =>
      _EnvClientMacroProWidgetState();
}

class _EnvClientMacroProWidgetState extends State<EnvClientMacroProWidget> {
  late EnvClientMacroProModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnvClientMacroProModel());

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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).nightCard,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).nightBorder,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
          crossAxisAlignment: (FFCrossAxisAlignment.start).flutterValue,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Container(
              width: 26.0,
              height: 4.0,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(9.0),
              ),
            ),
            Text(
              widget.value!,
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    font: GoogleFonts.manrope(
                      fontWeight:
                          FlutterFlowTheme.of(context).titleLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleLarge.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).nightText,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).titleLarge.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleLarge.fontStyle,
                  ),
            ),
            Text(
              widget.label!,
              maxLines: 2,
              style: FlutterFlowTheme.of(context).bodySmall.override(
                    font: GoogleFonts.manrope(
                      fontWeight:
                          FlutterFlowTheme.of(context).bodySmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodySmall.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).nightMuted,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).bodySmall.fontWeight,
                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                  ),
            ),
          ].divide(SizedBox(height: 7.0)),
        ),
      ),
    );
  }
}
