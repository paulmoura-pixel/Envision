import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'envision_bottom_navigation_model.dart';
export 'envision_bottom_navigation_model.dart';

/// EnvisionBottomNavigation.
///
/// Native editable FlutterFlow component: white full-width 72px tall
/// container, thin #E5E5E7 top border, Row with five evenly spaced Expanded
/// Columns. Each column contains an outline icon size24 and text label size11
/// Inter. Home house outline, Nutrition restaurant outline active #FF6A00,
/// Progress bar chart outline, Coach people outline, Profile person outline.
/// Inactive #777777. No placeholders, no images, no custom code. All five
/// items minimum44px touch targets. Minimal iOS bottom tab bar.
class EnvisionBottomNavigationWidget extends StatefulWidget {
  const EnvisionBottomNavigationWidget({
    super.key,
    String? activeTab,
  }) : this.activeTab = activeTab ?? '';

  final String activeTab;

  @override
  State<EnvisionBottomNavigationWidget> createState() =>
      _EnvisionBottomNavigationWidgetState();
}

class _EnvisionBottomNavigationWidgetState
    extends State<EnvisionBottomNavigationWidget> {
  late EnvisionBottomNavigationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnvisionBottomNavigationModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        shape: BoxShape.rectangle,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 1.0,
            decoration: BoxDecoration(
              color: Color(0xFFE5E5E7),
              shape: BoxShape.rectangle,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
            child: Container(
              child: Container(
                height: 63.0,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.house_outlined,
                            color: valueOrDefault<Color>(
                              widget.activeTab == 'home'
                                  ? Color(0xFFFF6A00)
                                  : Color(0xFF777777),
                              Color(0x00000000),
                            ),
                            size: 24.0,
                          ),
                          Text(
                            'Home',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: valueOrDefault<Color>(
                                    widget.activeTab == 'home'
                                        ? Color(0xFFFF6A00)
                                        : Color(0xFF777777),
                                    Color(0x00000000),
                                  ),
                                  fontSize: 11.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.restaurant_outlined,
                            color: valueOrDefault<Color>(
                              widget.activeTab == 'nutrition'
                                  ? Color(0xFFFF6A00)
                                  : Color(0xFF777777),
                              Color(0x00000000),
                            ),
                            size: 24.0,
                          ),
                          Text(
                            'Nutrition',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: valueOrDefault<Color>(
                                    widget.activeTab == 'nutrition'
                                        ? Color(0xFFFF6A00)
                                        : Color(0xFF777777),
                                    Color(0x00000000),
                                  ),
                                  fontSize: 11.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bar_chart_outlined,
                            color: valueOrDefault<Color>(
                              widget.activeTab == 'progress'
                                  ? Color(0xFFFF6A00)
                                  : Color(0xFF777777),
                              Color(0x00000000),
                            ),
                            size: 24.0,
                          ),
                          Text(
                            'Progress',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: valueOrDefault<Color>(
                                    widget.activeTab == 'progress'
                                        ? Color(0xFFFF6A00)
                                        : Color(0xFF777777),
                                    Color(0x00000000),
                                  ),
                                  fontSize: 11.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people_outlined,
                            color: valueOrDefault<Color>(
                              widget.activeTab == 'coach'
                                  ? Color(0xFFFF6A00)
                                  : Color(0xFF777777),
                              Color(0x00000000),
                            ),
                            size: 24.0,
                          ),
                          Text(
                            'Coach',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: valueOrDefault<Color>(
                                    widget.activeTab == 'coach'
                                        ? Color(0xFFFF6A00)
                                        : Color(0xFF777777),
                                    Color(0x00000000),
                                  ),
                                  fontSize: 11.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_outlined,
                            color: valueOrDefault<Color>(
                              widget.activeTab == 'profile'
                                  ? Color(0xFFFF6A00)
                                  : Color(0xFF777777),
                              Color(0x00000000),
                            ),
                            size: 24.0,
                          ),
                          Text(
                            'Profile',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: valueOrDefault<Color>(
                                    widget.activeTab == 'profile'
                                        ? Color(0xFFFF6A00)
                                        : Color(0xFF777777),
                                    Color(0x00000000),
                                  ),
                                  fontSize: 11.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
