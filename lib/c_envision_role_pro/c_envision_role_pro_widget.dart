import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/envision_primary_button_widget.dart';
import '/components/envision_role_image_card_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'c_envision_role_pro_model.dart';
export 'c_envision_role_pro_model.dart';

/// Premium role routing into code-backed client and coach workspaces.
class CEnvisionRoleProWidget extends StatefulWidget {
  const CEnvisionRoleProWidget({super.key});

  static String routeName = 'CEnvisionRolePro';
  static String routePath = '/envision-role-pro';

  @override
  State<CEnvisionRoleProWidget> createState() => _CEnvisionRoleProWidgetState();
}

class _CEnvisionRoleProWidgetState extends State<CEnvisionRoleProWidget> {
  late CEnvisionRoleProModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CEnvisionRoleProModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'CEnvisionRolePro'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('C_ENVISION_ROLE_PRO_CEnvisionRolePro_ON_');
      logFirebaseEvent('CEnvisionRolePro_custom_action');
      await actions.obResumeSignup(
        context,
      );
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                        (FFMainAxisAlignment.center).flutterValue,
                    crossAxisAlignment:
                        (FFCrossAxisAlignment.center).flutterValue,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/Three_Orange_Slashes_Logo.png',
                          width: 30.0,
                          height: 30.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        'Envision',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              fontSize: 24.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ].divide(SizedBox(width: 8.0)),
                  ),
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
                            color: FlutterFlowTheme.of(context).alternate,
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
                    'How will you use Envision?',
                    maxLines: 2,
                    style: FlutterFlowTheme.of(context).displaySmall.override(
                          font: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .displaySmall
                                .fontStyle,
                          ),
                          fontSize: 32.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FlutterFlowTheme.of(context)
                              .displaySmall
                              .fontStyle,
                        ),
                  ),
                  Text(
                    'Choose the account that best fits you. You can always change this later.',
                    maxLines: 3,
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
                          fontSize: 15.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'C_ENVISION_ROLE_PRO_Container_plxxfm90_O');
                      logFirebaseEvent('Container_update_page_state');
                      _model.selectedRole = 'coach';
                      safeSetState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'C_ENVISION_ROLE_PRO_Container_czu81mi0_O');
                          logFirebaseEvent(
                              'EnvisionRoleImageCard_update_page_state');
                          _model.selectedRole = 'coach';
                          safeSetState(() {});
                        },
                        child: wrapWithModel(
                          model: _model.envisionRoleImageCardModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: EnvisionRoleImageCardWidget(
                            title: 'Coach\n',
                            subtitle:
                                'Train clients, build programs, and track their progress.\n',
                            imagePath:
                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/envision-8wd5is/assets/hx8mo1egxhny/jonathan-borba-R0y_bEUjiOM-unsplash.jpg',
                            isSelected: _model.selectedRole == 'coach',
                            onTap: () async {},
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'C_ENVISION_ROLE_PRO_Container_wro0hs7n_O');
                      logFirebaseEvent('Container_update_page_state');
                      _model.selectedRole = 'client';
                      safeSetState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'C_ENVISION_ROLE_PRO_Container_49v97a50_O');
                          logFirebaseEvent(
                              'EnvisionRoleImageCard_update_page_state');
                          _model.selectedRole = 'client';
                          safeSetState(() {});
                        },
                        child: wrapWithModel(
                          model: _model.envisionRoleImageCardModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: EnvisionRoleImageCardWidget(
                            title: 'Client',
                            subtitle:
                                'Join a coach, log your workouts and nutrition, and track progress.',
                            imagePath:
                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/envision-8wd5is/assets/1i8uphw1mft8/mathias-reding-MiRyAuFhepg-unsplash.jpg',
                            isSelected: _model.selectedRole == 'client',
                            onTap: () async {},
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    child: Visibility(
                      visible: _model.selectedRole == 'coach',
                      child: wrapWithModel(
                        model: _model.envisionPrimaryButtonModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: EnvisionPrimaryButtonWidget(
                          onTap: () async {
                            logFirebaseEvent(
                                'C_ENVISION_ROLE_PRO_Container_cugchv9q_C');
                            logFirebaseEvent(
                                'EnvisionPrimaryButton_backend_call');

                            await currentUserReference!
                                .update(createUsersRecordData(
                              role: 'coach',
                              onboardingStep: 'CoachSetup',
                              onboardingComplete: false,
                            ));
                            logFirebaseEvent(
                                'EnvisionPrimaryButton_navigate_to');

                            context.pushNamed(CoachSetupWidget.routeName);
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    child: Visibility(
                      visible: _model.selectedRole == 'client',
                      child: wrapWithModel(
                        model: _model.envisionPrimaryButtonModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: EnvisionPrimaryButtonWidget(
                          onTap: () async {
                            logFirebaseEvent(
                                'C_ENVISION_ROLE_PRO_Container_8nth4x0d_C');
                            logFirebaseEvent(
                                'EnvisionPrimaryButton_backend_call');

                            await currentUserReference!
                                .update(createUsersRecordData(
                              role: 'client',
                              onboardingStep: 'ClientJoin',
                              onboardingComplete: false,
                            ));
                            logFirebaseEvent(
                                'EnvisionPrimaryButton_navigate_to');

                            context.goNamed(ClientJoinWidget.routeName);
                          },
                        ),
                      ),
                    ),
                  ),
                  if (_model.selectedRole == 'none')
                    Opacity(
                      opacity: 0.4,
                      child: wrapWithModel(
                        model: _model.envisionPrimaryButtonModel3,
                        updateCallback: () => safeSetState(() {}),
                        child: EnvisionPrimaryButtonWidget(
                          onTap: () async {},
                        ),
                      ),
                    ),
                ].divide(SizedBox(height: 14.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
