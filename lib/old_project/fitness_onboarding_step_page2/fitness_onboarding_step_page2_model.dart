import '/flutter_flow/flutter_flow_util.dart';
import '/old_project/goal_card/goal_card_widget.dart';
import '/old_project/progress_step2/progress_step2_widget.dart';
import 'fitness_onboarding_step_page2_widget.dart'
    show FitnessOnboardingStepPage2Widget;
import 'package:flutter/material.dart';

class FitnessOnboardingStepPage2Model
    extends FlutterFlowModel<FitnessOnboardingStepPage2Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for ProgressStep.
  late ProgressStep2Model progressStepModel1;
  // Model for ProgressStep.
  late ProgressStep2Model progressStepModel2;
  // Model for ProgressStep.
  late ProgressStep2Model progressStepModel3;
  // Model for ProgressStep.
  late ProgressStep2Model progressStepModel4;
  // Model for ProgressStep.
  late ProgressStep2Model progressStepModel5;
  // Model for ProgressStep.
  late ProgressStep2Model progressStepModel6;
  // Model for ProgressStep.
  late ProgressStep2Model progressStepModel7;
  // Model for GoalCard.
  late GoalCardModel goalCardModel1;
  // Model for GoalCard.
  late GoalCardModel goalCardModel2;
  // Model for GoalCard.
  late GoalCardModel goalCardModel3;
  // Model for GoalCard.
  late GoalCardModel goalCardModel4;
  // Model for GoalCard.
  late GoalCardModel goalCardModel5;

  @override
  void initState(BuildContext context) {
    progressStepModel1 = createModel(context, () => ProgressStep2Model());
    progressStepModel2 = createModel(context, () => ProgressStep2Model());
    progressStepModel3 = createModel(context, () => ProgressStep2Model());
    progressStepModel4 = createModel(context, () => ProgressStep2Model());
    progressStepModel5 = createModel(context, () => ProgressStep2Model());
    progressStepModel6 = createModel(context, () => ProgressStep2Model());
    progressStepModel7 = createModel(context, () => ProgressStep2Model());
    goalCardModel1 = createModel(context, () => GoalCardModel());
    goalCardModel2 = createModel(context, () => GoalCardModel());
    goalCardModel3 = createModel(context, () => GoalCardModel());
    goalCardModel4 = createModel(context, () => GoalCardModel());
    goalCardModel5 = createModel(context, () => GoalCardModel());
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
    goalCardModel1.dispose();
    goalCardModel2.dispose();
    goalCardModel3.dispose();
    goalCardModel4.dispose();
    goalCardModel5.dispose();
  }
}
