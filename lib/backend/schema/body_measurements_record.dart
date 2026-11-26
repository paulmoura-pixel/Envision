import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BodyMeasurementsRecord extends FirestoreRecord {
  BodyMeasurementsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "client" field.
  DocumentReference? _client;
  DocumentReference? get client => _client;
  bool hasClient() => _client != null;

  // "created_by" field.
  DocumentReference? _createdBy;
  DocumentReference? get createdBy => _createdBy;
  bool hasCreatedBy() => _createdBy != null;

  // "weight" field.
  double? _weight;
  double get weight => _weight ?? 0.0;
  bool hasWeight() => _weight != null;

  // "weight_unit" field.
  String? _weightUnit;
  String get weightUnit => _weightUnit ?? '';
  bool hasWeightUnit() => _weightUnit != null;

  // "body_fat_pct" field.
  double? _bodyFatPct;
  double get bodyFatPct => _bodyFatPct ?? 0.0;
  bool hasBodyFatPct() => _bodyFatPct != null;

  // "muscle_mass" field.
  double? _muscleMass;
  double get muscleMass => _muscleMass ?? 0.0;
  bool hasMuscleMass() => _muscleMass != null;

  // "measured_at" field.
  DateTime? _measuredAt;
  DateTime? get measuredAt => _measuredAt;
  bool hasMeasuredAt() => _measuredAt != null;

  // "waist" field.
  double? _waist;
  double get waist => _waist ?? 0.0;
  bool hasWaist() => _waist != null;

  // "chest" field.
  double? _chest;
  double get chest => _chest ?? 0.0;
  bool hasChest() => _chest != null;

  // "arm" field.
  double? _arm;
  double get arm => _arm ?? 0.0;
  bool hasArm() => _arm != null;

  // "thigh" field.
  double? _thigh;
  double get thigh => _thigh ?? 0.0;
  bool hasThigh() => _thigh != null;

  // "hip" field.
  double? _hip;
  double get hip => _hip ?? 0.0;
  bool hasHip() => _hip != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  bool hasNotes() => _notes != null;

  // "height_cm" field.
  double? _heightCm;
  double get heightCm => _heightCm ?? 0.0;
  bool hasHeightCm() => _heightCm != null;

  // "target_weight" field.
  double? _targetWeight;
  double get targetWeight => _targetWeight ?? 0.0;
  bool hasTargetWeight() => _targetWeight != null;

  void _initializeFields() {
    _client = snapshotData['client'] as DocumentReference?;
    _createdBy = snapshotData['created_by'] as DocumentReference?;
    _weight = castToType<double>(snapshotData['weight']);
    _weightUnit = snapshotData['weight_unit'] as String?;
    _bodyFatPct = castToType<double>(snapshotData['body_fat_pct']);
    _muscleMass = castToType<double>(snapshotData['muscle_mass']);
    _measuredAt = snapshotData['measured_at'] as DateTime?;
    _waist = castToType<double>(snapshotData['waist']);
    _chest = castToType<double>(snapshotData['chest']);
    _arm = castToType<double>(snapshotData['arm']);
    _thigh = castToType<double>(snapshotData['thigh']);
    _hip = castToType<double>(snapshotData['hip']);
    _notes = snapshotData['notes'] as String?;
    _heightCm = castToType<double>(snapshotData['height_cm']);
    _targetWeight = castToType<double>(snapshotData['target_weight']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('body_measurements');

  static Stream<BodyMeasurementsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BodyMeasurementsRecord.fromSnapshot(s));

  static Future<BodyMeasurementsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => BodyMeasurementsRecord.fromSnapshot(s));

  static BodyMeasurementsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BodyMeasurementsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BodyMeasurementsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BodyMeasurementsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BodyMeasurementsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BodyMeasurementsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createBodyMeasurementsRecordData({
  DocumentReference? client,
  DocumentReference? createdBy,
  double? weight,
  String? weightUnit,
  double? bodyFatPct,
  double? muscleMass,
  DateTime? measuredAt,
  double? waist,
  double? chest,
  double? arm,
  double? thigh,
  double? hip,
  String? notes,
  double? heightCm,
  double? targetWeight,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'client': client,
      'created_by': createdBy,
      'weight': weight,
      'weight_unit': weightUnit,
      'body_fat_pct': bodyFatPct,
      'muscle_mass': muscleMass,
      'measured_at': measuredAt,
      'waist': waist,
      'chest': chest,
      'arm': arm,
      'thigh': thigh,
      'hip': hip,
      'notes': notes,
      'height_cm': heightCm,
      'target_weight': targetWeight,
    }.withoutNulls,
  );

  return firestoreData;
}

class BodyMeasurementsRecordDocumentEquality
    implements Equality<BodyMeasurementsRecord> {
  const BodyMeasurementsRecordDocumentEquality();

  @override
  bool equals(BodyMeasurementsRecord? e1, BodyMeasurementsRecord? e2) {
    return e1?.client == e2?.client &&
        e1?.createdBy == e2?.createdBy &&
        e1?.weight == e2?.weight &&
        e1?.weightUnit == e2?.weightUnit &&
        e1?.bodyFatPct == e2?.bodyFatPct &&
        e1?.muscleMass == e2?.muscleMass &&
        e1?.measuredAt == e2?.measuredAt &&
        e1?.waist == e2?.waist &&
        e1?.chest == e2?.chest &&
        e1?.arm == e2?.arm &&
        e1?.thigh == e2?.thigh &&
        e1?.hip == e2?.hip &&
        e1?.notes == e2?.notes &&
        e1?.heightCm == e2?.heightCm &&
        e1?.targetWeight == e2?.targetWeight;
  }

  @override
  int hash(BodyMeasurementsRecord? e) => const ListEquality().hash([
        e?.client,
        e?.createdBy,
        e?.weight,
        e?.weightUnit,
        e?.bodyFatPct,
        e?.muscleMass,
        e?.measuredAt,
        e?.waist,
        e?.chest,
        e?.arm,
        e?.thigh,
        e?.hip,
        e?.notes,
        e?.heightCm,
        e?.targetWeight
      ]);

  @override
  bool isValidKey(Object? o) => o is BodyMeasurementsRecord;
}
