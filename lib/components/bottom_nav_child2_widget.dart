import '/components/nav_item2_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'bottom_nav_child2_model.dart';
export 'bottom_nav_child2_model.dart';

class BottomNavChild2Widget extends StatefulWidget {
  const BottomNavChild2Widget({super.key});

  @override
  State<BottomNavChild2Widget> createState() => _BottomNavChild2WidgetState();
}

class _BottomNavChild2WidgetState extends State<BottomNavChild2Widget> {
  late BottomNavChild2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomNavChild2Model());

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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        wrapWithModel(
          model: _model.navItemModel1,
          updateCallback: () => safeSetState(() {}),
          child: NavItem2Widget(
            label: 'Home',
            icon: Icon(
              Icons.home_outlined,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            target: 'home',
            selected: true,
          ),
        ),
        wrapWithModel(
          model: _model.navItemModel2,
          updateCallback: () => safeSetState(() {}),
          child: NavItem2Widget(
            label: 'Clients',
            icon: Icon(
              Icons.groups_outlined,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            target: 'clients',
            selected: false,
          ),
        ),
        wrapWithModel(
          model: _model.navItemModel3,
          updateCallback: () => safeSetState(() {}),
          child: NavItem2Widget(
            label: 'Messages',
            icon: Icon(
              Icons.chat_bubble_outline_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            target: 'messages',
            selected: false,
          ),
        ),
      ],
    );
  }
}
