import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'env_client_day_pro_model.dart';
export 'env_client_day_pro_model.dart';

/// DSL component EnvClientDayPro
class EnvClientDayProWidget extends StatefulWidget {
  const EnvClientDayProWidget({
    super.key,
    this.day,
    this.date,
    this.selected,
  });

  final String? day;
  final String? date;
  final bool? selected;

  @override
  State<EnvClientDayProWidget> createState() => _EnvClientDayProWidgetState();
}

class _EnvClientDayProWidgetState extends State<EnvClientDayProWidget> {
  late EnvClientDayProModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnvClientDayProModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
      crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          widget.day!,
          style: FlutterFlowTheme.of(context).labelSmall.override(
                font: GoogleFonts.manrope(
                  fontWeight:
                      FlutterFlowTheme.of(context).labelSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).nightMuted,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
              ),
        ),
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: widget.selected!
                ? FlutterFlowTheme.of(context).lime
                : FlutterFlowTheme.of(context).nightCard,
            borderRadius: BorderRadius.circular(999.0),
            border: Border.all(
              color: widget.selected!
                  ? FlutterFlowTheme.of(context).lime
                  : FlutterFlowTheme.of(context).nightBorder,
              width: 1.0,
            ),
          ),
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Text(
            widget.date!,
            style: FlutterFlowTheme.of(context).titleSmall.override(
                  font: GoogleFonts.manrope(
                    fontWeight:
                        FlutterFlowTheme.of(context).titleSmall.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleSmall.fontStyle,
                  ),
                  color: widget.selected!
                      ? FlutterFlowTheme.of(context).night
                      : FlutterFlowTheme.of(context).nightText,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).titleSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                ),
          ),
        ),
      ].divide(SizedBox(height: 7.0)),
    );
  }
}
