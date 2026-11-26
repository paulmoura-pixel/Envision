import '/flutter_flow/flutter_flow_util.dart';
import '/old_project/step_indicator/step_indicator_widget.dart';
import 'fitness_client_onboarding_page_widget.dart'
    show FitnessClientOnboardingPageWidget;
import 'package:flutter/material.dart';

class FitnessClientOnboardingPageModel
    extends FlutterFlowModel<FitnessClientOnboardingPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for StepIndicator.
  late StepIndicatorModel stepIndicatorModel;

  @override
  void initState(BuildContext context) {
    stepIndicatorModel = createModel(context, () => StepIndicatorModel());
  }

  @override
  void dispose() {
    stepIndicatorModel.dispose();
  }
}
