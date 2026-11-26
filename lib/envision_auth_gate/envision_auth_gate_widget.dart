import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'envision_auth_gate_model.dart';
export 'envision_auth_gate_model.dart';

/// This page will display only an Envision logo and loading indicator while
/// it checks the user's Firestore document to redirect where needed.
class EnvisionAuthGateWidget extends StatefulWidget {
  const EnvisionAuthGateWidget({super.key});

  static String routeName = 'EnvisionAuthGate';
  static String routePath = '/envisionAuthGate';

  @override
  State<EnvisionAuthGateWidget> createState() => _EnvisionAuthGateWidgetState();
}

class _EnvisionAuthGateWidgetState extends State<EnvisionAuthGateWidget> {
  late EnvisionAuthGateModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnvisionAuthGateModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EnvisionAuthGate'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ENVISION_AUTH_GATE_EnvisionAuthGate_ON_I');
      logFirebaseEvent('EnvisionAuthGate_backend_call');
      _model.gateUser =
          await UsersRecord.getDocumentOnce(currentUserReference!);
      if (_model.gateUser?.onboardingComplete == true) {
        if (_model.gateUser?.role == 'coach') {
          logFirebaseEvent('EnvisionAuthGate_navigate_to');

          context.goNamed(EnvisionCoachProWidget.routeName);
        } else {
          logFirebaseEvent('EnvisionAuthGate_navigate_to');

          context.goNamed(EnvisionDashboardWidget.routeName);
        }
      } else {
        if (_model.gateUser?.onboardingStep == 'FitnessOnboardingStepPage7') {
          logFirebaseEvent('EnvisionAuthGate_navigate_to');

          context.goNamed(FitnessOnboardingStepPage7Widget.routeName);
        } else {
          if (_model.gateUser?.onboardingStep == 'ClientJoin') {
            logFirebaseEvent('EnvisionAuthGate_navigate_to');

            context.goNamed(ClientJoinWidget.routeName);
          } else {
            if (_model.gateUser?.onboardingStep == 'ClientConfirm') {
              logFirebaseEvent('EnvisionAuthGate_navigate_to');

              context.goNamed(ClientJoinWidget.routeName);
            } else {
              if (_model.gateUser?.onboardingStep == 'CoachSetup') {
                logFirebaseEvent('EnvisionAuthGate_navigate_to');

                context.goNamed(CoachSetupWidget.routeName);
              } else {
                logFirebaseEvent('EnvisionAuthGate_navigate_to');

                context.goNamed(CEnvisionRoleProWidget.routeName);
              }
            }
          }
        }
      }
    });

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
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Image.asset(
                    'assets/images/Three_Orange_Slashes_Logo.png',
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'Envision',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.manrope(
                          fontWeight: FontWeight.w800,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 40.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w800,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        lineHeight: 1.4,
                      ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('ENVISION_AUTH_GATE_BUTTON_BTN_ON_TAP');
                    logFirebaseEvent('Button_auth');
                    GoRouter.of(context).prepareAuthEvent();
                    await authManager.signOut();
                    GoRouter.of(context).clearRedirectLocation();

                    context.goNamedAuth(
                        BEnvisionWelcomeProWidget.routeName, context.mounted);
                  },
                  text: 'Button',
                  options: FFButtonOptions(
                    height: 40.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color: Colors.white,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
