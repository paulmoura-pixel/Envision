import '/flutter_flow/flutter_flow_util.dart';
import '/old_project/progress_step/progress_step_widget.dart';
import 'fitness_onboarding_step_page_widget.dart'
    show FitnessOnboardingStepPageWidget;
import 'package:flutter/material.dart';

class FitnessOnboardingStepPageModel
    extends FlutterFlowModel<FitnessOnboardingStepPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ProgressStep.
  late ProgressStepModel progressStepModel1;
  // Model for ProgressStep.
  late ProgressStepModel progressStepModel2;
  // Model for ProgressStep.
  late ProgressStepModel progressStepModel3;
  // Model for ProgressStep.
  late ProgressStepModel progressStepModel4;
  // Model for ProgressStep.
  late ProgressStepModel progressStepModel5;
  // Model for ProgressStep.
  late ProgressStepModel progressStepModel6;
  // Model for ProgressStep.
  late ProgressStepModel progressStepModel7;

  @override
  void initState(BuildContext context) {
    progressStepModel1 = createModel(context, () => ProgressStepModel());
    progressStepModel2 = createModel(context, () => ProgressStepModel());
    progressStepModel3 = createModel(context, () => ProgressStepModel());
    progressStepModel4 = createModel(context, () => ProgressStepModel());
    progressStepModel5 = createModel(context, () => ProgressStepModel());
    progressStepModel6 = createModel(context, () => ProgressStepModel());
    progressStepModel7 = createModel(context, () => ProgressStepModel());
  }

  @override
  void dispose() {
    progressStepModel1.dispose();
    progressStepModel2.dispose();
    progressStepModel3.dispose();
    progressStepModel4.dispose();
    progressStepModel5.dispose();
    progressStepModel6.dispose();
    progressStepModel7.dispose();
  }
}
