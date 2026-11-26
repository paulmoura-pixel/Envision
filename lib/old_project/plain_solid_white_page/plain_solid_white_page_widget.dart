import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'plain_solid_white_page_model.dart';
export 'plain_solid_white_page_model.dart';

/// Plain solid white mobile screen, no logo, no progress bars, no background
/// image, no checklist.
///
/// Vertically and horizontally centered: a large orange (#FF6500) circle with
/// a white checkmark, then bold heading "You're all set, Isaac!" in #0B0B0B,
/// then gray (#85858D) subtitle "Your coach has been notified and your
/// profile is ready." At the bottom, full width rounded orange (#FF6500)
/// button with white text "Go to My Dashboard".
class PlainSolidWhitePageWidget extends StatefulWidget {
  const PlainSolidWhitePageWidget({super.key});

  static String routeName = 'PlainSolidWhitePage';
  static String routePath = '/plainSolidWhitePage';

  @override
  State<PlainSolidWhitePageWidget> createState() =>
      _PlainSolidWhitePageWidgetState();
}

class _PlainSolidWhitePageWidgetState extends State<PlainSolidWhitePageWidget> {
  late PlainSolidWhitePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlainSolidWhitePageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'PlainSolidWhitePage'});
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
        backgroundColor: Colors.white,
        body: Stack(
          alignment: AlignmentDirectional(-1.0, -1.0),
          children: [
            Container(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 96.0,
                    height: 96.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFFF6500),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12.0,
                          color: Color(0xFFFF6500),
                          offset: Offset(
                            0.0,
                            4.0,
                          ),
                          spreadRadius: 0.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(9999.0),
                      shape: BoxShape.rectangle,
                    ),
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 48.0,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'You\'re all set, Isaac!',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 28.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                              lineHeight: 1.4,
                            ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 280.0,
                        ),
                        child: Text(
                          'Your coach has been notified and your profile is ready.',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                                font: GoogleFonts.manrope(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .fontStyle,
                                lineHeight: 1.4,
                              ),
                        ),
                      ),
                    ].divide(SizedBox(height: 8.0)),
                  ),
                ].divide(SizedBox(height: 24.0)),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Container(
                    child: Container(
                      width: 0.0,
                      height: 0.0,
                    ),
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
