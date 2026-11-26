import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'day_button_model.dart';
export 'day_button_model.dart';

class DayButtonWidget extends StatefulWidget {
  const DayButtonWidget({
    super.key,
    bool? selected,
    String? day,
    this.dayNum,
  })  : this.selected = selected ?? false,
        this.day = day ?? '1';

  final bool selected;
  final String day;
  final int? dayNum;

  @override
  State<DayButtonWidget> createState() => _DayButtonWidgetState();
}

class _DayButtonWidgetState extends State<DayButtonWidget> {
  late DayButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DayButtonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        logFirebaseEvent('DAY_BUTTON_COMP_Container_ON_TAP');
        logFirebaseEvent('Container_update_app_state');
        FFAppState().obDaysPerWeek = widget.dayNum!;
        _model.updatePage(() {});
      },
      child: Container(
        width: 44.0,
        height: 44.0,
        decoration: BoxDecoration(
          color: valueOrDefault<Color>(
            FFAppState().obDaysPerWeek == widget.dayNum
                ? Color(0xFFFF6500)
                : FlutterFlowTheme.of(context).secondaryBackground,
            Color(0x00000000),
          ),
          borderRadius: BorderRadius.circular(9999.0),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: valueOrDefault<Color>(
              FFAppState().obDaysPerWeek == widget.dayNum
                  ? Color(0xFFFF6500)
                  : Color(0xFFE5E5E7),
              Color(0x00000000),
            ),
            width: 1.0,
          ),
        ),
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Text(
          valueOrDefault<String>(
            widget.day,
            '1',
          ),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
                color: valueOrDefault<Color>(
                  FFAppState().obDaysPerWeek == widget.dayNum
                      ? Color(0x00000000)
                      : FlutterFlowTheme.of(context).secondaryText,
                  Color(0x00000000),
                ),
                letterSpacing: 0.0,
                fontWeight: FontWeight.bold,
                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                lineHeight: 1.4,
              ),
        ),
      ),
    );
  }
}
