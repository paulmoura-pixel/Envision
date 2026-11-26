import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NutritionGoalsRecord extends FirestoreRecord {
  NutritionGoalsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "calories" field.
  int? _calories;
  int get calories => _calories ?? 0;
  bool hasCalories() => _calories != null;

  // "protein" field.
  int? _protein;
  int get protein => _protein ?? 0;
  bool hasProtein() => _protein != null;

  // "carbs" field.
  int? _carbs;
  int get carbs => _carbs ?? 0;
  bool hasCarbs() => _carbs != null;

  // "effective_date" field.
  DateTime? _effectiveDate;
  DateTime? get effectiveDate => _effectiveDate;
  bool hasEffectiveDate() => _effectiveDate != null;

  // "fat" field.
  int? _fat;
  int get fat => _fat ?? 0;
  bool hasFat() => _fat != null;

  // "client" field.
  DocumentReference? _client;
  DocumentReference? get client => _client;
  bool hasClient() => _client != null;

  // "updated_by" field.
  DocumentReference? _updatedBy;
  DocumentReference? get updatedBy => _updatedBy;
  bool hasUpdatedBy() => _updatedBy != null;

  void _initializeFields() {
    _calories = castToType<int>(snapshotData['calories']);
    _protein = castToType<int>(snapshotData['protein']);
    _carbs = castToType<int>(snapshotData['carbs']);
    _effectiveDate = snapshotData['effective_date'] as DateTime?;
    _fat = castToType<int>(snapshotData['fat']);
    _client = snapshotData['client'] as DocumentReference?;
    _updatedBy = snapshotData['updated_by'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('nutrition_goals');

  static Stream<NutritionGoalsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NutritionGoalsRecord.fromSnapshot(s));

  static Future<NutritionGoalsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NutritionGoalsRecord.fromSnapshot(s));

  static NutritionGoalsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NutritionGoalsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NutritionGoalsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NutritionGoalsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NutritionGoalsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NutritionGoalsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createNutritionGoalsRecordData({
  int? calories,
  int? protein,
  int? carbs,
  DateTime? effectiveDate,
  int? fat,
  DocumentReference? client,
  DocumentReference? updatedBy,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'effective_date': effectiveDate,
      'fat': fat,
      'client': client,
      'updated_by': updatedBy,
    }.withoutNulls,
  );

  return firestoreData;
}

class NutritionGoalsRecordDocumentEquality
    implements Equality<NutritionGoalsRecord> {
  const NutritionGoalsRecordDocumentEquality();

  @override
  bool equals(NutritionGoalsRecord? e1, NutritionGoalsRecord? e2) {
    return e1?.calories == e2?.calories &&
        e1?.protein == e2?.protein &&
        e1?.carbs == e2?.carbs &&
        e1?.effectiveDate == e2?.effectiveDate &&
        e1?.fat == e2?.fat &&
        e1?.client == e2?.client &&
        e1?.updatedBy == e2?.updatedBy;
  }

  @override
  int hash(NutritionGoalsRecord? e) => const ListEquality().hash([
        e?.calories,
        e?.protein,
        e?.carbs,
        e?.effectiveDate,
        e?.fat,
        e?.client,
        e?.updatedBy
      ]);

  @override
  bool isValidKey(Object? o) => o is NutritionGoalsRecord;
}
