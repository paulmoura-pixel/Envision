import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'fitness_onboarding_step_page7_widget.dart'
    show FitnessOnboardingStepPage7Widget;
import 'package:flutter/material.dart';

class FitnessOnboardingStepPage7Model
    extends FlutterFlowModel<FitnessOnboardingStepPage7Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // Stores action output result for [Custom Action - obCheckUsername] action in Button widget.
  bool? usernameAvailable;
  // Stores action output result for [Custom Action - obFinalize] action in Button widget.
  String? finalizeResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();
  }
}
