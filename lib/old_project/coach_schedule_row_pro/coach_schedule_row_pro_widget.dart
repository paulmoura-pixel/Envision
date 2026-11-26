import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'coach_schedule_row_pro_model.dart';
export 'coach_schedule_row_pro_model.dart';

/// DSL component CoachScheduleRowPro
class CoachScheduleRowProWidget extends StatefulWidget {
  const CoachScheduleRowProWidget({
    super.key,
    this.time,
    this.person,
    this.detail,
  });

  final String? time;
  final String? person;
  final String? detail;

  @override
  State<CoachScheduleRowProWidget> createState() =>
      _CoachScheduleRowProWidgetState();
}

class _CoachScheduleRowProWidgetState extends State<CoachScheduleRowProWidget> {
  late CoachScheduleRowProModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CoachScheduleRowProModel());

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
      mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
      crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          widget.time!,
          style: FlutterFlowTheme.of(context).labelMedium.override(
                font: GoogleFonts.manrope(
                  fontWeight:
                      FlutterFlowTheme.of(context).labelMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).nightMuted,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
              ),
        ),
        Container(
          width: 7.0,
          height: 7.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).lime,
            borderRadius: BorderRadius.circular(999.0),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
            crossAxisAlignment: (FFCrossAxisAlignment.start).flutterValue,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                widget.person!,
                style: FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.manrope(
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).nightText,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).titleSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleSmall.fontStyle,
                    ),
              ),
              Text(
                widget.detail!,
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
                      fontStyle:
                          FlutterFlowTheme.of(context).bodySmall.fontStyle,
                    ),
              ),
            ].divide(SizedBox(height: 2.0)),
          ),
        ),
      ].divide(SizedBox(width: 10.0)),
    );
  }
}
