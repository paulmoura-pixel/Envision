import '/auth/firebase_auth/auth_util.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'coach_complete_model.dart';
export 'coach_complete_model.dart';

/// Coach invite code and setup completion state.
class CoachCompleteWidget extends StatefulWidget {
  const CoachCompleteWidget({super.key});

  static String routeName = 'CoachComplete';
  static String routePath = '/coach-complete';

  @override
  State<CoachCompleteWidget> createState() => _CoachCompleteWidgetState();
}

class _CoachCompleteWidgetState extends State<CoachCompleteWidget> {
  late CoachCompleteModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CoachCompleteModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'CoachComplete'});
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: (FFMainAxisAlignment.center).flutterValue,
              crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: FlutterFlowTheme.of(context).primary,
                  size: 76.0,
                ),
                AuthUserStreamWidget(
                  builder: (context) => Text(
                    '${valueOrDefault(currentUserDocument?.gymName, '')} is ready.',
                    textAlign: TextAlign.center,
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
                ),
                AuthUserStreamWidget(
                  builder: (context) => Text(
                    valueOrDefault(
                                    currentUserDocument?.coachCode, '') ==
                                ''
                        ? 'Generate a coach code so clients can join your training space.'
                        : '\tShare this code with clients so they can join your training space.',
                    textAlign: TextAlign.center,
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
                ),
                if (valueOrDefault(currentUserDocument?.coachCode, '') != '')
                  AuthUserStreamWidget(
                    builder: (context) => Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              valueOrDefault(
                                  currentUserDocument?.coachCode, ''),
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
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
                          ),
                          if (valueOrDefault(
                                      currentUserDocument?.coachCode, '') ==
                                  '')
                            FFButtonWidget(
                              onPressed: () async {
                                logFirebaseEvent(
                                    'COACH_COMPLETE_PAGE_copyCode_ON_TAP');
                                logFirebaseEvent('copyCode_copy_to_clipboard');
                                await Clipboard.setData(ClipboardData(
                                    text: valueOrDefault(
                                        currentUserDocument?.coachCode, '')));
                              },
                              text: 'Copy Code',
                              options: FFButtonOptions(
                                width: 150.0,
                                height: 56.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primaryText,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                ),
                                borderRadius: BorderRadius.circular(999.0),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                if (valueOrDefault(currentUserDocument?.coachCode, '') == '')
                  AuthUserStreamWidget(
                    builder: (context) => FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'COACH_COMPLETE_PAGE_GenerateCode_ON_TAP');
                        logFirebaseEvent('GenerateCode_cloud_function');
                        try {
                          final result = await FirebaseFunctions.instanceFor(
                                  region: 'us-central1')
                              .httpsCallable('generateCoachCode')
                              .call({});
                          _model.generatedCoachCode =
                              GenerateCoachCodeCloudFunctionCallResponse(
                            data: result.data,
                            succeeded: true,
                            resultAsString: result.data.toString(),
                            jsonBody: result.data,
                          );
                        } on FirebaseFunctionsException catch (error) {
                          _model.generatedCoachCode =
                              GenerateCoachCodeCloudFunctionCallResponse(
                            errorCode: error.code,
                            succeeded: false,
                          );
                        }

                        safeSetState(() {});
                      },
                      text: 'Generate Coach Code',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 56.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primaryText,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                        borderRadius: BorderRadius.circular(999.0),
                      ),
                    ),
                  ),
                if (valueOrDefault(currentUserDocument?.coachCode, '') != '')
                  AuthUserStreamWidget(
                    builder: (context) => FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'COACH_COMPLETE_PAGE_go2Dashboard_ON_TAP');
                        logFirebaseEvent('go2Dashboard_navigate_to');

                        context.pushNamed(EnvisionCoachProWidget.routeName);
                      },
                      text: 'Go to coach dashboard',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 56.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primaryText,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                        borderRadius: BorderRadius.circular(999.0),
                      ),
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
