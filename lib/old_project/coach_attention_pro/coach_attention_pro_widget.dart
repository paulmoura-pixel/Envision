import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/old_project/env_client_card/env_client_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'coach_attention_pro_model.dart';
export 'coach_attention_pro_model.dart';

/// DSL component CoachAttentionPro
class CoachAttentionProWidget extends StatefulWidget {
  const CoachAttentionProWidget({super.key});

  @override
  State<CoachAttentionProWidget> createState() =>
      _CoachAttentionProWidgetState();
}

class _CoachAttentionProWidgetState extends State<CoachAttentionProWidget> {
  late CoachAttentionProModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CoachAttentionProModel());

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
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).nightBorder,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
          crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
              crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                  child: Text(
                    'Client attention',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).nightText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                  ),
                ),
                Text(
                  'View all',
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        font: GoogleFonts.manrope(
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).lime,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).labelMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
                      ),
                ),
              ],
            ),
            wrapWithModel(
              model: _model.envClientCardModel1,
              updateCallback: () => safeSetState(() {}),
              child: EnvClientCardWidget(
                clientName: 'Maya Chen',
                status: 'Workout complete · nutrition on track',
                score: '92%',
              ),
            ),
            wrapWithModel(
              model: _model.envClientCardModel2,
              updateCallback: () => safeSetState(() {}),
              child: EnvClientCardWidget(
                clientName: 'Jordan Lee',
                status: 'Missed check-in · needs attention',
                score: '58%',
              ),
            ),
            wrapWithModel(
              model: _model.envClientCardModel3,
              updateCallback: () => safeSetState(() {}),
              child: EnvClientCardWidget(
                clientName: 'Alex Morgan',
                status: 'Lower body scheduled',
                score: '71%',
              ),
            ),
            wrapWithModel(
              model: _model.envClientCardModel4,
              updateCallback: () => safeSetState(() {}),
              child: EnvClientCardWidget(
                clientName: 'Priya Shah',
                status: 'Rest day · on track',
                score: '88%',
              ),
            ),
          ].divide(SizedBox(height: 10.0)),
        ),
      ),
    );
  }
}
