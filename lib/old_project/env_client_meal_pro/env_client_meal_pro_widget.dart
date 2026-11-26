import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'env_client_meal_pro_model.dart';
export 'env_client_meal_pro_model.dart';

/// DSL component EnvClientMealPro
class EnvClientMealProWidget extends StatefulWidget {
  const EnvClientMealProWidget({
    super.key,
    this.mealName,
    this.meta,
    this.time,
  });

  final String? mealName;
  final String? meta;
  final String? time;

  @override
  State<EnvClientMealProWidget> createState() => _EnvClientMealProWidgetState();
}

class _EnvClientMealProWidgetState extends State<EnvClientMealProWidget> {
  late EnvClientMealProModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnvClientMealProModel());

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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).nightCard,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).nightBorder,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(14.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
          crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Container(
              width: 46.0,
              height: 46.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).nightCardRaised,
                borderRadius: BorderRadius.circular(14.0),
              ),
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Stack(
                alignment: AlignmentDirectional(0.0, 0.0),
                children: [
                  if (widget.mealName == 'Avocado toast & eggs')
                    Icon(
                      Icons.egg_alt_rounded,
                      color: FlutterFlowTheme.of(context).lime,
                      size: 20.0,
                    ),
                  if (widget.mealName != 'Avocado toast & eggs')
                    Icon(
                      Icons.restaurant_rounded,
                      color: FlutterFlowTheme.of(context).lime,
                      size: 20.0,
                    ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                crossAxisAlignment: (FFCrossAxisAlignment.start).flutterValue,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    widget.mealName!,
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).nightText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                  ),
                  Text(
                    widget.meta!,
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).nightMuted,
                          letterSpacing: 0.0,
                          fontWeight:
                              FlutterFlowTheme.of(context).bodySmall.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodySmall.fontStyle,
                        ),
                  ),
                ].divide(SizedBox(height: 4.0)),
              ),
            ),
            Text(
              widget.time!,
              style: FlutterFlowTheme.of(context).labelMedium.override(
                    font: GoogleFonts.manrope(
                      fontWeight:
                          FlutterFlowTheme.of(context).labelMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelMedium.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).lime,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).labelMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelMedium.fontStyle,
                  ),
            ),
          ].divide(SizedBox(width: 12.0)),
        ),
      ),
    );
  }
}
