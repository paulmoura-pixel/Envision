import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'envision_coach_pro_model.dart';
export 'envision_coach_pro_model.dart';

/// Production coach workspace powered by the responsive premium custom
/// widget.
class EnvisionCoachProWidget extends StatefulWidget {
  const EnvisionCoachProWidget({super.key});

  static String routeName = 'EnvisionCoachPro';
  static String routePath = '/envision-coach-pro';

  @override
  State<EnvisionCoachProWidget> createState() => _EnvisionCoachProWidgetState();
}

class _EnvisionCoachProWidgetState extends State<EnvisionCoachProWidget> {
  late EnvisionCoachProModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnvisionCoachProModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EnvisionCoachPro'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ENVISION_COACH_PRO_EnvisionCoachPro_ON_I');
      logFirebaseEvent('EnvisionCoachPro_custom_action');
      await actions.obResumeSignup(
        context,
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).night,
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: custom_widgets.EnvisionCoachClients(
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
