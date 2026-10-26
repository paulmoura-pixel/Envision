import 'package:envision/main.dart';
import 'package:envision/screens/home.dart';
import 'package:envision/screens/coach_dashboard.dart';
import 'package:envision/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the branded splash before opening welcome',
      (tester) async {
    await tester.pumpWidget(const EnvisionApp());

    expect(find.text('ENVISION'), findsOneWidget);
    expect(find.text('Build the body.\nProve the work.'), findsNothing);

    await tester.pump(const Duration(milliseconds: 3200));
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('Build the body.\nProve the work.'), findsOneWidget);
    expect(find.text('Get started'), findsOneWidget);

    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    expect(find.text('Continue with Apple'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);

    await tester.tap(find.text('Continue with Apple'));
    await tester.pumpAndSettle();

    expect(find.text('How will you use Envision?'), findsOneWidget);
    expect(find.text('I coach people'), findsOneWidget);
    expect(find.text('I’m training'), findsOneWidget);
  });

  testWidgets('bottom navigation opens distinct premium destinations',
      (tester) async {
    tester.view.physicalSize = const Size(402, 874);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(MaterialApp(
      theme: buildTheme(),
      home: const HomeScreen(),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Training'));
    await tester.pumpAndSettle();
    expect(
        find.text('Your plan, sessions, and coaching cues.'), findsOneWidget);

    await tester.tap(find.text('Nutrition'));
    await tester.pumpAndSettle();
    expect(find.text('Meals, targets, and daily consistency.'), findsOneWidget);

    await tester.tap(find.text('Progress'));
    await tester.pumpAndSettle();
    expect(find.text('See the work compound over time.'), findsOneWidget);
  });

  testWidgets('home toggles between dark and light modes', (tester) async {
    appLightMode.value = false;
    addTearDown(() => appLightMode.value = false);

    await tester.pumpWidget(const EnvisionApp());
    await tester.pump(const Duration(milliseconds: 3200));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue with Apple'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.light_mode_rounded));
    await tester.pumpAndSettle();

    expect(appLightMode.value, isTrue);
    expect(EC.isLight, isTrue);
  });

  testWidgets('coach dashboard adapts between desktop and mobile navigation',
      (tester) async {
    tester.view.physicalSize = const Size(1200, 820);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(MaterialApp(
      theme: buildTheme(),
      home: const CoachDashboardScreen(),
    ));
    await tester.pumpAndSettle();
    expect(find.text('ENVISION'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.text('Client attention'), findsOneWidget);

    tester.view.physicalSize = const Size(402, 874);
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Morning, Taylor'), findsOneWidget);
  });
}
