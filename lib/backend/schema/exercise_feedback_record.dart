import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ExerciseFeedbackRecord extends FirestoreRecord {
  ExerciseFeedbackRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "submission" field.
  DocumentReference? _submission;
  DocumentReference? get submission => _submission;
  bool hasSubmission() => _submission != null;

  // "coach" field.
  DocumentReference? _coach;
  DocumentReference? get coach => _coach;
  bool hasCoach() => _coach != null;

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  bool hasComment() => _comment != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _submission = snapshotData['submission'] as DocumentReference?;
    _coach = snapshotData['coach'] as DocumentReference?;
    _comment = snapshotData['comment'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('exercise_feedback');

  static Stream<ExerciseFeedbackRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ExerciseFeedbackRecord.fromSnapshot(s));

  static Future<ExerciseFeedbackRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => ExerciseFeedbackRecord.fromSnapshot(s));

  static ExerciseFeedbackRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ExerciseFeedbackRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ExerciseFeedbackRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ExerciseFeedbackRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ExerciseFeedbackRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ExerciseFeedbackRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createExerciseFeedbackRecordData({
  DocumentReference? submission,
  DocumentReference? coach,
  String? comment,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'submission': submission,
      'coach': coach,
      'comment': comment,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class ExerciseFeedbackRecordDocumentEquality
    implements Equality<ExerciseFeedbackRecord> {
  const ExerciseFeedbackRecordDocumentEquality();

  @override
  bool equals(ExerciseFeedbackRecord? e1, ExerciseFeedbackRecord? e2) {
    return e1?.submission == e2?.submission &&
        e1?.coach == e2?.coach &&
        e1?.comment == e2?.comment &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(ExerciseFeedbackRecord? e) => const ListEquality()
      .hash([e?.submission, e?.coach, e?.comment, e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is ExerciseFeedbackRecord;
}
