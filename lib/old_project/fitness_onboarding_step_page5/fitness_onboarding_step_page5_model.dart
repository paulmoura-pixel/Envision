import '/flutter_flow/flutter_flow_util.dart';
import '/old_project/form_label/form_label_widget.dart';
import '/old_project/progress_bar/progress_bar_widget.dart';
import 'fitness_onboarding_step_page5_widget.dart'
    show FitnessOnboardingStepPage5Widget;
import 'package:flutter/material.dart';

class FitnessOnboardingStepPage5Model
    extends FlutterFlowModel<FitnessOnboardingStepPage5Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for ProgressBar.
  late ProgressBarModel progressBarModel;
  // Model for FormLabel.
  late FormLabelModel formLabelModel1;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // Model for FormLabel.
  late FormLabelModel formLabelModel2;
  // Model for FormLabel.
  late FormLabelModel formLabelModel3;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Model for FormLabel.
  late FormLabelModel formLabelModel4;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;

  @override
  void initState(BuildContext context) {
    progressBarModel = createModel(context, () => ProgressBarModel());
    formLabelModel1 = createModel(context, () => FormLabelModel());
    formLabelModel2 = createModel(context, () => FormLabelModel());
    formLabelModel3 = createModel(context, () => FormLabelModel());
    formLabelModel4 = createModel(context, () => FormLabelModel());
  }

  @override
  void dispose() {
    progressBarModel.dispose();
    formLabelModel1.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    formLabelModel2.dispose();
    formLabelModel3.dispose();
    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    formLabelModel4.dispose();
    textFieldFocusNode3?.dispose();
    textController3?.dispose();
  }
}
