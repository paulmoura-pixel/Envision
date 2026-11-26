import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'b_envision_welcome_pro_model.dart';
export 'b_envision_welcome_pro_model.dart';

/// Cinematic entry into the code-backed premium Envision experience.
class BEnvisionWelcomeProWidget extends StatefulWidget {
  const BEnvisionWelcomeProWidget({super.key});

  static String routeName = 'BEnvisionWelcomePro';
  static String routePath = '/envision-welcome-pro';

  @override
  State<BEnvisionWelcomeProWidget> createState() =>
      _BEnvisionWelcomeProWidgetState();
}

class _BEnvisionWelcomeProWidgetState extends State<BEnvisionWelcomeProWidget> {
  late BEnvisionWelcomeProModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BEnvisionWelcomeProModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'BEnvisionWelcomePro'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('B_ENVISION_WELCOME_PRO_BEnvisionWelcomeP');
      logFirebaseEvent('BEnvisionWelcomePro_set_dark_mode_settin');
      setDarkModeSetting(context, ThemeMode.light);
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
        backgroundColor: FlutterFlowTheme.of(context).night,
        body: Stack(
          alignment: AlignmentDirectional(0.0, 0.0),
          children: [
            Image.asset(
              'assets/images/land-o-lakes-inc-D43JYb0yTKU-unsplash.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              alignment: Alignment(-0.45, 0.0),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0x12000000),
                      Color(0x22000000),
                      Color(0xE80B0D0C),
                      FlutterFlowTheme.of(context).night
                    ],
                    stops: [0.0, 0.48, 0.78, 1.0],
                    begin: AlignmentDirectional(0.0, -1.0),
                    end: AlignmentDirectional(0, 1.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 30.0, 24.0, 56.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: (FFMainAxisAlignment.end).flutterValue,
                crossAxisAlignment: (FFCrossAxisAlignment.start).flutterValue,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'Personal coaching that works.',
                    maxLines: 3,
                    style: FlutterFlowTheme.of(context).displayMedium.override(
                          font: GoogleFonts.outfit(
                            fontWeight: FlutterFlowTheme.of(context)
                                .displayMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .displayMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).nightText,
                          fontSize: 46.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .displayMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .displayMedium
                              .fontStyle,
                        ),
                  ),
                  Text(
                    'Train smarter, stay consistent, and reach your goals with your own coach.',
                    maxLines: 3,
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                          ),
                          color: Color(0xFFE6E9E4),
                          fontSize: 20.0,
                          letterSpacing: 0.0,
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                  ),
                  Stack(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'B_ENVISION_WELCOME_PRO_googleLogIn_ON_TA');
                          logFirebaseEvent('googleLogIn_auth');
                          GoRouter.of(context).prepareAuthEvent();
                          final user =
                              await authManager.signInWithGoogle(context);
                          if (user == null) {
                            return;
                          }
                          if (valueOrDefault(currentUserDocument?.role, '') !=
                                  '') {
                            if (valueOrDefault(currentUserDocument?.role, '') ==
                                'coach') {
                              logFirebaseEvent('googleLogIn_navigate_to');

                              context.goNamedAuth(
                                  EnvisionCoachProWidget.routeName,
                                  context.mounted);
                            } else {
                              logFirebaseEvent('googleLogIn_navigate_to');

                              context.goNamedAuth(
                                  EnvisionDashboardWidget.routeName,
                                  context.mounted);
                            }
                          } else {
                            logFirebaseEvent('googleLogIn_navigate_to');

                            context.pushNamedAuth(
                                CEnvisionRoleProWidget.routeName,
                                context.mounted);
                          }
                        },
                        text: 'Continue with Gmail',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 56.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Colors.transparent,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                font: GoogleFonts.manrope(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).nightText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontStyle,
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).nightBorder,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.88, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: Image.asset(
                            'assets/images/googleapis-com-logo.png',
                            width: 22.0,
                            height: 22.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'B_ENVISION_WELCOME_PRO_emailLogin_ON_TAP');
                          logFirebaseEvent('emailLogin_navigate_to');

                          context.pushNamed(EmailLoginWidget.routeName);
                        },
                        text: 'Continue with E-mail',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 56.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Colors.transparent,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                font: GoogleFonts.manrope(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).nightText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontStyle,
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).nightBorder,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ],
                  ),
                ].divide(SizedBox(height: 14.0)),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-1.0, -1.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 56.0, 0.0, 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/Three_Orange_Slashes_Logo.png',
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
