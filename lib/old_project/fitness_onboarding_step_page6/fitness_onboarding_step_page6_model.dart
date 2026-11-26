import '/flutter_flow/flutter_flow_util.dart';
import '/old_project/upload_card/upload_card_widget.dart';
import 'fitness_onboarding_step_page6_widget.dart'
    show FitnessOnboardingStepPage6Widget;
import 'package:flutter/material.dart';

class FitnessOnboardingStepPage6Model
    extends FlutterFlowModel<FitnessOnboardingStepPage6Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for UploadCard.
  late UploadCardModel uploadCardModel1;
  // Model for UploadCard.
  late UploadCardModel uploadCardModel2;
  // Model for UploadCard.
  late UploadCardModel uploadCardModel3;
  // State field(s) for Switch widget.
  bool? switchValue;

  @override
  void initState(BuildContext context) {
    uploadCardModel1 = createModel(context, () => UploadCardModel());
    uploadCardModel2 = createModel(context, () => UploadCardModel());
    uploadCardModel3 = createModel(context, () => UploadCardModel());
  }

  @override
  void dispose() {
    uploadCardModel1.dispose();
    uploadCardModel2.dispose();
    uploadCardModel3.dispose();
  }
}
