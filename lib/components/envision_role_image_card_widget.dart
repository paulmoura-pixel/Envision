import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'envision_role_image_card_model.dart';
export 'envision_role_image_card_model.dart';

class EnvisionRoleImageCardWidget extends StatefulWidget {
  const EnvisionRoleImageCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  final String? title;
  final String? subtitle;
  final String? imagePath;
  final bool? isSelected;
  final Future Function()? onTap;

  @override
  State<EnvisionRoleImageCardWidget> createState() =>
      _EnvisionRoleImageCardWidgetState();
}

class _EnvisionRoleImageCardWidgetState
    extends State<EnvisionRoleImageCardWidget> {
  late EnvisionRoleImageCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnvisionRoleImageCardModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        height: 190.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: widget.isSelected! ? Color(0xFFFF6A00) : Color(0x00FFFFFF),
            width: 2.0,
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional(0.0, 0.0),
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24.0),
                  child: Image.asset(
                    'assets/images/role-coach-card.jpg',
                    width: double.infinity,
                    height: 220.0,
                    fit: BoxFit.cover,
                  ),
                ),
                if (widget.title == 'Client')
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: Image.asset(
                      'assets/images/role-client-card.jpg',
                      width: double.infinity,
                      height: 220.0,
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 220.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Color(0xE6000000)],
                  stops: [0.25, 1.0],
                  begin: AlignmentDirectional(0.0, 1.0),
                  end: AlignmentDirectional(0, -1.0),
                ),
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-1.0, 1.0),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: (FFMainAxisAlignment.end).flutterValue,
                  crossAxisAlignment: (FFCrossAxisAlignment.start).flutterValue,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget.title,
                        'Coach',
                      ),
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                font: GoogleFonts.outfit(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontStyle,
                                ),
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .fontStyle,
                              ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget.subtitle,
                        'Subtitle',
                      ),
                      maxLines: 2,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.manrope(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            color: Colors.white,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                    ),
                  ].divide(SizedBox(height: 6.0)),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.92, -0.8),
              child: Container(
                width: 32.0,
                height: 32.0,
                decoration: BoxDecoration(
                  color: widget.isSelected!
                      ? Color(0xFFFF6A00)
                      : Color(0x40000000),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Visibility(
                  visible: widget.isSelected ?? true,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16.0,
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
