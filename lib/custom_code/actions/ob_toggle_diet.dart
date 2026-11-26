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

Future obToggleDiet(String key) async {
  var diet = List<String>.from(FFAppState().obDiet);
  if (key == 'none') {
    diet = ['none'];
  } else {
    diet.remove('none');
    diet.contains(key) ? diet.remove(key) : diet.add(key);
    if (diet.isEmpty) diet = ['none'];
  }
  FFAppState().update(() {
    FFAppState().obDiet = diet;
  });
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
