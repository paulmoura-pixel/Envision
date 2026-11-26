import '/flutter_flow/flutter_flow_util.dart';
import '/old_project/env_client_card/env_client_card_widget.dart';
import 'coach_attention_pro_widget.dart' show CoachAttentionProWidget;
import 'package:flutter/material.dart';

class CoachAttentionProModel extends FlutterFlowModel<CoachAttentionProWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for EnvClientCard.
  late EnvClientCardModel envClientCardModel1;
  // Model for EnvClientCard.
  late EnvClientCardModel envClientCardModel2;
  // Model for EnvClientCard.
  late EnvClientCardModel envClientCardModel3;
  // Model for EnvClientCard.
  late EnvClientCardModel envClientCardModel4;

  @override
  void initState(BuildContext context) {
    envClientCardModel1 = createModel(context, () => EnvClientCardModel());
    envClientCardModel2 = createModel(context, () => EnvClientCardModel());
    envClientCardModel3 = createModel(context, () => EnvClientCardModel());
    envClientCardModel4 = createModel(context, () => EnvClientCardModel());
  }

  @override
  void dispose() {
    envClientCardModel1.dispose();
    envClientCardModel2.dispose();
    envClientCardModel3.dispose();
    envClientCardModel4.dispose();
  }
}
