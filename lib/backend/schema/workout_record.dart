import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WorkoutRecord extends FirestoreRecord {
  WorkoutRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "workout" field.
  String? _workout;
  String get workout => _workout ?? '';
  bool hasWorkout() => _workout != null;

  // "details" field.
  String? _details;
  String get details => _details ?? '';
  bool hasDetails() => _details != null;

  // "completed" field.
  bool? _completed;
  bool get completed => _completed ?? false;
  bool hasCompleted() => _completed != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "created" field.
  DateTime? _created;
  DateTime? get created => _created;
  bool hasCreated() => _created != null;

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

  void _initializeFields() {
    _workout = snapshotData['workout'] as String?;
    _details = snapshotData['details'] as String?;
    _completed = snapshotData['completed'] as bool?;
    _user = snapshotData['user'] as DocumentReference?;
    _created = snapshotData['created'] as DateTime?;
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('workout');

  static Stream<WorkoutRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => WorkoutRecord.fromSnapshot(s));

  static Future<WorkoutRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => WorkoutRecord.fromSnapshot(s));

  static WorkoutRecord fromSnapshot(DocumentSnapshot snapshot) =>
      WorkoutRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static WorkoutRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      WorkoutRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'WorkoutRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is WorkoutRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createWorkoutRecordData({
  String? workout,
  String? details,
  bool? completed,
  DocumentReference? user,
  DateTime? created,
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'workout': workout,
      'details': details,
      'completed': completed,
      'user': user,
      'created': created,
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
    }.withoutNulls,
  );

  return firestoreData;
}

class WorkoutRecordDocumentEquality implements Equality<WorkoutRecord> {
  const WorkoutRecordDocumentEquality();

  @override
  bool equals(WorkoutRecord? e1, WorkoutRecord? e2) {
    return e1?.workout == e2?.workout &&
        e1?.details == e2?.details &&
        e1?.completed == e2?.completed &&
        e1?.user == e2?.user &&
        e1?.created == e2?.created &&
        e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber;
  }

  @override
  int hash(WorkoutRecord? e) => const ListEquality().hash([
        e?.workout,
        e?.details,
        e?.completed,
        e?.user,
        e?.created,
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber
      ]);

  @override
  bool isValidKey(Object? o) => o is WorkoutRecord;
}
