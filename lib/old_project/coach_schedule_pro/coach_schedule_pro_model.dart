import '/flutter_flow/flutter_flow_util.dart';
import '/old_project/coach_schedule_row_pro/coach_schedule_row_pro_widget.dart';
import 'coach_schedule_pro_widget.dart' show CoachScheduleProWidget;
import 'package:flutter/material.dart';

class CoachScheduleProModel extends FlutterFlowModel<CoachScheduleProWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for CoachScheduleRowPro.
  late CoachScheduleRowProModel coachScheduleRowProModel1;
  // Model for CoachScheduleRowPro.
  late CoachScheduleRowProModel coachScheduleRowProModel2;
  // Model for CoachScheduleRowPro.
  late CoachScheduleRowProModel coachScheduleRowProModel3;
  // Model for CoachScheduleRowPro.
  late CoachScheduleRowProModel coachScheduleRowProModel4;

  @override
  void initState(BuildContext context) {
    coachScheduleRowProModel1 =
        createModel(context, () => CoachScheduleRowProModel());
    coachScheduleRowProModel2 =
        createModel(context, () => CoachScheduleRowProModel());
    coachScheduleRowProModel3 =
        createModel(context, () => CoachScheduleRowProModel());
    coachScheduleRowProModel4 =
        createModel(context, () => CoachScheduleRowProModel());
  }

  @override
  void dispose() {
    coachScheduleRowProModel1.dispose();
    coachScheduleRowProModel2.dispose();
    coachScheduleRowProModel3.dispose();
    coachScheduleRowProModel4.dispose();
  }
}
