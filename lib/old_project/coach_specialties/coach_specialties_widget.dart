import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'coach_specialties_model.dart';
export 'coach_specialties_model.dart';

/// Coach method and specialty selection.
class CoachSpecialtiesWidget extends StatefulWidget {
  const CoachSpecialtiesWidget({super.key});

  static String routeName = 'CoachSpecialties';
  static String routePath = '/coach-specialties';

  @override
  State<CoachSpecialtiesWidget> createState() => _CoachSpecialtiesWidgetState();
}

class _CoachSpecialtiesWidgetState extends State<CoachSpecialtiesWidget> {
  late CoachSpecialtiesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CoachSpecialtiesModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'CoachSpecialties'});
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
                  Text(
                    'What do you coach?',
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
                    'Select all that apply. You can update this later.',
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
                  FlutterFlowChoiceChips(
                    options: [
                      ChipData('Strength'),
                      ChipData('Bodybuilding'),
                      ChipData('Weight loss')
                    ],
                    onChanged: (val) => safeSetState(
                        () => _model.chipValue1 = val?.firstOrNull),
                    selectedChipStyle: ChipStyle(
                      backgroundColor: Color(0xFFFF6A00),
                      textStyle: TextStyle(),
                      iconColor: Color(0x00000000),
                      iconSize: 0.0,
                      labelPadding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 8.0),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    unselectedChipStyle: ChipStyle(
                      backgroundColor: Color(0x00000000),
                      textStyle: TextStyle(),
                      iconColor: Color(0x00000000),
                      iconSize: 0.0,
                      labelPadding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 8.0),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    chipSpacing: 8.0,
                    rowSpacing: 8.0,
                    multiselect: false,
                    initialized: _model.chipValue1 != null,
                    controller: _model.chipValueController1 ??=
                        FormFieldController<List<String>>(
                      ['Strength'],
                    ),
                    wrapped: false,
                  ),
                  FlutterFlowChoiceChips(
                    options: [
                      ChipData('Sports performance'),
                      ChipData('Group fitness'),
                      ChipData('Mobility')
                    ],
                    onChanged: (val) => safeSetState(
                        () => _model.chipValue2 = val?.firstOrNull),
                    selectedChipStyle: ChipStyle(
                      backgroundColor: Color(0xFFFF6A00),
                      textStyle: TextStyle(),
                      iconColor: Color(0x00000000),
                      iconSize: 0.0,
                      labelPadding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 8.0),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    unselectedChipStyle: ChipStyle(
                      backgroundColor: Color(0x00000000),
                      textStyle: TextStyle(),
                      iconColor: Color(0x00000000),
                      iconSize: 0.0,
                      labelPadding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 8.0),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    chipSpacing: 8.0,
                    rowSpacing: 8.0,
                    multiselect: false,
                    initialized: _model.chipValue2 != null,
                    controller: _model.chipValueController2 ??=
                        FormFieldController<List<String>>(
                      ['Sports performance'],
                    ),
                    wrapped: false,
                  ),
                  FFButtonWidget(
                    onPressed: () {
                      print('FinisSetup pressed ...');
                    },
                    text: 'Finish setup',
                    icon: Icon(
                      Icons.arrow_forward_rounded,
                      size: 20.0,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 56.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconColor: Color(0xFF0B0D0C),
                      color: FlutterFlowTheme.of(context).primaryText,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      borderRadius: BorderRadius.circular(28.0),
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
