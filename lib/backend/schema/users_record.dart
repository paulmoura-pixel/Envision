import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "birthday" field.
  DateTime? _birthday;
  DateTime? get birthday => _birthday;
  bool hasBirthday() => _birthday != null;

  // "coachCode" field.
  String? _coachCode;
  String get coachCode => _coachCode ?? '';
  bool hasCoachCode() => _coachCode != null;

  // "gymName" field.
  String? _gymName;
  String get gymName => _gymName ?? '';
  bool hasGymName() => _gymName != null;

  // "whereYouCoach" field.
  WhereYouCoach? _whereYouCoach;
  WhereYouCoach? get whereYouCoach => _whereYouCoach;
  bool hasWhereYouCoach() => _whereYouCoach != null;

  // "whatYouCoach" field.
  String? _whatYouCoach;
  String get whatYouCoach => _whatYouCoach ?? '';
  bool hasWhatYouCoach() => _whatYouCoach != null;

  // "gymImage" field.
  String? _gymImage;
  String get gymImage => _gymImage ?? '';
  bool hasGymImage() => _gymImage != null;

  // "height_in" field.
  double? _heightIn;
  double get heightIn => _heightIn ?? 0.0;
  bool hasHeightIn() => _heightIn != null;

  // "coach" field.
  DocumentReference? _coach;
  DocumentReference? get coach => _coach;
  bool hasCoach() => _coach != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  bool hasRole() => _role != null;

  // "username" field.
  String? _username;
  String get username => _username ?? '';
  bool hasUsername() => _username != null;

  // "username_lower" field.
  String? _usernameLower;
  String get usernameLower => _usernameLower ?? '';
  bool hasUsernameLower() => _usernameLower != null;

  // "onboarding_status" field.
  String? _onboardingStatus;
  String get onboardingStatus => _onboardingStatus ?? '';
  bool hasOnboardingStatus() => _onboardingStatus != null;

  // "onboarding_completed_at" field.
  DateTime? _onboardingCompletedAt;
  DateTime? get onboardingCompletedAt => _onboardingCompletedAt;
  bool hasOnboardingCompletedAt() => _onboardingCompletedAt != null;

  // "onboardingComplete" field.
  bool? _onboardingComplete;
  bool get onboardingComplete => _onboardingComplete ?? false;
  bool hasOnboardingComplete() => _onboardingComplete != null;

  // "onboardingStep" field.
  String? _onboardingStep;
  String get onboardingStep => _onboardingStep ?? '';
  bool hasOnboardingStep() => _onboardingStep != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _birthday = snapshotData['birthday'] as DateTime?;
    _coachCode = snapshotData['coachCode'] as String?;
    _gymName = snapshotData['gymName'] as String?;
    _whereYouCoach = snapshotData['whereYouCoach'] is WhereYouCoach
        ? snapshotData['whereYouCoach']
        : deserializeEnum<WhereYouCoach>(snapshotData['whereYouCoach']);
    _whatYouCoach = snapshotData['whatYouCoach'] as String?;
    _gymImage = snapshotData['gymImage'] as String?;
    _heightIn = castToType<double>(snapshotData['height_in']);
    _coach = snapshotData['coach'] as DocumentReference?;
    _role = snapshotData['role'] as String?;
    _username = snapshotData['username'] as String?;
    _usernameLower = snapshotData['username_lower'] as String?;
    _onboardingStatus = snapshotData['onboarding_status'] as String?;
    _onboardingCompletedAt =
        snapshotData['onboarding_completed_at'] as DateTime?;
    _onboardingComplete = snapshotData['onboardingComplete'] as bool?;
    _onboardingStep = snapshotData['onboardingStep'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  DateTime? birthday,
  String? coachCode,
  String? gymName,
  WhereYouCoach? whereYouCoach,
  String? whatYouCoach,
  String? gymImage,
  double? heightIn,
  DocumentReference? coach,
  String? role,
  String? username,
  String? usernameLower,
  String? onboardingStatus,
  DateTime? onboardingCompletedAt,
  bool? onboardingComplete,
  String? onboardingStep,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'birthday': birthday,
      'coachCode': coachCode,
      'gymName': gymName,
      'whereYouCoach': whereYouCoach,
      'whatYouCoach': whatYouCoach,
      'gymImage': gymImage,
      'height_in': heightIn,
      'coach': coach,
      'role': role,
      'username': username,
      'username_lower': usernameLower,
      'onboarding_status': onboardingStatus,
      'onboarding_completed_at': onboardingCompletedAt,
      'onboardingComplete': onboardingComplete,
      'onboardingStep': onboardingStep,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.birthday == e2?.birthday &&
        e1?.coachCode == e2?.coachCode &&
        e1?.gymName == e2?.gymName &&
        e1?.whereYouCoach == e2?.whereYouCoach &&
        e1?.whatYouCoach == e2?.whatYouCoach &&
        e1?.gymImage == e2?.gymImage &&
        e1?.heightIn == e2?.heightIn &&
        e1?.coach == e2?.coach &&
        e1?.role == e2?.role &&
        e1?.username == e2?.username &&
        e1?.usernameLower == e2?.usernameLower &&
        e1?.onboardingStatus == e2?.onboardingStatus &&
        e1?.onboardingCompletedAt == e2?.onboardingCompletedAt &&
        e1?.onboardingComplete == e2?.onboardingComplete &&
        e1?.onboardingStep == e2?.onboardingStep;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.birthday,
        e?.coachCode,
        e?.gymName,
        e?.whereYouCoach,
        e?.whatYouCoach,
        e?.gymImage,
        e?.heightIn,
        e?.coach,
        e?.role,
        e?.username,
        e?.usernameLower,
        e?.onboardingStatus,
        e?.onboardingCompletedAt,
        e?.onboardingComplete,
        e?.onboardingStep
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
