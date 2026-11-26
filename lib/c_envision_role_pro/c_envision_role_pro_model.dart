import '/components/envision_primary_button_widget.dart';
import '/components/envision_role_image_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'c_envision_role_pro_widget.dart' show CEnvisionRoleProWidget;
import 'package:flutter/material.dart';

class CEnvisionRoleProModel extends FlutterFlowModel<CEnvisionRoleProWidget> {
  ///  Local state fields for this page.

  String selectedRole = 'none';

  ///  State fields for stateful widgets in this page.

  // Model for EnvisionRoleImageCard component.
  late EnvisionRoleImageCardModel envisionRoleImageCardModel1;
  // Model for EnvisionRoleImageCard component.
  late EnvisionRoleImageCardModel envisionRoleImageCardModel2;
  // Model for EnvisionPrimaryButton component.
  late EnvisionPrimaryButtonModel envisionPrimaryButtonModel1;
  // Model for EnvisionPrimaryButton component.
  late EnvisionPrimaryButtonModel envisionPrimaryButtonModel2;
  // Model for EnvisionPrimaryButton component.
  late EnvisionPrimaryButtonModel envisionPrimaryButtonModel3;

  @override
  void initState(BuildContext context) {
    envisionRoleImageCardModel1 =
        createModel(context, () => EnvisionRoleImageCardModel());
    envisionRoleImageCardModel2 =
        createModel(context, () => EnvisionRoleImageCardModel());
    envisionPrimaryButtonModel1 =
        createModel(context, () => EnvisionPrimaryButtonModel());
    envisionPrimaryButtonModel2 =
        createModel(context, () => EnvisionPrimaryButtonModel());
    envisionPrimaryButtonModel3 =
        createModel(context, () => EnvisionPrimaryButtonModel());
  }

  @override
  void dispose() {
    envisionRoleImageCardModel1.dispose();
    envisionRoleImageCardModel2.dispose();
    envisionPrimaryButtonModel1.dispose();
    envisionPrimaryButtonModel2.dispose();
    envisionPrimaryButtonModel3.dispose();
  }
}
