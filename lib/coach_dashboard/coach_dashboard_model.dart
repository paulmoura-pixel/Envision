import '/components/bottom_nav2_widget.dart';
import '/components/button2_widget.dart';
import '/components/client_item_widget.dart';
import '/components/stat_card_widget.dart';
import '/components/text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'coach_dashboard_widget.dart' show CoachDashboardWidget;
import 'package:flutter/material.dart';

class CoachDashboardModel extends FlutterFlowModel<CoachDashboardWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for StatCard.
  late StatCardModel statCardModel1;
  // Model for StatCard.
  late StatCardModel statCardModel2;
  // Model for StatCard.
  late StatCardModel statCardModel3;
  // Model for StatCard.
  late StatCardModel statCardModel4;
  // Model for Button.
  late Button2Model buttonModel1;
  // Model for Button.
  late Button2Model buttonModel2;
  // Model for Button.
  late Button2Model buttonModel3;
  // Model for ClientItem.
  late ClientItemModel clientItemModel1;
  // Model for ClientItem.
  late ClientItemModel clientItemModel2;
  // Model for ClientItem.
  late ClientItemModel clientItemModel3;
  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for BottomNav.
  late BottomNav2Model bottomNavModel;

  @override
  void initState(BuildContext context) {
    statCardModel1 = createModel(context, () => StatCardModel());
    statCardModel2 = createModel(context, () => StatCardModel());
    statCardModel3 = createModel(context, () => StatCardModel());
    statCardModel4 = createModel(context, () => StatCardModel());
    buttonModel1 = createModel(context, () => Button2Model());
    buttonModel2 = createModel(context, () => Button2Model());
    buttonModel3 = createModel(context, () => Button2Model());
    clientItemModel1 = createModel(context, () => ClientItemModel());
    clientItemModel2 = createModel(context, () => ClientItemModel());
    clientItemModel3 = createModel(context, () => ClientItemModel());
    textFieldModel = createModel(context, () => TextFieldModel());
    bottomNavModel = createModel(context, () => BottomNav2Model());
  }

  @override
  void dispose() {
    statCardModel1.dispose();
    statCardModel2.dispose();
    statCardModel3.dispose();
    statCardModel4.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
    buttonModel3.dispose();
    clientItemModel1.dispose();
    clientItemModel2.dispose();
    clientItemModel3.dispose();
    textFieldModel.dispose();
    bottomNavModel.dispose();
  }
}
