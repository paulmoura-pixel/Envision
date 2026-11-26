import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'client_confirm_model.dart';
export 'client_confirm_model.dart';

/// Client confirmation and completion routing.
class ClientConfirmWidget extends StatefulWidget {
  const ClientConfirmWidget({
    super.key,
    this.trainingSpace,
    this.inviteDetails,
  });

  final UsersRecord? trainingSpace;
  final dynamic inviteDetails;

  static String routeName = 'ClientConfirm';
  static String routePath = '/client-confirm';

  @override
  State<ClientConfirmWidget> createState() => _ClientConfirmWidgetState();
}

class _ClientConfirmWidgetState extends State<ClientConfirmWidget> {
  late ClientConfirmModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClientConfirmModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ClientConfirm'});
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
                Text(
                  'Confirm your training space.',
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
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F4),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                          (FFMainAxisAlignment.start).flutterValue,
                      crossAxisAlignment:
                          (FFCrossAxisAlignment.start).flutterValue,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        if (widget.trainingSpace != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: CachedNetworkImage(
                              fadeInDuration: Duration(milliseconds: 500),
                              fadeOutDuration: Duration(milliseconds: 500),
                              imageUrl: widget.trainingSpace!.gymImage,
                              width: double.infinity,
                              height: 160.0,
                              fit: BoxFit.cover,
                              errorWidget: (context, error, stackTrace) =>
                                  Image.asset(
                                'assets/images/error_image.jpg',
                                width: double.infinity,
                                height: 160.0,
                                fit: BoxFit.cover,
                              ),
                              memCacheWidth: 900,
                            ),
                          ),
                        Text(
                          valueOrDefault<String>(
                            getJsonField(
                              widget.inviteDetails,
                              r'''$.gymName''',
                            )?.toString(),
                            'Training space',
                          ),
                          style:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                        ),
                        Text(
                          valueOrDefault<String>(
                            getJsonField(
                              widget.inviteDetails,
                              r'''$.coachName''',
                            )?.toString(),
                            'Your coach',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                font: GoogleFonts.manrope(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                  ),
                ),
                Spacer(),
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('CLIENT_CONFIRM_PAGE_Button_ON_TAP');
                    if (getJsonField(
                          widget.inviteDetails,
                          r'''$.code''',
                        ) !=
                        null) {
                      logFirebaseEvent('Button_update_app_state');
                      FFAppState().envisionInviteCode = getJsonField(
                        widget.inviteDetails,
                        r'''$.code''',
                      ).toString();
                      safeSetState(() {});
                      logFirebaseEvent('Button_backend_call');

                      await currentUserReference!.update(createUsersRecordData(
                        onboardingStep: 'FitnessOnboardingStepPage7',
                        onboardingComplete: false,
                      ));
                      logFirebaseEvent('Button_navigate_to');

                      context
                          .goNamed(FitnessOnboardingStepPage7Widget.routeName);
                    } else {
                      logFirebaseEvent('Button_show_snack_bar');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Unable to find your trainer. Please return and enter your trainer code again.',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondary,
                        ),
                      );
                    }
                  },
                  text: 'Join training space',
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
                Container(
                  width: double.infinity,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                ),
              ].divide(SizedBox(height: 18.0)),
            ),
          ),
        ),
      ),
    );
  }
}
