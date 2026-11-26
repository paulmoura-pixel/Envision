import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'a_envision_launch_model.dart';
export 'a_envision_launch_model.dart';

class AEnvisionLaunchWidget extends StatefulWidget {
  const AEnvisionLaunchWidget({super.key});

  static String routeName = 'AEnvisionLaunch';
  static String routePath = '/aEnvisionLaunch';

  @override
  State<AEnvisionLaunchWidget> createState() => _AEnvisionLaunchWidgetState();
}

class _AEnvisionLaunchWidgetState extends State<AEnvisionLaunchWidget> {
  late AEnvisionLaunchModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AEnvisionLaunchModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'AEnvisionLaunch'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('A_ENVISION_LAUNCH_AEnvisionLaunch_ON_INI');
      logFirebaseEvent('AEnvisionLaunch_set_dark_mode_settings');
      setDarkModeSetting(context, ThemeMode.light);
      logFirebaseEvent('AEnvisionLaunch_update_page_state');
      _model.appReady = true;
      safeSetState(() {});
      logFirebaseEvent('AEnvisionLaunch_wait__delay');
      await Future.delayed(
        Duration(
          milliseconds: 1500,
        ),
      );
      if (currentUserUid != '') {
        logFirebaseEvent('AEnvisionLaunch_navigate_to');

        context.goNamed(EnvisionDashboardWidget.routeName);

        return;
      }
      logFirebaseEvent('AEnvisionLaunch_navigate_to');

      context.goNamed(
        BEnvisionWelcomeProWidget.routeName,
        extra: <String, dynamic>{
          '__transition_info__': TransitionInfo(
            hasTransition: true,
            transitionType: PageTransitionType.fade,
            duration: Duration(milliseconds: 0),
          ),
        },
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
      child: PopScope(
        canPop: false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: custom_widgets.EnvisionSplash(
              width: double.infinity,
              height: double.infinity,
              logoAsset:
                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/envision-8wd5is/assets/wb945eu7k2ly/Three_Orange_Slashes_Logo.png',
              isReady: _model.appReady,
              fadeInMs: 500,
              scaleMs: 600,
              introMs: 1100,
              reducedHoldMs: 600,
              exitFadeMs: 350,
            ),
          ),
        ),
      ),
    );
  }
}
