import '/components/envision_primary_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'coach_setup_widget.dart' show CoachSetupWidget;
import 'package:flutter/material.dart';

class CoachSetupModel extends FlutterFlowModel<CoachSetupWidget> {
  ///  Local state fields for this page.

  String? spaceName = '';

  ///  State fields for stateful widgets in this page.

  // State field(s) for TrainingSpaceName widget.
  FocusNode? trainingSpaceNameFocusNode;
  TextEditingController? trainingSpaceNameTextController;
  String? Function(BuildContext, String?)?
      trainingSpaceNameTextControllerValidator;
  bool isDataUploading_uploadData9xb = false;
  FFUploadedFile uploadedLocalFile_uploadData9xb =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadData9xb = '';

  // State field(s) for Chip widget.
  FormFieldController<List<String>>? chipValueController;
  String? get chipValue => chipValueController?.value?.firstOrNull;
  set chipValue(String? val) =>
      chipValueController?.value = val != null ? [val] : [];
  // Model for EnvisionPrimaryButton component.
  late EnvisionPrimaryButtonModel envisionPrimaryButtonModel;

  @override
  void initState(BuildContext context) {
    envisionPrimaryButtonModel =
        createModel(context, () => EnvisionPrimaryButtonModel());
  }

  @override
  void dispose() {
    trainingSpaceNameFocusNode?.dispose();
    trainingSpaceNameTextController?.dispose();

    envisionPrimaryButtonModel.dispose();
  }
}
