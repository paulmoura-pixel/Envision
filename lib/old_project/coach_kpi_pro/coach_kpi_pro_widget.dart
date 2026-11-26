import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'coach_kpi_pro_model.dart';
export 'coach_kpi_pro_model.dart';

/// DSL component CoachKpiPro
class CoachKpiProWidget extends StatefulWidget {
  const CoachKpiProWidget({
    super.key,
    this.value,
    this.label,
  });

  final String? value;
  final String? label;

  @override
  State<CoachKpiProWidget> createState() => _CoachKpiProWidgetState();
}

class _CoachKpiProWidgetState extends State<CoachKpiProWidget> {
  late CoachKpiProModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CoachKpiProModel());

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
      height: 142.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).nightCard,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).nightBorder,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
          crossAxisAlignment: (FFCrossAxisAlignment.start).flutterValue,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Stack(
              alignment: AlignmentDirectional(0.0, 0.0),
              children: [
                if (widget.label == 'Active clients')
                  Icon(
                    Icons.people_alt_rounded,
                    color: FlutterFlowTheme.of(context).lime,
                    size: 21.0,
                  ),
                if (widget.label == 'Trained today')
                  Icon(
                    Icons.fitness_center_rounded,
                    color: FlutterFlowTheme.of(context).lime,
                    size: 21.0,
                  ),
                if (widget.label == 'Need attention')
                  Icon(
                    Icons.warning_amber_rounded,
                    color: FlutterFlowTheme.of(context).lime,
                    size: 21.0,
                  ),
                if (widget.label == 'Meals unlogged')
                  Icon(
                    Icons.restaurant_rounded,
                    color: FlutterFlowTheme.of(context).lime,
                    size: 21.0,
                  ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Text(
              widget.value!,
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    font: GoogleFonts.outfit(
                      fontWeight: FlutterFlowTheme.of(context)
                          .headlineMedium
                          .fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).nightText,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
            ),
            Text(
              widget.label!,
              style: FlutterFlowTheme.of(context).bodySmall.override(
                    font: GoogleFonts.manrope(
                      fontWeight:
                          FlutterFlowTheme.of(context).bodySmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodySmall.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).nightMuted,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).bodySmall.fontWeight,
                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                  ),
            ),
          ].divide(SizedBox(height: 5.0)),
        ),
      ),
    );
  }
}
