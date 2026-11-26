import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/old_project/goal_card/goal_card_widget.dart';
import '/old_project/progress_step2/progress_step2_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'fitness_onboarding_step_page2_model.dart';
export 'fitness_onboarding_step_page2_model.dart';

/// Fitness app onboarding step 3 of 7, white background.
///
/// Top-left orange Envision logo and wordmark. Below: back arrow and 7 thin
/// progress bars, first three orange, rest light gray, no step text. Large
/// bold heading "What are you working toward?" and gray subtitle "Your coach
/// will use this to personalize your training and nutrition." Five selectable
/// goal cards, each with a black outlined icon on the left, bold title and
/// small gray description: Build Muscle (Increase size and lean muscle) shown
/// selected with orange border and orange check circle; Lose Fat (Reduce body
/// fat while maintaining muscle); Get Stronger (Improve strength and
/// performance); Improve Endurance (Build stamina and conditioning); Maintain
/// Fitness (Stay consistent with your progress). Unselected cards have thin
/// gray border and empty circle. Below: label "Anything specific you'd like
/// to achieve? (Optional)" and a text field with placeholder "I want to bench
/// 225 lbs." Bottom: full-width black rounded "Continue" button with white
/// text. Orange #FF6500, text #0B0B0B, gray #85858D.
class FitnessOnboardingStepPage2Widget extends StatefulWidget {
  const FitnessOnboardingStepPage2Widget({super.key});

  static String routeName = 'FitnessOnboardingStepPage2';
  static String routePath = '/fitnessOnboardingStepPage2';

  @override
  State<FitnessOnboardingStepPage2Widget> createState() =>
      _FitnessOnboardingStepPage2WidgetState();
}

class _FitnessOnboardingStepPage2WidgetState
    extends State<FitnessOnboardingStepPage2Widget> {
  late FitnessOnboardingStepPage2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FitnessOnboardingStepPage2Model());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'FitnessOnboardingStepPage2'});
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
        backgroundColor: Colors.white,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/Three_Orange_Slashes_Logo.png',
                        width: 24.0,
                        height: 44.9,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'Envision',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                      Icons.arrow_back_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
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
                            child: ProgressStep2Widget(
                              active: true,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep2Widget(
                              active: true,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel3,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep2Widget(
                              active: true,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel4,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep2Widget(
                              active: false,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel5,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep2Widget(
                              active: false,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel6,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep2Widget(
                              active: false,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: wrapWithModel(
                            model: _model.progressStepModel7,
                            updateCallback: () => safeSetState(() {}),
                            child: ProgressStep2Widget(
                              active: false,
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 4.0)),
                    ),
                  ),
                ].divide(SizedBox(width: 16.0)),
              ),
              Container(
                height: 32.0,
              ),
              Text(
                'What are you working toward?',
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
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                      lineHeight: 1.4,
                    ),
              ),
              Container(
                height: 8.0,
              ),
              Text(
                'Your coach will use this to personalize your training and nutrition.',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.manrope(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      lineHeight: 1.4,
                    ),
              ),
              Container(
                height: 32.0,
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
                        model: _model.goalCardModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: GoalCardWidget(
                          icon: Icon(
                            Icons.fitness_center_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 28.0,
                          ),
                          title: 'Build Muscle',
                          desc: 'Increase size and lean muscle',
                          selected:
                              FFAppState().obGoals.contains('build_muscle') ==
                                  true,
                          onTap: () async {},
                        ),
                      ),
                      wrapWithModel(
                        model: _model.goalCardModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: GoalCardWidget(
                          icon: Icon(
                            Icons.local_fire_department_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 28.0,
                          ),
                          title: 'Lose Fat',
                          desc: 'Reduce body fat while maintaining muscle',
                          selected:
                              FFAppState().obGoals.contains('lose_fat') == true,
                          onTap: () async {},
                        ),
                      ),
                      wrapWithModel(
                        model: _model.goalCardModel3,
                        updateCallback: () => safeSetState(() {}),
                        child: GoalCardWidget(
                          icon: Icon(
                            Icons.electric_bolt_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 28.0,
                          ),
                          title: 'Get Stronger',
                          desc: 'Improve strength and performance',
                          selected:
                              FFAppState().obGoals.contains('get_stronger') ==
                                  true,
                          onTap: () async {},
                        ),
                      ),
                      wrapWithModel(
                        model: _model.goalCardModel4,
                        updateCallback: () => safeSetState(() {}),
                        child: GoalCardWidget(
                          icon: Icon(
                            Icons.speed_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 28.0,
                          ),
                          title: 'Improve Endurance',
                          desc: 'Build stamina and conditioning',
                          selected: FFAppState()
                                  .obGoals
                                  .contains('improve_endurance') ==
                              true,
                          onTap: () async {},
                        ),
                      ),
                      wrapWithModel(
                        model: _model.goalCardModel5,
                        updateCallback: () => safeSetState(() {}),
                        child: GoalCardWidget(
                          icon: Icon(
                            Icons.favorite_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 28.0,
                          ),
                          title: 'Maintain Fitness',
                          desc: 'Stay consistent with your progress',
                          selected: FFAppState()
                                  .obGoals
                                  .contains('maintain_fitness') ==
                              true,
                          onTap: () async {},
                        ),
                      ),
                      Container(
                        height: 24.0,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Anything specific you\'d like to achieve? (Optional)',
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                        ].divide(SizedBox(height: 8.0)),
                      ),
                      Container(
                        height: 24.0,
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  ),
                ),
              ),
              FFButtonWidget(
                onPressed: () {
                  print('Continu pressed ...');
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
