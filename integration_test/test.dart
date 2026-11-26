import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:integration_test/integration_test.dart';
import 'package:envision/flutter_flow/flutter_flow_icon_button.dart';
import 'package:envision/flutter_flow/flutter_flow_widgets.dart';
import 'package:envision/flutter_flow/flutter_flow_theme.dart';
import 'package:envision/index.dart';
import 'package:envision/main.dart';
import 'package:envision/flutter_flow/flutter_flow_util.dart';

import 'package:provider/provider.dart';
import 'package:envision/backend/firebase/firebase_config.dart';
import 'package:envision/auth/firebase_auth/auth_util.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initFirebase();

    await FlutterFlowTheme.initialize();
  });

  setUp(() async {
    await authManager.signOut();
    FFAppState.reset();
    final appState = FFAppState();
    await appState.initializePersistedState();
  });

  group('Active premium flow', () {
    testWidgets('welcome opens authentication', (WidgetTester tester) async {
      _overrideOnError();

      await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => FFAppState(),
        child: MyApp(
          entryPage: BEnvisionWelcomeProWidget(),
        ),
      ));
      await GoogleFonts.pendingFonts();

      expect(find.text('Build the body.\nProve the work.'), findsOneWidget);
      expect(find.text('Get started'), findsOneWidget);
      await tester.tap(find.text('Get started'));
      await tester.pumpAndSettle();
      expect(find.text('Continue with Apple'), findsOneWidget);
    });

    testWidgets('role selection exposes both journeys',
        (WidgetTester tester) async {
      _overrideOnError();

      await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => FFAppState(),
        child: MyApp(
          entryPage: CEnvisionRoleProWidget(),
        ),
      ));
      await GoogleFonts.pendingFonts();

      expect(find.text('I coach people'), findsOneWidget);
      expect(find.text('I’m training'), findsOneWidget);
    });

    testWidgets('client dashboard keeps key hierarchy',
        (WidgetTester tester) async {
      _overrideOnError();

      await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => FFAppState(),
        child: const MyApp(),
      ));
      await GoogleFonts.pendingFonts();

      expect(find.text('Good morning, Maya'), findsOneWidget);
      expect(find.text('Today\'s workout'), findsOneWidget);
      expect(find.text('Coach note'), findsOneWidget);
    });

    testWidgets('coach dashboard keeps key hierarchy',
        (WidgetTester tester) async {
      _overrideOnError();

      await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => FFAppState(),
        child: MyApp(
          entryPage: EnvisionCoachProWidget(),
        ),
      ));
      await GoogleFonts.pendingFonts();

      expect(find.text('Good morning, Taylor'), findsOneWidget);
      expect(find.text('Client attention'), findsOneWidget);
      expect(find.text('Today’s schedule'), findsOneWidget);
    });
  });
}

// There are certain types of errors that can happen during tests but
// should not break the test.
void _overrideOnError() {
  final originalOnError = FlutterError.onError!;
  FlutterError.onError = (errorDetails) {
    if (_shouldIgnoreError(errorDetails.toString())) {
      return;
    }
    originalOnError(errorDetails);
  };
}

bool _shouldIgnoreError(String error) {
  // It can fail to decode some SVGs - this should not break the test.
  if (error.contains('ImageCodecException')) {
    return true;
  }
  // Overflows happen all over the place,
  // but they should not break tests.
  if (error.contains('overflowed by')) {
    return true;
  }
  // Sometimes some images fail to load, it generally does not break the test.
  if (error.contains('No host specified in URI') ||
      error.contains('EXCEPTION CAUGHT BY IMAGE RESOURCE SERVICE')) {
    return true;
  }
  // These errors should be avoided, but they should not break the test.
  if (error.contains('setState() called after dispose()')) {
    return true;
  }
  // Web-specific error when interacting with TextInputType.emailAddress
  if (error.contains('setSelectionRange') &&
      error.contains('HTMLInputElement')) {
    return true;
  }

  return false;
}
