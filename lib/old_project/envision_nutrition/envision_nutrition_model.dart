import '/flutter_flow/flutter_flow_util.dart';
import '/old_project/envision_bottom_navigation/envision_bottom_navigation_widget.dart';
import '/old_project/macro_stat/macro_stat_widget.dart';
import '/old_project/meal_row/meal_row_widget.dart';
import 'envision_nutrition_widget.dart' show EnvisionNutritionWidget;
import 'package:flutter/material.dart';

class EnvisionNutritionModel extends FlutterFlowModel<EnvisionNutritionWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for MacroStat.
  late MacroStatModel macroStatModel1;
  // Model for MacroStat.
  late MacroStatModel macroStatModel2;
  // Model for MacroStat.
  late MacroStatModel macroStatModel3;
  // Model for MealRow.
  late MealRowModel mealRowModel1;
  // Model for MealRow.
  late MealRowModel mealRowModel2;
  // Model for MealRow.
  late MealRowModel mealRowModel3;
  // Model for MealRow.
  late MealRowModel mealRowModel4;
  // Model for EnvisionBottomNavigation component.
  late EnvisionBottomNavigationModel envisionBottomNavigationModel;

  @override
  void initState(BuildContext context) {
    macroStatModel1 = createModel(context, () => MacroStatModel());
    macroStatModel2 = createModel(context, () => MacroStatModel());
    macroStatModel3 = createModel(context, () => MacroStatModel());
    mealRowModel1 = createModel(context, () => MealRowModel());
    mealRowModel2 = createModel(context, () => MealRowModel());
    mealRowModel3 = createModel(context, () => MealRowModel());
    mealRowModel4 = createModel(context, () => MealRowModel());
    envisionBottomNavigationModel =
        createModel(context, () => EnvisionBottomNavigationModel());
  }

  @override
  void dispose() {
    macroStatModel1.dispose();
    macroStatModel2.dispose();
    macroStatModel3.dispose();
    mealRowModel1.dispose();
    mealRowModel2.dispose();
    mealRowModel3.dispose();
    mealRowModel4.dispose();
    envisionBottomNavigationModel.dispose();
  }
}
