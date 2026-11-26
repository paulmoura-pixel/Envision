import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'client_join_widget.dart' show ClientJoinWidget;
import 'package:flutter/material.dart';

class ClientJoinModel extends FlutterFlowModel<ClientJoinWidget> {
  ///  Local state fields for this page.

  String? inviteCode = '';

  ///  State fields for stateful widgets in this page.

  // State field(s) for InviteCodeField widget.
  FocusNode? inviteCodeFieldFocusNode;
  TextEditingController? inviteCodeFieldTextController;
  String? Function(BuildContext, String?)?
      inviteCodeFieldTextControllerValidator;
  // Stores action output result for [Custom Action - obValidateInvite] action in Button widget.
  dynamic inviteLookup;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    inviteCodeFieldFocusNode?.dispose();
    inviteCodeFieldTextController?.dispose();
  }
}
