import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'coach_specialties_widget.dart' show CoachSpecialtiesWidget;
import 'package:flutter/material.dart';

class CoachSpecialtiesModel extends FlutterFlowModel<CoachSpecialtiesWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Chip widget.
  FormFieldController<List<String>>? chipValueController1;
  String? get chipValue1 => chipValueController1?.value?.firstOrNull;
  set chipValue1(String? val) =>
      chipValueController1?.value = val != null ? [val] : [];
  // State field(s) for Chip widget.
  FormFieldController<List<String>>? chipValueController2;
  String? get chipValue2 => chipValueController2?.value?.firstOrNull;
  set chipValue2(String? val) =>
      chipValueController2?.value = val != null ? [val] : [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
