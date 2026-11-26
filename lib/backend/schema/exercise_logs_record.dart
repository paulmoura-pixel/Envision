import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ExerciseLogsRecord extends FirestoreRecord {
  ExerciseLogsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "workout_exercise" field.
  DocumentReference? _workoutExercise;
  DocumentReference? get workoutExercise => _workoutExercise;
  bool hasWorkoutExercise() => _workoutExercise != null;

  // "client" field.
  DocumentReference? _client;
  DocumentReference? get client => _client;
  bool hasClient() => _client != null;

  // "completed_sets" field.
  int? _completedSets;
  int get completedSets => _completedSets ?? 0;
  bool hasCompletedSets() => _completedSets != null;

  // "actual_reps" field.
  List<int>? _actualReps;
  List<int> get actualReps => _actualReps ?? const [];
  bool hasActualReps() => _actualReps != null;

  // "actual_weights" field.
  List<double>? _actualWeights;
  List<double> get actualWeights => _actualWeights ?? const [];
  bool hasActualWeights() => _actualWeights != null;

  // "completed" field.
  bool? _completed;
  bool get completed => _completed ?? false;
  bool hasCompleted() => _completed != null;

  // "rpe" field.
  int? _rpe;
  int get rpe => _rpe ?? 0;
  bool hasRpe() => _rpe != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  bool hasNotes() => _notes != null;

  // "logged_at" field.
  DateTime? _loggedAt;
  DateTime? get loggedAt => _loggedAt;
  bool hasLoggedAt() => _loggedAt != null;

  void _initializeFields() {
    _workoutExercise = snapshotData['workout_exercise'] as DocumentReference?;
    _client = snapshotData['client'] as DocumentReference?;
    _completedSets = castToType<int>(snapshotData['completed_sets']);
    _actualReps = getDataList(snapshotData['actual_reps']);
    _actualWeights = getDataList(snapshotData['actual_weights']);
    _completed = snapshotData['completed'] as bool?;
    _rpe = castToType<int>(snapshotData['rpe']);
    _notes = snapshotData['notes'] as String?;
    _loggedAt = snapshotData['logged_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('exercise_logs');

  static Stream<ExerciseLogsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ExerciseLogsRecord.fromSnapshot(s));

  static Future<ExerciseLogsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ExerciseLogsRecord.fromSnapshot(s));

  static ExerciseLogsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ExerciseLogsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ExerciseLogsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ExerciseLogsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ExerciseLogsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ExerciseLogsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createExerciseLogsRecordData({
  DocumentReference? workoutExercise,
  DocumentReference? client,
  int? completedSets,
  bool? completed,
  int? rpe,
  String? notes,
  DateTime? loggedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'workout_exercise': workoutExercise,
      'client': client,
      'completed_sets': completedSets,
      'completed': completed,
      'rpe': rpe,
      'notes': notes,
      'logged_at': loggedAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class ExerciseLogsRecordDocumentEquality
    implements Equality<ExerciseLogsRecord> {
  const ExerciseLogsRecordDocumentEquality();

  @override
  bool equals(ExerciseLogsRecord? e1, ExerciseLogsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.workoutExercise == e2?.workoutExercise &&
        e1?.client == e2?.client &&
        e1?.completedSets == e2?.completedSets &&
        listEquality.equals(e1?.actualReps, e2?.actualReps) &&
        listEquality.equals(e1?.actualWeights, e2?.actualWeights) &&
        e1?.completed == e2?.completed &&
        e1?.rpe == e2?.rpe &&
        e1?.notes == e2?.notes &&
        e1?.loggedAt == e2?.loggedAt;
  }

  @override
  int hash(ExerciseLogsRecord? e) => const ListEquality().hash([
        e?.workoutExercise,
        e?.client,
        e?.completedSets,
        const ListEquality().hash(e?.actualReps),
        const ListEquality().hash(e?.actualWeights),
        e?.completed,
        e?.rpe,
        e?.notes,
        e?.loggedAt
      ]);

  @override
  bool isValidKey(Object? o) => o is ExerciseLogsRecord;
}
