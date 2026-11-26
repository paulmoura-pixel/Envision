import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'client_join_model.dart';
export 'client_join_model.dart';

/// Client invite-code entry.
class ClientJoinWidget extends StatefulWidget {
  const ClientJoinWidget({
    super.key,
    this.code,
  });

  /// Invite code from a shared link (optional)
  final String? code;

  static String routeName = 'ClientJoin';
  static String routePath = '/client-join';

  @override
  State<ClientJoinWidget> createState() => _ClientJoinWidgetState();
}

class _ClientJoinWidgetState extends State<ClientJoinWidget> {
  late ClientJoinModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClientJoinModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'ClientJoin'});
    _model.inviteCodeFieldTextController ??=
        TextEditingController(text: widget.code);
    _model.inviteCodeFieldFocusNode ??= FocusNode();

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
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: (FFMainAxisAlignment.center).flutterValue,
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
                  'Join your trainer',
                  style: FlutterFlowTheme.of(context).headlineLarge.override(
                        font: GoogleFonts.outfit(
                          fontWeight: FlutterFlowTheme.of(context)
                              .headlineLarge
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineLarge
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context)
                            .headlineLarge
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineLarge
                            .fontStyle,
                      ),
                ),
                Text(
                  'Enter the code from your coach or gym to join their training space.',
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        font: GoogleFonts.manrope(
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      ),
                ),
                TextFormField(
                  controller: _model.inviteCodeFieldTextController,
                  focusNode: _model.inviteCodeFieldFocusNode,
                  onChanged: (_) => EasyDebounce.debounce(
                    '_model.inviteCodeFieldTextController',
                    Duration(milliseconds: 2000),
                    () async {
                      logFirebaseEvent(
                          'CLIENT_JOIN_InviteCodeField_ON_TEXTFIELD');
                      logFirebaseEvent('InviteCodeField_update_page_state');
                      _model.inviteCode =
                          _model.inviteCodeFieldTextController.text;
                      safeSetState(() {});
                    },
                  ),
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Invite code',
                    hintText: 'RSF728',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    filled: true,
                  ),
                  style: TextStyle(),
                  maxLines: null,
                  validator: _model.inviteCodeFieldTextControllerValidator
                      .asValidator(context),
                ),
                Spacer(),
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('CLIENT_JOIN_PAGE_Button_ON_TAP');
                    logFirebaseEvent('Button_custom_action');
                    _model.inviteLookup = await actions.obValidateInvite(
                      _model.inviteCodeFieldTextController.text,
                    );
                    if (getJsonField(
                          _model.inviteLookup,
                          r'''$.code''',
                        ) !=
                        null) {
                      logFirebaseEvent('Button_update_app_state');
                      FFAppState().envisionInviteCode = getJsonField(
                        _model.inviteLookup,
                        r'''$.code''',
                      ).toString();
                      logFirebaseEvent('Button_navigate_to');

                      context.goNamed(
                        ClientConfirmWidget.routeName,
                        queryParameters: {
                          'inviteDetails': serializeParam(
                            _model.inviteLookup,
                            ParamType.JSON,
                          ),
                        }.withoutNulls,
                      );
                    } else {
                      logFirebaseEvent('Button_show_snack_bar');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            getJsonField(
                              _model.inviteLookup,
                              r'''$.error''',
                            ).toString(),
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              fontSize: 14.0,
                            ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor: Color(0xFF202124),
                        ),
                      );
                    }

                    safeSetState(() {});
                  },
                  text: 'Find training space',
                  icon: Icon(
                    Icons.arrow_forward_rounded,
                    size: 15.0,
                  ),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 56.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconAlignment: IconAlignment.end,
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primaryText,
                    textStyle: TextStyle(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                    borderRadius: BorderRadius.circular(999.0),
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent(
                        'CLIENT_JOIN_SkipTrainerCodeButton_ON_TAP');
                    logFirebaseEvent('SkipTrainerCodeButton_update_app_state');
                    FFAppState().envisionInviteCode = ' ';
                    logFirebaseEvent('SkipTrainerCodeButton_backend_call');

                    await currentUserReference!.update(createUsersRecordData(
                      role: 'client',
                      onboardingStep: 'FitnessOnboardingStepPage7',
                      onboardingComplete: false,
                      onboardingStatus: 'incomplete',
                    ));
                    logFirebaseEvent('SkipTrainerCodeButton_navigate_to');

                    context
                        .pushNamed(FitnessOnboardingStepPage7Widget.routeName);
                  },
                  text: 'Maybe later...',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 56.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Color(0xA49F9B9B),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(999.0),
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent(
                        'CLIENT_JOIN_UseDifferentAccountButton_ON');
                    logFirebaseEvent(
                        'UseDifferentAccountButton_update_app_sta');
                    FFAppState().envisionInviteCode = ' ';
                    logFirebaseEvent('UseDifferentAccountButton_auth');
                    GoRouter.of(context).prepareAuthEvent();
                    await authManager.signOut();
                    GoRouter.of(context).clearRedirectLocation();

                    context.goNamedAuth(
                        BEnvisionWelcomeProWidget.routeName, context.mounted);
                  },
                  text: 'Use a different account\n',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 56.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Color(0xA49F9B9B),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(999.0),
                  ),
                ),
              ].divide(SizedBox(height: 16.0)),
            ),
          ),
        ),
      ),
    );
  }
}
