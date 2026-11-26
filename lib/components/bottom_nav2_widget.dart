import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'bottom_nav2_model.dart';
export 'bottom_nav2_model.dart';

class BottomNav2Widget extends StatefulWidget {
  const BottomNav2Widget({
    super.key,
    this.child,
  });

  final Widget Function()? child;

  @override
  State<BottomNav2Widget> createState() => _BottomNav2WidgetState();
}

class _BottomNav2WidgetState extends State<BottomNav2Widget> {
  late BottomNav2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomNav2Model());

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
        color: FlutterFlowTheme.of(context).secondaryBackground,
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Builder(builder: (_) {
                return widget.child != null
                    ? widget.child!()
                    : SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
