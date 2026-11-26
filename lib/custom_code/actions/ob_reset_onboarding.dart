// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_functions/cloud_functions.dart';

Future<String> obResetOnboarding() async {
  String result = 'ok';
  try {
    await FirebaseFunctions.instance.httpsCallable('resetOnboarding').call({});
  } on FirebaseFunctionsException catch (e) {
    result = e.message ?? 'Reset failed';
  } catch (_) {
    result = 'Reset failed';
  }
  FFAppState().update(() {
    final s = FFAppState();
    s.obFullName = '';
    s.obUsername = '';
    s.obDob = '';
    s.obProfilePhotoPath = '';
    s.obGoals = [];
    s.obGoalNote = '';
    s.obUnit = 'imperial';
    s.obHeightCm = 0;
    s.obWeightKg = 0;
    s.obTargetWeightKg = 0;
    s.obBodyFatPct = 0;
    s.obActivityLevel = '';
    s.obDaysPerWeek = 0;
    s.obInjuries = '';
    s.obDiet = ['none'];
    s.obAllergies = '';
    s.obNotes = '';
    s.obSharePhotos = false;
    s.obPhotoFront = '';
    s.obPhotoSide = '';
    s.obPhotoBack = '';
    s.onboardingStep = 1;
    s.envisionOnboardingComplete = false;
  });
  return result;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
