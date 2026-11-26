import '/flutter_flow/flutter_flow_util.dart';
import '/old_project/activity_card/activity_card_widget.dart';
import '/old_project/day_button/day_button_widget.dart';
import '/old_project/progress_step4/progress_step4_widget.dart';
import 'fitness_onboarding_step_page4_widget.dart'
    show FitnessOnboardingStepPage4Widget;
import 'package:flutter/material.dart';

class FitnessOnboardingStepPage4Model
    extends FlutterFlowModel<FitnessOnboardingStepPage4Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for ProgressStep.
  late ProgressStep4Model progressStepModel1;
  // Model for ProgressStep.
  late ProgressStep4Model progressStepModel2;
  // Model for ProgressStep.
  late ProgressStep4Model progressStepModel3;
  // Model for ProgressStep.
  late ProgressStep4Model progressStepModel4;
  // Model for ProgressStep.
  late ProgressStep4Model progressStepModel5;
  // Model for ProgressStep.
  late ProgressStep4Model progressStepModel6;
  // Model for ProgressStep.
  late ProgressStep4Model progressStepModel7;
  // Model for ActivityCard.
  late ActivityCardModel activityCardModel1;
  // Model for ActivityCard.
  late ActivityCardModel activityCardModel2;
  // Model for ActivityCard.
  late ActivityCardModel activityCardModel3;
  // Model for ActivityCard.
  late ActivityCardModel activityCardModel4;
  // Model for DayButton.
  late DayButtonModel dayButtonModel1;
  // Model for DayButton.
  late DayButtonModel dayButtonModel2;
  // Model for DayButton.
  late DayButtonModel dayButtonModel3;
  // Model for DayButton.
  late DayButtonModel dayButtonModel4;
  // Model for DayButton.
  late DayButtonModel dayButtonModel5;
  // Model for DayButton.
  late DayButtonModel dayButtonModel6;
  // Model for DayButton.
  late DayButtonModel dayButtonModel7;

  @override
  void initState(BuildContext context) {
    progressStepModel1 = createModel(context, () => ProgressStep4Model());
    progressStepModel2 = createModel(context, () => ProgressStep4Model());
    progressStepModel3 = createModel(context, () => ProgressStep4Model());
    progressStepModel4 = createModel(context, () => ProgressStep4Model());
    progressStepModel5 = createModel(context, () => ProgressStep4Model());
    progressStepModel6 = createModel(context, () => ProgressStep4Model());
    progressStepModel7 = createModel(context, () => ProgressStep4Model());
    activityCardModel1 = createModel(context, () => ActivityCardModel());
    activityCardModel2 = createModel(context, () => ActivityCardModel());
    activityCardModel3 = createModel(context, () => ActivityCardModel());
    activityCardModel4 = createModel(context, () => ActivityCardModel());
    dayButtonModel1 = createModel(context, () => DayButtonModel());
    dayButtonModel2 = createModel(context, () => DayButtonModel());
    dayButtonModel3 = createModel(context, () => DayButtonModel());
    dayButtonModel4 = createModel(context, () => DayButtonModel());
    dayButtonModel5 = createModel(context, () => DayButtonModel());
    dayButtonModel6 = createModel(context, () => DayButtonModel());
    dayButtonModel7 = createModel(context, () => DayButtonModel());
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
    activityCardModel1.dispose();
    activityCardModel2.dispose();
    activityCardModel3.dispose();
    activityCardModel4.dispose();
    dayButtonModel1.dispose();
    dayButtonModel2.dispose();
    dayButtonModel3.dispose();
    dayButtonModel4.dispose();
    dayButtonModel5.dispose();
    dayButtonModel6.dispose();
    dayButtonModel7.dispose();
  }
}
