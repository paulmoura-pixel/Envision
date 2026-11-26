import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WorkoutExercisesRecord extends FirestoreRecord {
  WorkoutExercisesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "exercise_name" field.
  String? _exerciseName;
  String get exerciseName => _exerciseName ?? '';
  bool hasExerciseName() => _exerciseName != null;

  // "exercise_order" field.
  int? _exerciseOrder;
  int get exerciseOrder => _exerciseOrder ?? 0;
  bool hasExerciseOrder() => _exerciseOrder != null;

  // "sets" field.
  int? _sets;
  int get sets => _sets ?? 0;
  bool hasSets() => _sets != null;

  // "target_reps" field.
  String? _targetReps;
  String get targetReps => _targetReps ?? '';
  bool hasTargetReps() => _targetReps != null;

  // "rest_seconds" field.
  int? _restSeconds;
  int get restSeconds => _restSeconds ?? 0;
  bool hasRestSeconds() => _restSeconds != null;

  // "video_url" field.
  String? _videoUrl;
  String get videoUrl => _videoUrl ?? '';
  bool hasVideoUrl() => _videoUrl != null;

  // "thumbnail_url" field.
  String? _thumbnailUrl;
  String get thumbnailUrl => _thumbnailUrl ?? '';
  bool hasThumbnailUrl() => _thumbnailUrl != null;

  // "instructions" field.
  String? _instructions;
  String get instructions => _instructions ?? '';
  bool hasInstructions() => _instructions != null;

  // "coach_notes" field.
  String? _coachNotes;
  String get coachNotes => _coachNotes ?? '';
  bool hasCoachNotes() => _coachNotes != null;

  // "workout" field.
  DocumentReference? _workout;
  DocumentReference? get workout => _workout;
  bool hasWorkout() => _workout != null;

  // "target_weight" field.
  double? _targetWeight;
  double get targetWeight => _targetWeight ?? 0.0;
  bool hasTargetWeight() => _targetWeight != null;

  void _initializeFields() {
    _exerciseName = snapshotData['exercise_name'] as String?;
    _exerciseOrder = castToType<int>(snapshotData['exercise_order']);
    _sets = castToType<int>(snapshotData['sets']);
    _targetReps = snapshotData['target_reps'] as String?;
    _restSeconds = castToType<int>(snapshotData['rest_seconds']);
    _videoUrl = snapshotData['video_url'] as String?;
    _thumbnailUrl = snapshotData['thumbnail_url'] as String?;
    _instructions = snapshotData['instructions'] as String?;
    _coachNotes = snapshotData['coach_notes'] as String?;
    _workout = snapshotData['workout'] as DocumentReference?;
    _targetWeight = castToType<double>(snapshotData['target_weight']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('workout_exercises');

  static Stream<WorkoutExercisesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => WorkoutExercisesRecord.fromSnapshot(s));

  static Future<WorkoutExercisesRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => WorkoutExercisesRecord.fromSnapshot(s));

  static WorkoutExercisesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      WorkoutExercisesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static WorkoutExercisesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      WorkoutExercisesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'WorkoutExercisesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is WorkoutExercisesRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createWorkoutExercisesRecordData({
  String? exerciseName,
  int? exerciseOrder,
  int? sets,
  String? targetReps,
  int? restSeconds,
  String? videoUrl,
  String? thumbnailUrl,
  String? instructions,
  String? coachNotes,
  DocumentReference? workout,
  double? targetWeight,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'exercise_name': exerciseName,
      'exercise_order': exerciseOrder,
      'sets': sets,
      'target_reps': targetReps,
      'rest_seconds': restSeconds,
      'video_url': videoUrl,
      'thumbnail_url': thumbnailUrl,
      'instructions': instructions,
      'coach_notes': coachNotes,
      'workout': workout,
      'target_weight': targetWeight,
    }.withoutNulls,
  );

  return firestoreData;
}

class WorkoutExercisesRecordDocumentEquality
    implements Equality<WorkoutExercisesRecord> {
  const WorkoutExercisesRecordDocumentEquality();

  @override
  bool equals(WorkoutExercisesRecord? e1, WorkoutExercisesRecord? e2) {
    return e1?.exerciseName == e2?.exerciseName &&
        e1?.exerciseOrder == e2?.exerciseOrder &&
        e1?.sets == e2?.sets &&
        e1?.targetReps == e2?.targetReps &&
        e1?.restSeconds == e2?.restSeconds &&
        e1?.videoUrl == e2?.videoUrl &&
        e1?.thumbnailUrl == e2?.thumbnailUrl &&
        e1?.instructions == e2?.instructions &&
        e1?.coachNotes == e2?.coachNotes &&
        e1?.workout == e2?.workout &&
        e1?.targetWeight == e2?.targetWeight;
  }

  @override
  int hash(WorkoutExercisesRecord? e) => const ListEquality().hash([
        e?.exerciseName,
        e?.exerciseOrder,
        e?.sets,
        e?.targetReps,
        e?.restSeconds,
        e?.videoUrl,
        e?.thumbnailUrl,
        e?.instructions,
        e?.coachNotes,
        e?.workout,
        e?.targetWeight
      ]);

  @override
  bool isValidKey(Object? o) => o is WorkoutExercisesRecord;
}
