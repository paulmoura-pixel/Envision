import '/components/envision_log_sheet_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'envision_dashboard_model.dart';
export 'envision_dashboard_model.dart';

class EnvisionDashboardWidget extends StatefulWidget {
  const EnvisionDashboardWidget({super.key});

  static String routeName = 'EnvisionDashboard';
  static String routePath = '/envisionDashboard';

  @override
  State<EnvisionDashboardWidget> createState() =>
      _EnvisionDashboardWidgetState();
}

class _EnvisionDashboardWidgetState extends State<EnvisionDashboardWidget> {
  late EnvisionDashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnvisionDashboardModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EnvisionDashboard'});
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: custom_widgets.EnvisionDashboard(
                width: double.infinity,
                height: double.infinity,
                onPlus: () async {
                  logFirebaseEvent('ENVISION_DASHBOARD_Container_s11s57g7_CA');
                  logFirebaseEvent('EnvisionDashboard_bottom_sheet');
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    enableDrag: false,
                    context: context,
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: EnvisionLogSheetWidget(),
                        ),
                      );
                    },
                  ).then((value) => safeSetState(() {}));
                },
                onCoach: () async {
                  logFirebaseEvent('ENVISION_DASHBOARD_Container_s11s57g7_CA');
                  logFirebaseEvent('EnvisionDashboard_navigate_to');

                  context.pushNamed(EnvisionCoachProWidget.routeName);
                },
                onHome: () async {},
                onDateChanged: () async {},
                onMealTap: () async {},
                onNotes: () async {},
                onLogWorkout: () async {},
                onUploadVideo: () async {},
                onLogMeasurements: () async {},
                onLogPhoto: () async {},
                onBodyComp: () async {},
                onSeeAllPhotos: () async {},
                onExerciseToggled: () async {},
                onSetGoal: () async {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
