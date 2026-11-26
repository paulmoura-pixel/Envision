import '/flutter_flow/flutter_flow_util.dart';
import '/old_project/measurement_input/measurement_input_widget.dart';
import '/old_project/progress_step3/progress_step3_widget.dart';
import 'fitness_onboarding_step_page3_widget.dart'
    show FitnessOnboardingStepPage3Widget;
import 'package:flutter/material.dart';

class FitnessOnboardingStepPage3Model
    extends FlutterFlowModel<FitnessOnboardingStepPage3Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for ProgressStep.
  late ProgressStep3Model progressStepModel1;
  // Model for ProgressStep.
  late ProgressStep3Model progressStepModel2;
  // Model for ProgressStep.
  late ProgressStep3Model progressStepModel3;
  // Model for ProgressStep.
  late ProgressStep3Model progressStepModel4;
  // Model for ProgressStep.
  late ProgressStep3Model progressStepModel5;
  // Model for ProgressStep.
  late ProgressStep3Model progressStepModel6;
  // Model for ProgressStep.
  late ProgressStep3Model progressStepModel7;
  // Model for MeasurementInput.
  late MeasurementInputModel measurementInputModel1;
  // Model for MeasurementInput.
  late MeasurementInputModel measurementInputModel2;
  // Model for MeasurementInput.
  late MeasurementInputModel measurementInputModel3;
  // Model for MeasurementInput.
  late MeasurementInputModel measurementInputModel4;
  // Model for MeasurementInput.
  late MeasurementInputModel measurementInputModel5;
  // Model for MeasurementInput.
  late MeasurementInputModel measurementInputModel6;

  @override
  void initState(BuildContext context) {
    progressStepModel1 = createModel(context, () => ProgressStep3Model());
    progressStepModel2 = createModel(context, () => ProgressStep3Model());
    progressStepModel3 = createModel(context, () => ProgressStep3Model());
    progressStepModel4 = createModel(context, () => ProgressStep3Model());
    progressStepModel5 = createModel(context, () => ProgressStep3Model());
    progressStepModel6 = createModel(context, () => ProgressStep3Model());
    progressStepModel7 = createModel(context, () => ProgressStep3Model());
    measurementInputModel1 =
        createModel(context, () => MeasurementInputModel());
    measurementInputModel2 =
        createModel(context, () => MeasurementInputModel());
    measurementInputModel3 =
        createModel(context, () => MeasurementInputModel());
    measurementInputModel4 =
        createModel(context, () => MeasurementInputModel());
    measurementInputModel5 =
        createModel(context, () => MeasurementInputModel());
    measurementInputModel6 =
        createModel(context, () => MeasurementInputModel());
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
    measurementInputModel1.dispose();
    measurementInputModel2.dispose();
    measurementInputModel3.dispose();
    measurementInputModel4.dispose();
    measurementInputModel5.dispose();
    measurementInputModel6.dispose();
  }
}
