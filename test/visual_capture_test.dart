import 'dart:io';
import 'dart:ui' as ui;

import 'package:envision/screens/auth.dart';
import 'package:envision/screens/home.dart';
import 'package:envision/screens/onboarding.dart';
import 'package:envision/screens/welcome.dart';
import 'package:envision/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> capture(
    WidgetTester tester,
    String name,
    Widget screen,
  ) async {
    final boundaryKey = GlobalKey();
    tester.view.physicalSize = const Size(402, 874);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),
        home: RepaintBoundary(key: boundaryKey, child: screen),
      ),
    );
    await tester.pumpAndSettle();

    await tester.runAsync(() async {
      final boundary = boundaryKey.currentContext!.findRenderObject()!
          as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 2);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      final output = Directory('artifacts/visual-captures');
      output.createSync(recursive: true);
      File('${output.path}/$name.png').writeAsBytesSync(
        bytes!.buffer.asUint8List(),
      );
    });
  }

  testWidgets('captures premium flow screens', (tester) async {
    await capture(tester, 'welcome', const WelcomeScreen());
    await capture(tester, 'auth', const AuthScreen());
    await capture(tester, 'role-selection', const AccountTypeScreen());
    await capture(tester, 'home', const HomeScreen());
  });
}
