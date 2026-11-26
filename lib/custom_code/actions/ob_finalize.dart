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
import 'package:firebase_auth/firebase_auth.dart';

Future<String> obFinalize() async {
  final s = FFAppState();

  final uid = FirebaseAuth.instance.currentUser?.uid;

  if (uid == null) {
    return 'Please sign in again.';
  }

  final fullName = s.obFullName.trim();
  final username = s.obUsername.trim();

  if (fullName.length < 2) {
    return 'Please enter your full name.';
  }

  if (username.length < 3) {
    return 'Username must have at least 3 characters.';
  }

  final rawDob = s.obDob.trim();

  final String? formattedDob =
      rawDob.isEmpty ? null : rawDob.replaceAll('/', '-');

  if (formattedDob != null &&
      !RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(formattedDob)) {
    return 'Enter date of birth as YYYY-MM-DD.';
  }

  final payload = <String, dynamic>{
    'fullName': fullName,
    'username': username.trim().toLowerCase(),

    // Empty when the user selects "Maybe later".
    'inviteCode': s.envisionInviteCode.trim().toUpperCase(),

    'dob': formattedDob,

    'profilePhotoPath':
        s.obProfilePhotoPath.isEmpty ? null : s.obProfilePhotoPath,
  };

  try {
    final response = await FirebaseFunctions.instance
        .httpsCallable('finalizeOnboarding')
        .call({'payload': payload});

    final result = Map<String, dynamic>.from(
      response.data as Map,
    );

    if (result['ok'] != true) {
      return 'Could not complete onboarding.';
    }

    FFAppState().update(() {
      FFAppState().envisionOnboardingComplete = true;
    });

    return 'ok';
  } on FirebaseFunctionsException catch (e) {
    return e.message ?? 'Unable to complete onboarding.';
  } catch (e) {
    debugPrint('Onboarding error: $e');
    return 'Something went wrong. Please try again.';
  }
}
