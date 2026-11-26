import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WorkoutPlansRecord extends FirestoreRecord {
  WorkoutPlansRecord._(
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

  // "workout_name" field.
  String? _workoutName;
  String get workoutName => _workoutName ?? '';
  bool hasWorkoutName() => _workoutName != null;

  // "workout_type" field.
  String? _workoutType;
  String get workoutType => _workoutType ?? '';
  bool hasWorkoutType() => _workoutType != null;

  // "scheduled_date" field.
  DateTime? _scheduledDate;
  DateTime? get scheduledDate => _scheduledDate;
  bool hasScheduledDate() => _scheduledDate != null;

  // "duration_min" field.
  int? _durationMin;
  int get durationMin => _durationMin ?? 0;
  bool hasDurationMin() => _durationMin != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  // "assigned_by_coach" field.
  bool? _assignedByCoach;
  bool get assignedByCoach => _assignedByCoach ?? false;
  bool hasAssignedByCoach() => _assignedByCoach != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  bool hasNotes() => _notes != null;

  // "completed_at" field.
  DateTime? _completedAt;
  DateTime? get completedAt => _completedAt;
  bool hasCompletedAt() => _completedAt != null;

  void _initializeFields() {
    _client = snapshotData['client'] as DocumentReference?;
    _coach = snapshotData['coach'] as DocumentReference?;
    _workoutName = snapshotData['workout_name'] as String?;
    _workoutType = snapshotData['workout_type'] as String?;
    _scheduledDate = snapshotData['scheduled_date'] as DateTime?;
    _durationMin = castToType<int>(snapshotData['duration_min']);
    _imageUrl = snapshotData['image_url'] as String?;
    _assignedByCoach = snapshotData['assigned_by_coach'] as bool?;
    _status = snapshotData['status'] as String?;
    _notes = snapshotData['notes'] as String?;
    _completedAt = snapshotData['completed_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('workout_plans');

  static Stream<WorkoutPlansRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => WorkoutPlansRecord.fromSnapshot(s));

  static Future<WorkoutPlansRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => WorkoutPlansRecord.fromSnapshot(s));

  static WorkoutPlansRecord fromSnapshot(DocumentSnapshot snapshot) =>
      WorkoutPlansRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static WorkoutPlansRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      WorkoutPlansRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'WorkoutPlansRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is WorkoutPlansRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createWorkoutPlansRecordData({
  DocumentReference? client,
  DocumentReference? coach,
  String? workoutName,
  String? workoutType,
  DateTime? scheduledDate,
  int? durationMin,
  String? imageUrl,
  bool? assignedByCoach,
  String? status,
  String? notes,
  DateTime? completedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'client': client,
      'coach': coach,
      'workout_name': workoutName,
      'workout_type': workoutType,
      'scheduled_date': scheduledDate,
      'duration_min': durationMin,
      'image_url': imageUrl,
      'assigned_by_coach': assignedByCoach,
      'status': status,
      'notes': notes,
      'completed_at': completedAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class WorkoutPlansRecordDocumentEquality
    implements Equality<WorkoutPlansRecord> {
  const WorkoutPlansRecordDocumentEquality();

  @override
  bool equals(WorkoutPlansRecord? e1, WorkoutPlansRecord? e2) {
    return e1?.client == e2?.client &&
        e1?.coach == e2?.coach &&
        e1?.workoutName == e2?.workoutName &&
        e1?.workoutType == e2?.workoutType &&
        e1?.scheduledDate == e2?.scheduledDate &&
        e1?.durationMin == e2?.durationMin &&
        e1?.imageUrl == e2?.imageUrl &&
        e1?.assignedByCoach == e2?.assignedByCoach &&
        e1?.status == e2?.status &&
        e1?.notes == e2?.notes &&
        e1?.completedAt == e2?.completedAt;
  }

  @override
  int hash(WorkoutPlansRecord? e) => const ListEquality().hash([
        e?.client,
        e?.coach,
        e?.workoutName,
        e?.workoutType,
        e?.scheduledDate,
        e?.durationMin,
        e?.imageUrl,
        e?.assignedByCoach,
        e?.status,
        e?.notes,
        e?.completedAt
      ]);

  @override
  bool isValidKey(Object? o) => o is WorkoutPlansRecord;
}
