import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/old_project/activity_card/activity_card_widget.dart';
import '/old_project/day_button/day_button_widget.dart';
import '/old_project/progress_step4/progress_step4_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fitness_onboarding_step_page4_model.dart';
export 'fitness_onboarding_step_page4_model.dart';

/// Fitness app onboarding step 5 of 7, white background.
///
/// Top-left orange Envision logo and wordmark. Below: back arrow and 7 thin
/// progress bars, first five orange, rest light gray, no step text. Heading
/// "Your training habits" bold, subtitle gray "How active are you right now?"
/// Four selectable cards (rounded, light gray border): Just starting out; 1-2
/// days a week; 3-4 days a week; 5+ days a week (Just starting out selected
/// with orange border and orange check). Below: label "How many days per week
/// can you train?" and a row of seven circular buttons numbered 1 to 7 (3
/// selected, filled orange with white text, others white with gray border).
/// Bottom: full width black rounded "Continue" button with white text. Orange
/// #FF6500, text #0B0B0B, gray #85858D, borders #E5E5E7.
class FitnessOnboardingStepPage4Widget extends StatefulWidget {
  const FitnessOnboardingStepPage4Widget({super.key});

  static String routeName = 'FitnessOnboardingStepPage4';
  static String routePath = '/fitnessOnboardingStepPage4';

  @override
  State<FitnessOnboardingStepPage4Widget> createState() =>
      _FitnessOnboardingStepPage4WidgetState();
}

class _FitnessOnboardingStepPage4WidgetState
    extends State<FitnessOnboardingStepPage4Widget> {
  late FitnessOnboardingStepPage4Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FitnessOnboardingStepPage4Model());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'FitnessOnboardingStepPage4'});
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
                    Container(
                      width: 24.0,
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
                  Container(
                    decoration: BoxDecoration(),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 20.0,
                    ),
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
                            child: ProgressStep4Widget(
                              active: true,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep4Widget(
                              active: true,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel3,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep4Widget(
                              active: true,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel4,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep4Widget(
                              active: true,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel5,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep4Widget(
                              active: true,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel6,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep4Widget(
                              active: false,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel7,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep4Widget(
                              active: false,
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 4.0)),
                    ),
                  ),
                ].divide(SizedBox(width: 4.0)),
              ),
              Container(
                height: 32.0,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your training habits',
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
                    'How active are you right now?',
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
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      wrapWithModel(
                        model: _model.activityCardModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: ActivityCardWidget(
                          label: 'Just starting out',
                          selected: false,
                          value: 'starting\n',
                        ),
                      ),
                      wrapWithModel(
                        model: _model.activityCardModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: ActivityCardWidget(
                          label: '1-2 days a week',
                          selected: false,
                          value: '1_2\n',
                        ),
                      ),
                      wrapWithModel(
                        model: _model.activityCardModel3,
                        updateCallback: () => safeSetState(() {}),
                        child: ActivityCardWidget(
                          label: '3-4 days a week',
                          selected: false,
                          value: '3_4\n',
                        ),
                      ),
                      wrapWithModel(
                        model: _model.activityCardModel4,
                        updateCallback: () => safeSetState(() {}),
                        child: ActivityCardWidget(
                          label: '5+ days a week',
                          selected: false,
                          value: '5_plus\n',
                        ),
                      ),
                      Container(
                        height: 16.0,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'How many days per week can you train?',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              wrapWithModel(
                                model: _model.dayButtonModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: DayButtonWidget(
                                  selected: false,
                                  day: '1',
                                  dayNum: 1,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.dayButtonModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: DayButtonWidget(
                                  selected: false,
                                  day: '2',
                                  dayNum: 2,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.dayButtonModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: DayButtonWidget(
                                  selected: true,
                                  day: '3',
                                  dayNum: 3,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.dayButtonModel4,
                                updateCallback: () => safeSetState(() {}),
                                child: DayButtonWidget(
                                  selected: false,
                                  day: '4',
                                  dayNum: 4,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.dayButtonModel5,
                                updateCallback: () => safeSetState(() {}),
                                child: DayButtonWidget(
                                  selected: false,
                                  day: '5',
                                  dayNum: 5,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.dayButtonModel6,
                                updateCallback: () => safeSetState(() {}),
                                child: DayButtonWidget(
                                  selected: false,
                                  day: '6',
                                  dayNum: 6,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.dayButtonModel7,
                                updateCallback: () => safeSetState(() {}),
                                child: DayButtonWidget(
                                  selected: false,
                                  day: '7',
                                  dayNum: 7,
                                ),
                              ),
                            ],
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  ),
                ),
              ),
              Container(),
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
