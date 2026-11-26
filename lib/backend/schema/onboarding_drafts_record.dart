import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OnboardingDraftsRecord extends FirestoreRecord {
  OnboardingDraftsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "bodyFatPct" field.
  double? _bodyFatPct;
  double get bodyFatPct => _bodyFatPct ?? 0.0;
  bool hasBodyFatPct() => _bodyFatPct != null;

  // "dob" field.
  DateTime? _dob;
  DateTime? get dob => _dob;
  bool hasDob() => _dob != null;

  // "fullName" field.
  String? _fullName;
  String get fullName => _fullName ?? '';
  bool hasFullName() => _fullName != null;

  // "goalNote" field.
  String? _goalNote;
  String get goalNote => _goalNote ?? '';
  bool hasGoalNote() => _goalNote != null;

  // "heightCm" field.
  double? _heightCm;
  double get heightCm => _heightCm ?? 0.0;
  bool hasHeightCm() => _heightCm != null;

  // "inviteCode" field.
  String? _inviteCode;
  String get inviteCode => _inviteCode ?? '';
  bool hasInviteCode() => _inviteCode != null;

  // "profilePhotoPath" field.
  String? _profilePhotoPath;
  String get profilePhotoPath => _profilePhotoPath ?? '';
  bool hasProfilePhotoPath() => _profilePhotoPath != null;

  // "step" field.
  int? _step;
  int get step => _step ?? 0;
  bool hasStep() => _step != null;

  // "targetWeightKg" field.
  double? _targetWeightKg;
  double get targetWeightKg => _targetWeightKg ?? 0.0;
  bool hasTargetWeightKg() => _targetWeightKg != null;

  // "unit" field.
  String? _unit;
  String get unit => _unit ?? '';
  bool hasUnit() => _unit != null;

  // "username" field.
  String? _username;
  String get username => _username ?? '';
  bool hasUsername() => _username != null;

  // "weightKg" field.
  double? _weightKg;
  double get weightKg => _weightKg ?? 0.0;
  bool hasWeightKg() => _weightKg != null;

  // "goals" field.
  List<String>? _goals;
  List<String> get goals => _goals ?? const [];
  bool hasGoals() => _goals != null;

  // "activityLevel" field.
  String? _activityLevel;
  String get activityLevel => _activityLevel ?? '';
  bool hasActivityLevel() => _activityLevel != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  bool hasNotes() => _notes != null;

  // "sharePhotos" field.
  bool? _sharePhotos;
  bool get sharePhotos => _sharePhotos ?? false;
  bool hasSharePhotos() => _sharePhotos != null;

  // "expireAt" field.
  DateTime? _expireAt;
  DateTime? get expireAt => _expireAt;
  bool hasExpireAt() => _expireAt != null;

  // "daysPerWeek" field.
  int? _daysPerWeek;
  int get daysPerWeek => _daysPerWeek ?? 0;
  bool hasDaysPerWeek() => _daysPerWeek != null;

  // "injuries" field.
  String? _injuries;
  String get injuries => _injuries ?? '';
  bool hasInjuries() => _injuries != null;

  // "diet" field.
  List<String>? _diet;
  List<String> get diet => _diet ?? const [];
  bool hasDiet() => _diet != null;

  // "dietOther" field.
  String? _dietOther;
  String get dietOther => _dietOther ?? '';
  bool hasDietOther() => _dietOther != null;

  // "allergies" field.
  String? _allergies;
  String get allergies => _allergies ?? '';
  bool hasAllergies() => _allergies != null;

  void _initializeFields() {
    _bodyFatPct = castToType<double>(snapshotData['bodyFatPct']);
    _dob = snapshotData['dob'] as DateTime?;
    _fullName = snapshotData['fullName'] as String?;
    _goalNote = snapshotData['goalNote'] as String?;
    _heightCm = castToType<double>(snapshotData['heightCm']);
    _inviteCode = snapshotData['inviteCode'] as String?;
    _profilePhotoPath = snapshotData['profilePhotoPath'] as String?;
    _step = castToType<int>(snapshotData['step']);
    _targetWeightKg = castToType<double>(snapshotData['targetWeightKg']);
    _unit = snapshotData['unit'] as String?;
    _username = snapshotData['username'] as String?;
    _weightKg = castToType<double>(snapshotData['weightKg']);
    _goals = getDataList(snapshotData['goals']);
    _activityLevel = snapshotData['activityLevel'] as String?;
    _notes = snapshotData['notes'] as String?;
    _sharePhotos = snapshotData['sharePhotos'] as bool?;
    _expireAt = snapshotData['expireAt'] as DateTime?;
    _daysPerWeek = castToType<int>(snapshotData['daysPerWeek']);
    _injuries = snapshotData['injuries'] as String?;
    _diet = getDataList(snapshotData['diet']);
    _dietOther = snapshotData['dietOther'] as String?;
    _allergies = snapshotData['allergies'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('onboarding_drafts');

  static Stream<OnboardingDraftsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => OnboardingDraftsRecord.fromSnapshot(s));

  static Future<OnboardingDraftsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => OnboardingDraftsRecord.fromSnapshot(s));

  static OnboardingDraftsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      OnboardingDraftsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static OnboardingDraftsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      OnboardingDraftsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'OnboardingDraftsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is OnboardingDraftsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createOnboardingDraftsRecordData({
  double? bodyFatPct,
  DateTime? dob,
  String? fullName,
  String? goalNote,
  double? heightCm,
  String? inviteCode,
  String? profilePhotoPath,
  int? step,
  double? targetWeightKg,
  String? unit,
  String? username,
  double? weightKg,
  String? activityLevel,
  String? notes,
  bool? sharePhotos,
  DateTime? expireAt,
  int? daysPerWeek,
  String? injuries,
  String? dietOther,
  String? allergies,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'bodyFatPct': bodyFatPct,
      'dob': dob,
      'fullName': fullName,
      'goalNote': goalNote,
      'heightCm': heightCm,
      'inviteCode': inviteCode,
      'profilePhotoPath': profilePhotoPath,
      'step': step,
      'targetWeightKg': targetWeightKg,
      'unit': unit,
      'username': username,
      'weightKg': weightKg,
      'activityLevel': activityLevel,
      'notes': notes,
      'sharePhotos': sharePhotos,
      'expireAt': expireAt,
      'daysPerWeek': daysPerWeek,
      'injuries': injuries,
      'dietOther': dietOther,
      'allergies': allergies,
    }.withoutNulls,
  );

  return firestoreData;
}

class OnboardingDraftsRecordDocumentEquality
    implements Equality<OnboardingDraftsRecord> {
  const OnboardingDraftsRecordDocumentEquality();

  @override
  bool equals(OnboardingDraftsRecord? e1, OnboardingDraftsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.bodyFatPct == e2?.bodyFatPct &&
        e1?.dob == e2?.dob &&
        e1?.fullName == e2?.fullName &&
        e1?.goalNote == e2?.goalNote &&
        e1?.heightCm == e2?.heightCm &&
        e1?.inviteCode == e2?.inviteCode &&
        e1?.profilePhotoPath == e2?.profilePhotoPath &&
        e1?.step == e2?.step &&
        e1?.targetWeightKg == e2?.targetWeightKg &&
        e1?.unit == e2?.unit &&
        e1?.username == e2?.username &&
        e1?.weightKg == e2?.weightKg &&
        listEquality.equals(e1?.goals, e2?.goals) &&
        e1?.activityLevel == e2?.activityLevel &&
        e1?.notes == e2?.notes &&
        e1?.sharePhotos == e2?.sharePhotos &&
        e1?.expireAt == e2?.expireAt &&
        e1?.daysPerWeek == e2?.daysPerWeek &&
        e1?.injuries == e2?.injuries &&
        listEquality.equals(e1?.diet, e2?.diet) &&
        e1?.dietOther == e2?.dietOther &&
        e1?.allergies == e2?.allergies;
  }

  @override
  int hash(OnboardingDraftsRecord? e) => const ListEquality().hash([
        e?.bodyFatPct,
        e?.dob,
        e?.fullName,
        e?.goalNote,
        e?.heightCm,
        e?.inviteCode,
        e?.profilePhotoPath,
        e?.step,
        e?.targetWeightKg,
        e?.unit,
        e?.username,
        e?.weightKg,
        const ListEquality().hash(e?.goals),
        e?.activityLevel,
        e?.notes,
        e?.sharePhotos,
        e?.expireAt,
        e?.daysPerWeek,
        e?.injuries,
        const ListEquality().hash(e?.diet),
        e?.dietOther,
        e?.allergies
      ]);

  @override
  bool isValidKey(Object? o) => o is OnboardingDraftsRecord;
}
