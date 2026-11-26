import 'package:flutter/material.dart'
    show ChangeNotifier, Color, Colors, VoidCallback;
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _envisionRole = prefs.getString('ff_envisionRole') ?? _envisionRole;
    });
    _safeInit(() {
      _envisionOnboardingComplete =
          prefs.getBool('ff_envisionOnboardingComplete') ??
              _envisionOnboardingComplete;
    });
    _safeInit(() {
      _onboardingStep = prefs.getInt('ff_onboardingStep') ?? _onboardingStep;
    });
    _safeInit(() {
      _testMode = prefs.getBool('ff_testMode') ?? _testMode;
    });
    _safeInit(() {
      _obFullName = prefs.getString('ff_obFullName') ?? _obFullName;
    });
    _safeInit(() {
      _obUsername = prefs.getString('ff_obUsername') ?? _obUsername;
    });
    _safeInit(() {
      _obDob = prefs.getString('ff_obDob') ?? _obDob;
    });
    _safeInit(() {
      _obProfilePhotoPath =
          prefs.getString('ff_obProfilePhotoPath') ?? _obProfilePhotoPath;
    });
    _safeInit(() {
      _obGoalNote = prefs.getString('ff_obGoalNote') ?? _obGoalNote;
    });
    _safeInit(() {
      _obUnit = prefs.getString('ff_obUnit') ?? _obUnit;
    });
    _safeInit(() {
      _obActivityLevel =
          prefs.getString('ff_obActivityLevel') ?? _obActivityLevel;
    });
    _safeInit(() {
      _obInjuries = prefs.getString('ff_obInjuries') ?? _obInjuries;
    });
    _safeInit(() {
      _obAllergies = prefs.getString('ff_obAllergies') ?? _obAllergies;
    });
    _safeInit(() {
      _obNotes = prefs.getString('ff_obNotes') ?? _obNotes;
    });
    _safeInit(() {
      _obPhotoFront = prefs.getString('ff_obPhotoFront') ?? _obPhotoFront;
    });
    _safeInit(() {
      _obPhotoSide = prefs.getString('ff_obPhotoSide') ?? _obPhotoSide;
    });
    _safeInit(() {
      _obPhotoBack = prefs.getString('ff_obPhotoBack') ?? _obPhotoBack;
    });
    _safeInit(() {
      _obHeightCm = prefs.getDouble('ff_obHeightCm') ?? _obHeightCm;
    });
    _safeInit(() {
      _obWeightKg = prefs.getDouble('ff_obWeightKg') ?? _obWeightKg;
    });
    _safeInit(() {
      _obTargetWeightKg =
          prefs.getDouble('ff_obTargetWeightKg') ?? _obTargetWeightKg;
    });
    _safeInit(() {
      _obBodyFatPct = prefs.getDouble('ff_obBodyFatPct') ?? _obBodyFatPct;
    });
    _safeInit(() {
      _obDaysPerWeek = prefs.getInt('ff_obDaysPerWeek') ?? _obDaysPerWeek;
    });
    _safeInit(() {
      _obSharePhotos = prefs.getBool('ff_obSharePhotos') ?? _obSharePhotos;
    });
    _safeInit(() {
      _obGoals = prefs.getStringList('ff_obGoals') ?? _obGoals;
    });
    _safeInit(() {
      _obDiet = prefs.getStringList('ff_obDiet') ?? _obDiet;
    });
    _safeInit(() {
      _obCoachName = prefs.getString('ff_obCoachName') ?? _obCoachName;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  /// DSL app state envisionRole
  String _envisionRole = '';
  String get envisionRole => _envisionRole;
  set envisionRole(String value) {
    _envisionRole = value;
    prefs.setString('ff_envisionRole', value);
  }

  /// DSL app state envisionOnboardingComplete
  bool _envisionOnboardingComplete = false;
  bool get envisionOnboardingComplete => _envisionOnboardingComplete;
  set envisionOnboardingComplete(bool value) {
    _envisionOnboardingComplete = value;
    prefs.setBool('ff_envisionOnboardingComplete', value);
  }

  /// DSL app state envisionInviteCode
  String _envisionInviteCode = '';
  String get envisionInviteCode => _envisionInviteCode;
  set envisionInviteCode(String value) {
    _envisionInviteCode = value;
  }

  int _onboardingStep = 1;
  int get onboardingStep => _onboardingStep;
  set onboardingStep(int value) {
    _onboardingStep = value;
    prefs.setInt('ff_onboardingStep', value);
  }

  bool _testMode = false;
  bool get testMode => _testMode;
  set testMode(bool value) {
    _testMode = value;
    prefs.setBool('ff_testMode', value);
  }

  String _obFullName = '';
  String get obFullName => _obFullName;
  set obFullName(String value) {
    _obFullName = value;
    prefs.setString('ff_obFullName', value);
  }

  String _obUsername = '';
  String get obUsername => _obUsername;
  set obUsername(String value) {
    _obUsername = value;
    prefs.setString('ff_obUsername', value);
  }

  String _obDob = '';
  String get obDob => _obDob;
  set obDob(String value) {
    _obDob = value;
    prefs.setString('ff_obDob', value);
  }

  String _obProfilePhotoPath = '';
  String get obProfilePhotoPath => _obProfilePhotoPath;
  set obProfilePhotoPath(String value) {
    _obProfilePhotoPath = value;
    prefs.setString('ff_obProfilePhotoPath', value);
  }

  String _obGoalNote = '';
  String get obGoalNote => _obGoalNote;
  set obGoalNote(String value) {
    _obGoalNote = value;
    prefs.setString('ff_obGoalNote', value);
  }

  String _obUnit = '';
  String get obUnit => _obUnit;
  set obUnit(String value) {
    _obUnit = value;
    prefs.setString('ff_obUnit', value);
  }

  String _obActivityLevel = '';
  String get obActivityLevel => _obActivityLevel;
  set obActivityLevel(String value) {
    _obActivityLevel = value;
    prefs.setString('ff_obActivityLevel', value);
  }

  String _obInjuries = '';
  String get obInjuries => _obInjuries;
  set obInjuries(String value) {
    _obInjuries = value;
    prefs.setString('ff_obInjuries', value);
  }

  String _obAllergies = '';
  String get obAllergies => _obAllergies;
  set obAllergies(String value) {
    _obAllergies = value;
    prefs.setString('ff_obAllergies', value);
  }

  String _obNotes = '';
  String get obNotes => _obNotes;
  set obNotes(String value) {
    _obNotes = value;
    prefs.setString('ff_obNotes', value);
  }

  String _obPhotoFront = '';
  String get obPhotoFront => _obPhotoFront;
  set obPhotoFront(String value) {
    _obPhotoFront = value;
    prefs.setString('ff_obPhotoFront', value);
  }

  String _obPhotoSide = '';
  String get obPhotoSide => _obPhotoSide;
  set obPhotoSide(String value) {
    _obPhotoSide = value;
    prefs.setString('ff_obPhotoSide', value);
  }

  String _obPhotoBack = '';
  String get obPhotoBack => _obPhotoBack;
  set obPhotoBack(String value) {
    _obPhotoBack = value;
    prefs.setString('ff_obPhotoBack', value);
  }

  double _obHeightCm = 0.0;
  double get obHeightCm => _obHeightCm;
  set obHeightCm(double value) {
    _obHeightCm = value;
    prefs.setDouble('ff_obHeightCm', value);
  }

  double _obWeightKg = 0.0;
  double get obWeightKg => _obWeightKg;
  set obWeightKg(double value) {
    _obWeightKg = value;
    prefs.setDouble('ff_obWeightKg', value);
  }

  double _obTargetWeightKg = 0.0;
  double get obTargetWeightKg => _obTargetWeightKg;
  set obTargetWeightKg(double value) {
    _obTargetWeightKg = value;
    prefs.setDouble('ff_obTargetWeightKg', value);
  }

  double _obBodyFatPct = 0.0;
  double get obBodyFatPct => _obBodyFatPct;
  set obBodyFatPct(double value) {
    _obBodyFatPct = value;
    prefs.setDouble('ff_obBodyFatPct', value);
  }

  int _obDaysPerWeek = 0;
  int get obDaysPerWeek => _obDaysPerWeek;
  set obDaysPerWeek(int value) {
    _obDaysPerWeek = value;
    prefs.setInt('ff_obDaysPerWeek', value);
  }

  bool _obSharePhotos = false;
  bool get obSharePhotos => _obSharePhotos;
  set obSharePhotos(bool value) {
    _obSharePhotos = value;
    prefs.setBool('ff_obSharePhotos', value);
  }

  List<String> _obGoals = [];
  List<String> get obGoals => _obGoals;
  set obGoals(List<String> value) {
    _obGoals = value;
    prefs.setStringList('ff_obGoals', value);
  }

  void addToObGoals(String value) {
    obGoals.add(value);
    prefs.setStringList('ff_obGoals', _obGoals);
  }

  void removeFromObGoals(String value) {
    obGoals.remove(value);
    prefs.setStringList('ff_obGoals', _obGoals);
  }

  void removeAtIndexFromObGoals(int index) {
    obGoals.removeAt(index);
    prefs.setStringList('ff_obGoals', _obGoals);
  }

  void updateObGoalsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    obGoals[index] = updateFn(_obGoals[index]);
    prefs.setStringList('ff_obGoals', _obGoals);
  }

  void insertAtIndexInObGoals(int index, String value) {
    obGoals.insert(index, value);
    prefs.setStringList('ff_obGoals', _obGoals);
  }

  List<String> _obDiet = [];
  List<String> get obDiet => _obDiet;
  set obDiet(List<String> value) {
    _obDiet = value;
    prefs.setStringList('ff_obDiet', value);
  }

  void addToObDiet(String value) {
    obDiet.add(value);
    prefs.setStringList('ff_obDiet', _obDiet);
  }

  void removeFromObDiet(String value) {
    obDiet.remove(value);
    prefs.setStringList('ff_obDiet', _obDiet);
  }

  void removeAtIndexFromObDiet(int index) {
    obDiet.removeAt(index);
    prefs.setStringList('ff_obDiet', _obDiet);
  }

  void updateObDietAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    obDiet[index] = updateFn(_obDiet[index]);
    prefs.setStringList('ff_obDiet', _obDiet);
  }

  void insertAtIndexInObDiet(int index, String value) {
    obDiet.insert(index, value);
    prefs.setStringList('ff_obDiet', _obDiet);
  }

  String _obCoachName = '';
  String get obCoachName => _obCoachName;
  set obCoachName(String value) {
    _obCoachName = value;
    prefs.setString('ff_obCoachName', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
