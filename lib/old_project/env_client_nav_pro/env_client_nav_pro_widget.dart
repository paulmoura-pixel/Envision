import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'env_client_nav_pro_model.dart';
export 'env_client_nav_pro_model.dart';

/// DSL component EnvClientNavPro
class EnvClientNavProWidget extends StatefulWidget {
  const EnvClientNavProWidget({
    super.key,
    this.label,
    this.selected,
  });

  final String? label;
  final bool? selected;

  @override
  State<EnvClientNavProWidget> createState() => _EnvClientNavProWidgetState();
}

class _EnvClientNavProWidgetState extends State<EnvClientNavProWidget> {
  late EnvClientNavProModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnvClientNavProModel());

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
      mainAxisAlignment: (FFMainAxisAlignment.center).flutterValue,
      crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Stack(
          alignment: AlignmentDirectional(0.0, 0.0),
          children: [
            if (widget.label == 'Home')
              Icon(
                Icons.home_rounded,
                color: widget.selected!
                    ? FlutterFlowTheme.of(context).lime
                    : FlutterFlowTheme.of(context).nightMuted,
                size: 22.0,
              ),
            if (widget.label == 'Training')
              Icon(
                Icons.fitness_center_rounded,
                color: widget.selected!
                    ? FlutterFlowTheme.of(context).lime
                    : FlutterFlowTheme.of(context).nightMuted,
                size: 22.0,
              ),
            if (widget.label == 'Nutrition')
              Icon(
                Icons.restaurant_rounded,
                color: widget.selected!
                    ? FlutterFlowTheme.of(context).lime
                    : FlutterFlowTheme.of(context).nightMuted,
                size: 22.0,
              ),
            if (widget.label == 'Progress')
              Icon(
                Icons.show_chart_rounded,
                color: widget.selected!
                    ? FlutterFlowTheme.of(context).lime
                    : FlutterFlowTheme.of(context).nightMuted,
                size: 22.0,
              ),
          ],
        ),
        Text(
          widget.label!,
          style: FlutterFlowTheme.of(context).labelMedium.override(
                font: GoogleFonts.manrope(
                  fontWeight:
                      FlutterFlowTheme.of(context).labelMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                ),
                color: widget.selected!
                    ? FlutterFlowTheme.of(context).lime
                    : FlutterFlowTheme.of(context).nightMuted,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
              ),
        ),
      ].divide(SizedBox(height: 3.0)),
    );
  }
}
