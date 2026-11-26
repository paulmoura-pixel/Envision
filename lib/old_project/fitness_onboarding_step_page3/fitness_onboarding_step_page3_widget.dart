import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/old_project/measurement_input/measurement_input_widget.dart';
import '/old_project/progress_step3/progress_step3_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'fitness_onboarding_step_page3_model.dart';
export 'fitness_onboarding_step_page3_model.dart';

/// Fitness app onboarding step 4 of 7, white background.
///
/// Top-left orange Envision logo and wordmark. Below: back arrow and 7 thin
/// progress bars, first four orange, rest light gray, no step text. Heading
/// "Your measurements" bold, subtitle gray "Helps your coach set realistic
/// targets." Segmented toggle Imperial / Metric (Imperial selected, black).
/// Rounded white input cards with light gray border: Height (ft and in
/// fields), Weight (lbs), Target weight (lbs) optional, Body fat % optional.
/// Bottom: full width black rounded "Continue" button with white text. Orange
/// #FF6500, text #0B0B0B, gray #85858D, borders #E5E5E7.
class FitnessOnboardingStepPage3Widget extends StatefulWidget {
  const FitnessOnboardingStepPage3Widget({super.key});

  static String routeName = 'FitnessOnboardingStepPage3';
  static String routePath = '/fitnessOnboardingStepPage3';

  @override
  State<FitnessOnboardingStepPage3Widget> createState() =>
      _FitnessOnboardingStepPage3WidgetState();
}

class _FitnessOnboardingStepPage3WidgetState
    extends State<FitnessOnboardingStepPage3Widget> {
  late FitnessOnboardingStepPage3Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FitnessOnboardingStepPage3Model());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'FitnessOnboardingStepPage3'});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 44.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/Three_Orange_Slashes_Logo.png',
                            width: 24.0,
                            height: 24.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          'Envision',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w900,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                        ),
                      ].divide(SizedBox(width: 4.0)),
                    ),
                  ],
                ),
              ),
              Container(
                height: 24.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FlutterFlowIconButton(
                    borderRadius: 8.0,
                    buttonSize: 40.0,
                    fillColor: Colors.transparent,
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 20.0,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep3Widget(
                              active: true,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep3Widget(
                              active: true,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel3,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep3Widget(
                              active: true,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel4,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep3Widget(
                              active: true,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel5,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep3Widget(
                              active: false,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel6,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep3Widget(
                              active: false,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel7,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep3Widget(
                              active: false,
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 4.0)),
                    ),
                  ),
                ].divide(SizedBox(width: 8.0)),
              ),
              Container(
                height: 32.0,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Your measurements',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          font: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontStyle,
                          lineHeight: 1.4,
                        ),
                  ),
                  Text(
                    'Helps your coach set realistic targets.',
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
                          lineHeight: 1.4,
                        ),
                  ),
                ].divide(SizedBox(height: 4.0)),
              ),
              Container(
                height: 24.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF4F4F5),
                  borderRadius: BorderRadius.circular(16.0),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: FFAppState().obUnit != 'metric'
                                  ? Colors.black
                                  : Color(0xFFF2F2F4),
                              borderRadius: BorderRadius.circular(8.0),
                              shape: BoxShape.rectangle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Container(
                                child: Container(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    'Imperial',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: FFAppState().obUnit == 'metric'
                                              ? Color(0xFF85858D)
                                              : Colors.white,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: FFAppState().obUnit == 'metric'
                                  ? Colors.black
                                  : Color(0xFFF2F2F4),
                              shape: BoxShape.rectangle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Container(
                                child: Container(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    'Metric',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: FFAppState().obUnit == 'metric'
                                              ? Colors.white
                                              : Color(0xFF85858D),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 0.0)),
                    ),
                  ),
                ),
              ),
              Container(
                height: 24.0,
              ),
              Expanded(
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (FFAppState().obUnit != 'metric')
                        wrapWithModel(
                          model: _model.measurementInputModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: MeasurementInputWidget(
                            label: 'Height (ft)\n',
                            optional: false,
                            hint: '5\n',
                            suffix: 'ft\n',
                            fieldKey: 'heightFt\n',
                          ),
                        ),
                      if (FFAppState().obUnit != 'metric')
                        wrapWithModel(
                          model: _model.measurementInputModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: MeasurementInputWidget(
                            label: 'Height (in)\n',
                            optional: false,
                            hint: '10\n',
                            suffix: 'in\n',
                            fieldKey: 'heightIn\n',
                          ),
                        ),
                      if (FFAppState().obUnit == 'metric')
                        wrapWithModel(
                          model: _model.measurementInputModel3,
                          updateCallback: () => safeSetState(() {}),
                          child: MeasurementInputWidget(
                            label: 'Height (cm)',
                            optional: false,
                            hint: '175',
                            suffix: 'cm',
                            fieldKey: 'heightCm',
                          ),
                        ),
                      wrapWithModel(
                        model: _model.measurementInputModel4,
                        updateCallback: () => safeSetState(() {}),
                        child: MeasurementInputWidget(
                          label: 'Weight',
                          optional: false,
                          hint: '165',
                          suffix:
                              FFAppState().obUnit == 'metric' ? 'kg' : 'lbs',
                          fieldKey: 'weight\n',
                        ),
                      ),
                      wrapWithModel(
                        model: _model.measurementInputModel5,
                        updateCallback: () => safeSetState(() {}),
                        child: MeasurementInputWidget(
                          label: 'Target weight',
                          optional: true,
                          hint: '155',
                          suffix:
                              FFAppState().obUnit == 'metric' ? 'kg' : 'lbs',
                          fieldKey: 'targetWeight\n',
                        ),
                      ),
                      wrapWithModel(
                        model: _model.measurementInputModel6,
                        updateCallback: () => safeSetState(() {}),
                        child: MeasurementInputWidget(
                          label: 'Body fat %',
                          optional: true,
                          hint: '22',
                          suffix: '%',
                          fieldKey: 'bodyFatPct\n',
                        ),
                      ),
                      Container(
                        height: 32.0,
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  ),
                ),
              ),
              FFButtonWidget(
                onPressed: () {
                  print('Button pressed ...');
                },
                text: 'Continue\n',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 52.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primaryText,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.manrope(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: Colors.white,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
