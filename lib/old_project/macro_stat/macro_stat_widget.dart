import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'macro_stat_model.dart';
export 'macro_stat_model.dart';

class MacroStatWidget extends StatefulWidget {
  const MacroStatWidget({
    super.key,
    String? label,
    String? color,
    String? value,
  })  : this.label = label ?? 'Protein',
        this.color = color ?? 'on_secondary',
        this.value = value ?? '0 g';

  final String label;
  final String color;
  final String value;

  @override
  State<MacroStatWidget> createState() => _MacroStatWidgetState();
}

class _MacroStatWidgetState extends State<MacroStatWidget> {
  late MacroStatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MacroStatModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          valueOrDefault<String>(
            widget.label,
            'Protein',
          ),
          style: FlutterFlowTheme.of(context).labelSmall.override(
                font: GoogleFonts.manrope(
                  fontWeight:
                      FlutterFlowTheme.of(context).labelSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                ),
                color: Color(0xFF777777),
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                lineHeight: 1.4,
              ),
        ),
        LinearPercentIndicator(
          percent: 0.0,
          lineHeight: 4.0,
          animation: true,
          animateFromLastPercent: true,
          progressColor: Color(0xFFFF6A00),
          backgroundColor: FlutterFlowTheme.of(context).alternate,
          barRadius: Radius.circular(2.0),
          padding: EdgeInsets.zero,
        ),
        Text(
          valueOrDefault<String>(
            widget.value,
            '0 g',
          ),
          style: FlutterFlowTheme.of(context).labelSmall.override(
                font: GoogleFonts.manrope(
                  fontWeight: FontWeight.w600,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).primaryText,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                lineHeight: 1.4,
              ),
        ),
      ].divide(SizedBox(height: 4.0)),
    );
  }
}
