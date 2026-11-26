import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/old_project/coach_schedule_row_pro/coach_schedule_row_pro_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'coach_schedule_pro_model.dart';
export 'coach_schedule_pro_model.dart';

/// DSL component CoachSchedulePro
class CoachScheduleProWidget extends StatefulWidget {
  const CoachScheduleProWidget({super.key});

  @override
  State<CoachScheduleProWidget> createState() => _CoachScheduleProWidgetState();
}

class _CoachScheduleProWidgetState extends State<CoachScheduleProWidget> {
  late CoachScheduleProModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CoachScheduleProModel());

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
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).nightBorder,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
          crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Today’s schedule',
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
            wrapWithModel(
              model: _model.coachScheduleRowProModel1,
              updateCallback: () => safeSetState(() {}),
              child: CoachScheduleRowProWidget(
                time: '9:00',
                person: 'Maya Chen',
                detail: 'Upper body',
              ),
            ),
            wrapWithModel(
              model: _model.coachScheduleRowProModel2,
              updateCallback: () => safeSetState(() {}),
              child: CoachScheduleRowProWidget(
                time: '10:30',
                person: 'Jordan Lee',
                detail: 'Conditioning',
              ),
            ),
            wrapWithModel(
              model: _model.coachScheduleRowProModel3,
              updateCallback: () => safeSetState(() {}),
              child: CoachScheduleRowProWidget(
                time: '1:00',
                person: 'Group session',
                detail: '6 clients',
              ),
            ),
            wrapWithModel(
              model: _model.coachScheduleRowProModel4,
              updateCallback: () => safeSetState(() {}),
              child: CoachScheduleRowProWidget(
                time: '4:00',
                person: 'Alex Morgan',
                detail: 'Lower body',
              ),
            ),
          ].divide(SizedBox(height: 14.0)),
        ),
      ),
    );
  }
}
