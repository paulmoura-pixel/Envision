import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'macro_stat2_model.dart';
export 'macro_stat2_model.dart';

class MacroStat2Widget extends StatefulWidget {
  const MacroStat2Widget({
    super.key,
    String? label,
    String? value,
    double? progress,
  })  : this.label = label ?? 'Protein',
        this.value = value ?? '85/160 g',
        this.progress = progress ?? 0.53;

  final String label;
  final String value;
  final double progress;

  @override
  State<MacroStat2Widget> createState() => _MacroStat2WidgetState();
}

class _MacroStat2WidgetState extends State<MacroStat2Widget> {
  late MacroStat2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MacroStat2Model());

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
      crossAxisAlignment: CrossAxisAlignment.center,
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
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                lineHeight: 1.4,
              ),
        ),
        Text(
          valueOrDefault<String>(
            widget.value,
            '85/160 g',
          ),
          style: FlutterFlowTheme.of(context).bodySmall.override(
                font: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).primaryText,
                letterSpacing: 0.0,
                fontWeight: FontWeight.bold,
                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                lineHeight: 1.4,
              ),
        ),
        LinearPercentIndicator(
          percent: valueOrDefault<double>(
            widget.progress,
            0.53,
          ),
          lineHeight: 4.0,
          animation: true,
          animateFromLastPercent: true,
          progressColor: Color(0xFFFF6500),
          backgroundColor: Color(0x1A85858D),
          barRadius: Radius.circular(2.0),
          padding: EdgeInsets.zero,
        ),
      ].divide(SizedBox(height: 4.0)),
    );
  }
}
