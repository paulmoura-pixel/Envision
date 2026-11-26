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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future obSetField(String field, String value) async {
  final s = FFAppState();
  FFAppState().update(() {
    switch (field) {
      case 'fullName':
        s.obFullName = value;
        break;
      case 'heightCm':
        s.obHeightCm = double.tryParse(value) ?? s.obHeightCm;
        break;
      case 'username':
        s.obUsername = value.trim().toLowerCase();
        break;
      case 'weight':
        s.obWeightKg = (double.tryParse(value) ?? 0) *
            (s.obUnit == 'metric' ? 1 : 0.45359237);
        break;
      case 'targetWeight':
        s.obTargetWeightKg = (double.tryParse(value) ?? 0) *
            (s.obUnit == 'metric' ? 1 : 0.45359237);
        break;
      case 'heightFt':
        s.obHeightCm = ((double.tryParse(value) ?? 0) * 12 +
                ((s.obHeightCm / 2.54) % 12)) *
            2.54;
        break;
      case 'heightIn':
        s.obHeightCm = (((s.obHeightCm / 2.54) ~/ 12) * 12 +
                (double.tryParse(value) ?? 0)) *
            2.54;
        break;
      case 'activityLevel':
        s.obActivityLevel = value;
        break;
      case 'daysPerWeek':
        s.obDaysPerWeek = int.tryParse(value) ?? 0;
        break;
      case 'unit':
        s.obUnit = value;
        break;
      case 'weightKg':
        s.obWeightKg = double.tryParse(value) ?? 0;
        break;
      case 'targetWeightKg':
        s.obTargetWeightKg = double.tryParse(value) ?? 0;
        break;
      case 'bodyFatPct':
        s.obBodyFatPct = double.tryParse(value) ?? 0;
        break;
      case 'injuries':
        s.obInjuries = value;
        break;
      case 'allergies':
        s.obAllergies = value;
        break;
      case 'notes':
        s.obNotes = value;
        break;
      case 'goalNote':
        s.obGoalNote = value;
        break;
      case 'dob':
        s.obDob = value;
        break;
      case 'sharePhotos':
        s.obSharePhotos = value == 'true';
        break;
    }
  });

  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;
  final db = FirebaseFirestore.instance;
  final draft = <String, dynamic>{
    'inviteCode': s.envisionInviteCode,
    'fullName': s.obFullName,
    'username': s.obUsername,
    'dob': s.obDob,
    'profilePhotoPath': s.obProfilePhotoPath,
    'goals': s.obGoals,
    'goalNote': s.obGoalNote,
    'unit': s.obUnit,
    'heightCm': s.obHeightCm,
    'weightKg': s.obWeightKg,
    'targetWeightKg': s.obTargetWeightKg,
    'bodyFatPct': s.obBodyFatPct,
    'activityLevel': s.obActivityLevel,
    'daysPerWeek': s.obDaysPerWeek,
    'injuries': s.obInjuries,
    'diet': s.obDiet,
    'allergies': s.obAllergies,
    'notes': s.obNotes,
    'sharePhotos': s.obSharePhotos,
    'photoFront': s.obPhotoFront,
    'photoSide': s.obPhotoSide,
    'photoBack': s.obPhotoBack,
    'updatedAt': FieldValue.serverTimestamp(),
  };
  await db
      .collection('onboarding_drafts')
      .doc(user.uid)
      .set(draft, SetOptions(merge: true));
  if (field == 'step') {
    const allowed = {
      'role',
      'ClientJoin',
      'FitnessOnboardingStepPage7',
      'FitnessOnboardingStepPage2',
      'FitnessOnboardingStepPage3',
      'FitnessOnboardingStepPage4',
      'FitnessOnboardingStepPage5',
      'FitnessOnboardingStepPage6',
      'CoachSetup',
      'CoachSpecialties',
      'CoachComplete'
    };
    if (allowed.contains(value)) {
      await db
          .collection('users')
          .doc(user.uid)
          .set({'onboardingStep': value}, SetOptions(merge: true));
    }
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
