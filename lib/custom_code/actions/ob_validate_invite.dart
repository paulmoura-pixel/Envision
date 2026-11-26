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

Future<dynamic> obValidateInvite(String code) async {
  try {
    final r = await FirebaseFunctions.instance
        .httpsCallable('validateInvite')
        .call({'code': code});
    final data = Map<String, dynamic>.from(r.data as Map);
    FFAppState().update(() {
      (FFAppState() as dynamic).obCoachName =
          (data['coachName'] ?? '').toString();
      FFAppState().envisionInviteCode = (data['code'] ?? code).toString();
    });
    return data;
  } on FirebaseFunctionsException catch (e) {
    return {'error': e.message ?? 'Invalid code'};
  } catch (_) {
    return {'error': 'Something went wrong. Try again.'};
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
