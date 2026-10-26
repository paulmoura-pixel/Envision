import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash.dart';
import 'screens/auth.dart';
import 'screens/coach_dashboard.dart';
import 'screens/home.dart';
import 'screens/onboarding.dart';
import 'screens/welcome.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  appLightMode.value = Uri.base.queryParameters['theme'] == 'light';
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(const EnvisionApp());
}

class EnvisionApp extends StatelessWidget {
  const EnvisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    final preview = Uri.base.queryParameters['screen'];
    final Widget home = switch (preview) {
      'welcome' => const WelcomeScreen(),
      'auth' => const AuthScreen(),
      'onboarding' => const AccountTypeScreen(),
      'home' => const HomeScreen(),
      'coach' => const CoachDashboardScreen(),
      _ => const SplashScreen(),
    };
    return ValueListenableBuilder<bool>(
      valueListenable: appLightMode,
      builder: (_, isLight, __) {
        EC.isLight = isLight;
        SystemChrome.setSystemUIOverlayStyle(
          isLight ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        );
        return MaterialApp(
          title: 'Envision',
          debugShowCheckedModeBanner: false,
          theme: buildTheme(),
          home: home,
        );
      },
    );
  }
}
