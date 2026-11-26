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
import 'package:go_router/go_router.dart';

GoRouter? _signupRouter;
VoidCallback? _signupListener;
String? _signupUid;
const _signupPages = <String>{
  'CEnvisionRolePro',
  'ClientJoin',
  'ClientConfirm',
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
void _trackSignup(GoRouter router, String uid) {
  if (_signupRouter == router && _signupUid == uid) return;
  if (_signupRouter != null && _signupListener != null)
    _signupRouter!.routerDelegate.removeListener(_signupListener!);
  _signupRouter = router;
  _signupUid = uid;
  String? lastPage;
  _signupListener = () {
    if (FirebaseAuth.instance.currentUser?.uid != uid) return;
    final matches = router.routerDelegate.currentConfiguration.matches;
    if (matches.isEmpty) return;
    final route = matches.last.route;
    final name = route is GoRoute ? route.name : null;
    if (name == null || !_signupPages.contains(name) || name == lastPage)
      return;
    lastPage = name;
    obSetField('step', name == 'CEnvisionRolePro' ? 'role' : name)
        .catchError((Object error) {
      lastPage = null;
      debugPrint('Signup checkpoint could not be saved: $error');
    });
  };
  router.routerDelegate.addListener(_signupListener!);
}

Future obResumeSignup(BuildContext context) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    context.goNamed('BEnvisionWelcomePro');
    return;
  }
  void go(String name) {
    if (!context.mounted) return;
    final router = GoRouter.of(context);
    _trackSignup(router, user.uid);
    if (GoRouterState.of(context).name != name)
      context.goNamed(name);
    else
      _signupListener?.call();
  }

  try {
    final db = FirebaseFirestore.instance;
    final userDoc = await db.collection('users').doc(user.uid).get();
    final data = userDoc.data() ?? <String, dynamic>{};
    final role = data['role'];
    final step = data['onboardingStep'];
    final draftDoc =
        await db.collection('onboarding_drafts').doc(user.uid).get();
    final draft = draftDoc.data() ?? <String, dynamic>{};
    final state = FFAppState();
    String text(String key) => (draft[key] ?? '').toString();
    double number(String key) =>
        (draft[key] is num) ? (draft[key] as num).toDouble() : 0;
    List<String> strings(String key) => draft[key] is List
        ? (draft[key] as List).whereType<String>().toList()
        : <String>[];
    state.update(() {
      state.envisionInviteCode = text('inviteCode');
      state.obFullName = text('fullName');
      state.obUsername =
          text('username').trim().replaceFirst(RegExp(r'^@'), '').toLowerCase();
      state.obDob = text('dob');
      state.obProfilePhotoPath = text('profilePhotoPath');
      state.obGoals = strings('goals');
      state.obGoalNote = text('goalNote');
      state.obUnit = text('unit').isEmpty ? 'imperial' : text('unit');
      state.obHeightCm = number('heightCm');
      state.obWeightKg = number('weightKg');
      state.obTargetWeightKg = number('targetWeightKg');
      state.obBodyFatPct = number('bodyFatPct');
      state.obActivityLevel = text('activityLevel');
      state.obDaysPerWeek = number('daysPerWeek').toInt();
      state.obInjuries = text('injuries');
      state.obDiet = strings('diet');
      state.obAllergies = text('allergies');
      state.obNotes = text('notes');
      state.obSharePhotos = draft['sharePhotos'] == true;
      state.obPhotoFront = text('photoFront');
      state.obPhotoSide = text('photoSide');
      state.obPhotoBack = text('photoBack');
      state.envisionOnboardingComplete = false;
    });

    if (data['onboardingComplete'] == true &&
        (role == 'client' || role == 'coach')) {
      go(role == 'coach' ? 'EnvisionCoachPro' : 'EnvisionClientDashboard');
      return;
    }
    if ((role != 'client' && role != 'coach') ||
        step == null ||
        step == '' ||
        step == 'role') {
      go('CEnvisionRolePro');
      return;
    }
    if (role == 'coach') {
      const steps = {'CoachSetup', 'CoachSpecialties', 'CoachComplete'};
      go(steps.contains(step) ? step as String : 'CoachSetup');
      return;
    }
    const pages = [
      'ClientJoin',
      'FitnessOnboardingStepPage7',
      'FitnessOnboardingStepPage2',
      'FitnessOnboardingStepPage3',
      'FitnessOnboardingStepPage4',
      'FitnessOnboardingStepPage5',
      'FitnessOnboardingStepPage6'
    ];
    var requested = pages.indexOf(step.toString());
    if (requested < 0) requested = 0;
    var missing = 6;
    if (state.envisionInviteCode.trim().isEmpty)
      missing = 0;
    else if (state.obFullName.trim().length < 2 ||
        !RegExp(r'^[a-z0-9_.]{3,24}$').hasMatch(state.obUsername) ||
        state.obUsername.contains('..'))
      missing = 1;
    else if (state.obGoals.isEmpty || state.obGoals.length > 2)
      missing = 2;
    else if (state.obHeightCm < 90 ||
        state.obHeightCm > 260 ||
        state.obWeightKg < 25 ||
        state.obWeightKg > 400)
      missing = 3;
    else if (!['just_starting', '1_2', '3_4', '5_plus']
            .contains(state.obActivityLevel) ||
        state.obDaysPerWeek < 1 ||
        state.obDaysPerWeek > 7) missing = 4;
    go(pages[requested < missing ? requested : missing]);
  } catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Could not restore signup. Please try again.')));
      context.goNamed('BEnvisionWelcomePro');
    }
  }
}

// and then add the boilerplate code using the `</>` button on the right!
