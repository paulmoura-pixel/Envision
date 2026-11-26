import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/old_project/chart_legend/chart_legend_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pie_chart_model.dart';
export 'pie_chart_model.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({
    super.key,
    String? centerValue,
    bool? centerValuePresent,
    String? centerLabel,
    bool? centerLabelPresent,
    String? data,
    String? labels,
    String? colors,
    bool? animate,
    double? startAngle,
    String? variant,
    String? size,
    String? legend,
    String? legendValue,
    String? ring,
    String? gap,
  })  : this.centerValue = centerValue ?? '0%',
        this.centerValuePresent = centerValuePresent ?? true,
        this.centerLabel = centerLabel ?? 'consumed',
        this.centerLabelPresent = centerLabelPresent ?? true,
        this.data = data ?? '0,100',
        this.labels = labels ?? 'Product,Services,Marketing,Other',
        this.colors = colors ?? 'primary,divider',
        this.animate = animate ?? false,
        this.startAngle = startAngle ?? -90.0,
        this.variant = variant ?? 'donut',
        this.size = size ?? 'medium',
        this.legend = legend ?? 'hidden',
        this.legendValue = legendValue ?? 'percent',
        this.ring = ring ?? 'thick',
        this.gap = gap ?? 'normal';

  final String centerValue;
  final bool centerValuePresent;
  final String centerLabel;
  final bool centerLabelPresent;
  final String data;
  final String labels;
  final String colors;
  final bool animate;
  final double startAngle;
  final String variant;
  final String size;
  final String legend;
  final String legendValue;
  final String ring;
  final String gap;

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  late PieChartModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PieChartModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pieChartPieChartColorsList1 = [
      FlutterFlowTheme.of(context).primary,
      FlutterFlowTheme.of(context).secondary,
      FlutterFlowTheme.of(context).tertiary
    ];
    final pieChartPieChartColorsList2 = [
      FlutterFlowTheme.of(context).primary,
      FlutterFlowTheme.of(context).secondary,
      FlutterFlowTheme.of(context).tertiary
    ];
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  children: [
                    if (valueOrDefault<bool>(
                      valueOrDefault<String>(
                                widget.variant,
                                'donut',
                              ) ==
                              'pie'
                          ? false
                          : true,
                      true,
                    ))
                      Container(
                        width: valueOrDefault<double>(
                          () {
                            if (valueOrDefault<String>(
                                  widget.size,
                                  'medium',
                                ) ==
                                'compact') {
                              return 120.0;
                            } else if (valueOrDefault<String>(
                                  widget.size,
                                  'medium',
                                ) ==
                                'large') {
                              return 200.0;
                            } else if (valueOrDefault<String>(
                                  widget.size,
                                  'medium',
                                ) ==
                                'expanded') {
                              return 240.0;
                            } else {
                              return 156.0;
                            }
                          }(),
                          156.0,
                        ),
                        height: valueOrDefault<double>(
                          () {
                            if (valueOrDefault<String>(
                                  widget.size,
                                  'medium',
                                ) ==
                                'compact') {
                              return 120.0;
                            } else if (valueOrDefault<String>(
                                  widget.size,
                                  'medium',
                                ) ==
                                'large') {
                              return 200.0;
                            } else if (valueOrDefault<String>(
                                  widget.size,
                                  'medium',
                                ) ==
                                'expanded') {
                              return 240.0;
                            } else {
                              return 156.0;
                            }
                          }(),
                          156.0,
                        ),
                        child: FlutterFlowPieChart(
                          data: FFPieChartData(
                            values: (String? data) {
                              return (data ?? '')
                                  .split(',')
                                  .map((value) =>
                                      double.tryParse(value.trim()) ?? 0)
                                  .toList();
                            }(valueOrDefault<String>(
                              widget.data,
                              '0,100',
                            )),
                            colors: pieChartPieChartColorsList1,
                            radius: [50.0],
                          ),
                          donutHoleRadius: 30.0,
                          donutHoleColor: Colors.transparent,
                          sectionLabelStyle:
                              FlutterFlowTheme.of(context).labelSmall.override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    fontSize: 10.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                    lineHeight: 1.0,
                                  ),
                          sectionsSpace: valueOrDefault<double>(
                            () {
                              if (valueOrDefault<String>(
                                    widget.gap,
                                    'normal',
                                  ) ==
                                  'none') {
                                return 0.0;
                              } else if (valueOrDefault<String>(
                                    widget.gap,
                                    'normal',
                                  ) ==
                                  'tight') {
                                return 2.0;
                              } else if (valueOrDefault<String>(
                                    widget.gap,
                                    'normal',
                                  ) ==
                                  'wide') {
                                return 8.0;
                              } else {
                                return 4.0;
                              }
                            }(),
                            4.0,
                          ),
                          startDegreeOffset: valueOrDefault<double>(
                            widget.startAngle,
                            -90.0,
                          ),
                          labelPositionOffset: 0.6,
                        ),
                      ),
                    if (valueOrDefault<bool>(
                      valueOrDefault<String>(
                                widget.variant,
                                'donut',
                              ) ==
                              'pie'
                          ? true
                          : false,
                      false,
                    ))
                      Container(
                        width: valueOrDefault<double>(
                          () {
                            if (valueOrDefault<String>(
                                  widget.size,
                                  'medium',
                                ) ==
                                'compact') {
                              return 120.0;
                            } else if (valueOrDefault<String>(
                                  widget.size,
                                  'medium',
                                ) ==
                                'large') {
                              return 200.0;
                            } else if (valueOrDefault<String>(
                                  widget.size,
                                  'medium',
                                ) ==
                                'expanded') {
                              return 240.0;
                            } else {
                              return 156.0;
                            }
                          }(),
                          156.0,
                        ),
                        height: valueOrDefault<double>(
                          () {
                            if (valueOrDefault<String>(
                                  widget.size,
                                  'medium',
                                ) ==
                                'compact') {
                              return 120.0;
                            } else if (valueOrDefault<String>(
                                  widget.size,
                                  'medium',
                                ) ==
                                'large') {
                              return 200.0;
                            } else if (valueOrDefault<String>(
                                  widget.size,
                                  'medium',
                                ) ==
                                'expanded') {
                              return 240.0;
                            } else {
                              return 156.0;
                            }
                          }(),
                          156.0,
                        ),
                        child: FlutterFlowPieChart(
                          data: FFPieChartData(
                            values: (String? data) {
                              return (data ?? '')
                                  .split(',')
                                  .map((value) =>
                                      double.tryParse(value.trim()) ?? 0)
                                  .toList();
                            }(valueOrDefault<String>(
                              widget.data,
                              '0,100',
                            )),
                            colors: pieChartPieChartColorsList2,
                            radius: [50.0],
                          ),
                          donutHoleRadius: 0.0,
                          donutHoleColor: Colors.transparent,
                          sectionLabelStyle:
                              FlutterFlowTheme.of(context).labelSmall.override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    fontSize: 10.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                    lineHeight: 1.0,
                                  ),
                          sectionsSpace: valueOrDefault<double>(
                            () {
                              if (valueOrDefault<String>(
                                    widget.gap,
                                    'normal',
                                  ) ==
                                  'none') {
                                return 0.0;
                              } else if (valueOrDefault<String>(
                                    widget.gap,
                                    'normal',
                                  ) ==
                                  'tight') {
                                return 2.0;
                              } else if (valueOrDefault<String>(
                                    widget.gap,
                                    'normal',
                                  ) ==
                                  'wide') {
                                return 8.0;
                              } else {
                                return 4.0;
                              }
                            }(),
                            4.0,
                          ),
                          startDegreeOffset: valueOrDefault<double>(
                            widget.startAngle,
                            -90.0,
                          ),
                          labelPositionOffset: 0.6,
                        ),
                      ),
                    if (valueOrDefault<bool>(
                      valueOrDefault<String>(
                                widget.variant,
                                'donut',
                              ) ==
                              'pie'
                          ? false
                          : false,
                      true,
                    ))
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (valueOrDefault<bool>(
                            widget.centerValuePresent,
                            true,
                          ))
                            Text(
                              valueOrDefault<String>(
                                widget.centerValue,
                                '0%',
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                            ),
                          if (valueOrDefault<bool>(
                            widget.centerLabelPresent,
                            true,
                          ))
                            Text(
                              valueOrDefault<String>(
                                widget.centerLabel,
                                'consumed',
                              ),
                              textAlign: TextAlign.center,
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
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                            ),
                        ].divide(SizedBox(height: 0.0)),
                      ),
                  ],
                ),
                if (valueOrDefault<bool>(
                  () {
                    if (valueOrDefault<String>(
                          widget.legend,
                          'hidden',
                        ) ==
                        'right') {
                      return true;
                    } else if (valueOrDefault<String>(
                          widget.legend,
                          'hidden',
                        ) ==
                        'hidden') {
                      return false;
                    } else {
                      return false;
                    }
                  }(),
                  false,
                ))
                  wrapWithModel(
                    model: _model.chartLegendModel1,
                    updateCallback: () => safeSetState(() {}),
                    child: ChartLegendWidget(
                      data: valueOrDefault<String>(
                        widget.data,
                        '0,100',
                      ),
                      labels: valueOrDefault<String>(
                        widget.labels,
                        'Product,Services,Marketing,Other',
                      ),
                      colors: valueOrDefault<String>(
                        widget.colors,
                        'primary,divider',
                      ),
                      markerSize: 8.0,
                      spacing: 6.0,
                      runSpacing: 8.0,
                      labelColor: FlutterFlowTheme.of(context).primaryText,
                      valueColor: FlutterFlowTheme.of(context).secondaryText,
                      textStyle: 'label_small',
                      valueStyle: 'label_small',
                      labelMaxWidth: 0.0,
                      direction: 'vertical',
                      valueMode: 'percent',
                    ),
                  ),
              ],
            ),
          ),
          if (valueOrDefault<bool>(
            () {
              if (valueOrDefault<String>(
                    widget.legend,
                    'hidden',
                  ) ==
                  'right') {
                return false;
              } else if (valueOrDefault<String>(
                    widget.legend,
                    'hidden',
                  ) ==
                  'hidden') {
                return false;
              } else {
                return true;
              }
            }(),
            false,
          ))
            wrapWithModel(
              model: _model.chartLegendModel2,
              updateCallback: () => safeSetState(() {}),
              child: ChartLegendWidget(
                data: valueOrDefault<String>(
                  widget.data,
                  '0,100',
                ),
                labels: valueOrDefault<String>(
                  widget.labels,
                  'Product,Services,Marketing,Other',
                ),
                colors: valueOrDefault<String>(
                  widget.colors,
                  'primary,divider',
                ),
                markerSize: 8.0,
                spacing: 6.0,
                runSpacing: 8.0,
                labelColor: FlutterFlowTheme.of(context).primaryText,
                valueColor: FlutterFlowTheme.of(context).secondaryText,
                textStyle: 'label_small',
                valueStyle: 'label_small',
                labelMaxWidth: 0.0,
                direction: 'horizontal',
                valueMode: 'percent',
              ),
            ),
        ].divide(SizedBox(height: 12.0)),
      ),
    );
  }
}
