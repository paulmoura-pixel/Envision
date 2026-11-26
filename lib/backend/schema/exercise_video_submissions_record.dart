import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ExerciseVideoSubmissionsRecord extends FirestoreRecord {
  ExerciseVideoSubmissionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "client" field.
  DocumentReference? _client;
  DocumentReference? get client => _client;
  bool hasClient() => _client != null;

  // "coach" field.
  DocumentReference? _coach;
  DocumentReference? get coach => _coach;
  bool hasCoach() => _coach != null;

  // "workout" field.
  DocumentReference? _workout;
  DocumentReference? get workout => _workout;
  bool hasWorkout() => _workout != null;

  // "exercise" field.
  DocumentReference? _exercise;
  DocumentReference? get exercise => _exercise;
  bool hasExercise() => _exercise != null;

  // "video_path" field.
  String? _videoPath;
  String get videoPath => _videoPath ?? '';
  bool hasVideoPath() => _videoPath != null;

  // "uploaded_at" field.
  DateTime? _uploadedAt;
  DateTime? get uploadedAt => _uploadedAt;
  bool hasUploadedAt() => _uploadedAt != null;

  // "review_status" field.
  String? _reviewStatus;
  String get reviewStatus => _reviewStatus ?? '';
  bool hasReviewStatus() => _reviewStatus != null;

  void _initializeFields() {
    _client = snapshotData['client'] as DocumentReference?;
    _coach = snapshotData['coach'] as DocumentReference?;
    _workout = snapshotData['workout'] as DocumentReference?;
    _exercise = snapshotData['exercise'] as DocumentReference?;
    _videoPath = snapshotData['video_path'] as String?;
    _uploadedAt = snapshotData['uploaded_at'] as DateTime?;
    _reviewStatus = snapshotData['review_status'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('exercise_video_submissions');

  static Stream<ExerciseVideoSubmissionsRecord> getDocument(
          DocumentReference ref) =>
      ref
          .snapshots()
          .map((s) => ExerciseVideoSubmissionsRecord.fromSnapshot(s));

  static Future<ExerciseVideoSubmissionsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => ExerciseVideoSubmissionsRecord.fromSnapshot(s));

  static ExerciseVideoSubmissionsRecord fromSnapshot(
          DocumentSnapshot snapshot) =>
      ExerciseVideoSubmissionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ExerciseVideoSubmissionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ExerciseVideoSubmissionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ExerciseVideoSubmissionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ExerciseVideoSubmissionsRecord &&
      reference.path == other.reference.path;
}

Map<String, dynamic> createExerciseVideoSubmissionsRecordData({
  DocumentReference? client,
  DocumentReference? coach,
  DocumentReference? workout,
  DocumentReference? exercise,
  String? videoPath,
  DateTime? uploadedAt,
  String? reviewStatus,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'client': client,
      'coach': coach,
      'workout': workout,
      'exercise': exercise,
      'video_path': videoPath,
      'uploaded_at': uploadedAt,
      'review_status': reviewStatus,
    }.withoutNulls,
  );

  return firestoreData;
}

class ExerciseVideoSubmissionsRecordDocumentEquality
    implements Equality<ExerciseVideoSubmissionsRecord> {
  const ExerciseVideoSubmissionsRecordDocumentEquality();

  @override
  bool equals(
      ExerciseVideoSubmissionsRecord? e1, ExerciseVideoSubmissionsRecord? e2) {
    return e1?.client == e2?.client &&
        e1?.coach == e2?.coach &&
        e1?.workout == e2?.workout &&
        e1?.exercise == e2?.exercise &&
        e1?.videoPath == e2?.videoPath &&
        e1?.uploadedAt == e2?.uploadedAt &&
        e1?.reviewStatus == e2?.reviewStatus;
  }

  @override
  int hash(ExerciseVideoSubmissionsRecord? e) => const ListEquality().hash([
        e?.client,
        e?.coach,
        e?.workout,
        e?.exercise,
        e?.videoPath,
        e?.uploadedAt,
        e?.reviewStatus
      ]);

  @override
  bool isValidKey(Object? o) => o is ExerciseVideoSubmissionsRecord;
}
