import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/enums/enums.dart';
import '/components/envision_primary_button_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'coach_setup_model.dart';
export 'coach_setup_model.dart';

/// Coach training-space and method setup.
class CoachSetupWidget extends StatefulWidget {
  const CoachSetupWidget({super.key});

  static String routeName = 'CoachSetup';
  static String routePath = '/coach-setup';

  @override
  State<CoachSetupWidget> createState() => _CoachSetupWidgetState();
}

class _CoachSetupWidgetState extends State<CoachSetupWidget> {
  late CoachSetupModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CoachSetupModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'CoachSetup'});
    _model.trainingSpaceNameTextController ??= TextEditingController();
    _model.trainingSpaceNameFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                    crossAxisAlignment:
                        (FFCrossAxisAlignment.center).flutterValue,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Expanded(
                        child: Container(
                          height: 3.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFFF6A00),
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 3.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFFF6A00),
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 3.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(width: 6.0)),
                  ),
                  Text(
                    'Create your training space',
                    maxLines: 2,
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          font: GoogleFonts.outfit(
                            fontWeight: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontStyle,
                        ),
                  ),
                  Text(
                    'Set up your gym so clients can find and join you.',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                  TextFormField(
                    controller: _model.trainingSpaceNameTextController,
                    focusNode: _model.trainingSpaceNameFocusNode,
                    onChanged: (_) => EasyDebounce.debounce(
                      '_model.trainingSpaceNameTextController',
                      Duration(milliseconds: 2000),
                      () async {
                        logFirebaseEvent(
                            'COACH_SETUP_TrainingSpaceName_ON_TEXTFIE');
                        logFirebaseEvent('TrainingSpaceName_update_page_state');
                        _model.spaceName =
                            _model.trainingSpaceNameTextController.text;
                        safeSetState(() {});
                      },
                    ),
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Gym or coaching name',
                      hintText: 'Riverside Strength',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      filled: true,
                    ),
                    style: TextStyle(),
                    maxLines: null,
                    validator: _model.trainingSpaceNameTextControllerValidator
                        .asValidator(context),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F4),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AuthUserStreamWidget(
                          builder: (context) => InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'COACH_SETUP_TrainingSpacePhoto_ON_TAP');
                              logFirebaseEvent(
                                  'TrainingSpacePhoto_upload_media_to_fireb');
                              final selectedMedia =
                                  await selectMediaWithSourceBottomSheet(
                                context: context,
                                allowPhoto: true,
                              );
                              if (selectedMedia != null &&
                                  selectedMedia.every((m) => validateFileFormat(
                                      m.storagePath, context))) {
                                safeSetState(() => _model
                                    .isDataUploading_uploadData9xb = true);
                                var selectedUploadedFiles = <FFUploadedFile>[];

                                var downloadUrls = <String>[];
                                try {
                                  selectedUploadedFiles = selectedMedia
                                      .map((m) => FFUploadedFile(
                                            name: m.storagePath.split('/').last,
                                            bytes: m.bytes,
                                            height: m.dimensions?.height,
                                            width: m.dimensions?.width,
                                            blurHash: m.blurHash,
                                            originalFilename:
                                                m.originalFilename,
                                          ))
                                      .toList();

                                  downloadUrls = (await Future.wait(
                                    selectedMedia.map(
                                      (m) async => await uploadData(
                                          m.storagePath, m.bytes),
                                    ),
                                  ))
                                      .where((u) => u != null)
                                      .map((u) => u!)
                                      .toList();
                                } finally {
                                  _model.isDataUploading_uploadData9xb = false;
                                }
                                if (selectedUploadedFiles.length ==
                                        selectedMedia.length &&
                                    downloadUrls.length ==
                                        selectedMedia.length) {
                                  safeSetState(() {
                                    _model.uploadedLocalFile_uploadData9xb =
                                        selectedUploadedFiles.first;
                                    _model.uploadedFileUrl_uploadData9xb =
                                        downloadUrls.first;
                                  });
                                } else {
                                  safeSetState(() {});
                                  return;
                                }
                              }

                              if (_model.uploadedFileUrl_uploadData9xb != '') {
                                logFirebaseEvent(
                                    'TrainingSpacePhoto_backend_call');

                                await currentUserReference!
                                    .update(createUsersRecordData(
                                  gymImage:
                                      _model.uploadedFileUrl_uploadData9xb,
                                ));
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                valueOrDefault(
                                    currentUserDocument?.gymImage, ''),
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'assets/images/error_image.jpg',
                                  width: 200.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Tap the photo area to add or replace your training-space photo (optional).',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'How do you coach?',
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontStyle,
                        ),
                  ),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children: [
                      FlutterFlowChoiceChips(
                        options: [
                          ChipData('In-person'),
                          ChipData('Online\n'),
                          ChipData('Hybrid')
                        ],
                        onChanged: (val) => safeSetState(
                            () => _model.chipValue = val?.firstOrNull),
                        selectedChipStyle: ChipStyle(
                          backgroundColor: Color(0xFFFF6A00),
                          textStyle: TextStyle(),
                          iconColor: Color(0x00000000),
                          iconSize: 0.0,
                          labelPadding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 8.0, 12.0, 8.0),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        unselectedChipStyle: ChipStyle(
                          backgroundColor: Color(0x00000000),
                          textStyle: TextStyle(),
                          iconColor: Color(0x00000000),
                          iconSize: 0.0,
                          labelPadding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 8.0, 12.0, 8.0),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        chipSpacing: 0.0,
                        multiselect: false,
                        initialized: _model.chipValue != null,
                        controller: _model.chipValueController ??=
                            FormFieldController<List<String>>(
                          ['In-person'],
                        ),
                        wrapped: false,
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    child: wrapWithModel(
                      model: _model.envisionPrimaryButtonModel,
                      updateCallback: () => safeSetState(() {}),
                      child: EnvisionPrimaryButtonWidget(
                        onTap: () async {
                          logFirebaseEvent(
                              'COACH_SETUP_Container_6ppdg258_CALLBACK');
                          logFirebaseEvent(
                              'EnvisionPrimaryButton_backend_call');

                          await currentUserReference!
                              .update(createUsersRecordData(
                            gymName:
                                _model.trainingSpaceNameTextController.text,
                            whereYouCoach: () {
                              if (_model.chipValue == 'Online') {
                                return WhereYouCoach.online;
                              } else if (_model.chipValue == 'Hybrid') {
                                return WhereYouCoach.hybrid;
                              } else {
                                return WhereYouCoach.inPerson;
                              }
                            }(),
                            role: 'coach',
                            gymImage: _model.uploadedFileUrl_uploadData9xb,
                          ));
                          logFirebaseEvent('EnvisionPrimaryButton_navigate_to');

                          context.goNamed(
                              FitnessOnboardingStepPage7Widget.routeName);
                        },
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: 16.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
