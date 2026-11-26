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

Future obToggleGoal(String key) async {
  final goals = List<String>.from(FFAppState().obGoals);
  if (goals.contains(key)) {
    goals.remove(key);
  } else if (goals.length < 2) {
    goals.add(key);
  }
  FFAppState().update(() {
    FFAppState().obGoals = goals;
  });
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
