import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FoodLogsRecord extends FirestoreRecord {
  FoodLogsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "client" field.
  DocumentReference? _client;
  DocumentReference? get client => _client;
  bool hasClient() => _client != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "meal_type" field.
  String? _mealType;
  String get mealType => _mealType ?? '';
  bool hasMealType() => _mealType != null;

  // "calories" field.
  int? _calories;
  int get calories => _calories ?? 0;
  bool hasCalories() => _calories != null;

  // "carbs" field.
  int? _carbs;
  int get carbs => _carbs ?? 0;
  bool hasCarbs() => _carbs != null;

  // "protein" field.
  int? _protein;
  int get protein => _protein ?? 0;
  bool hasProtein() => _protein != null;

  // "fat" field.
  int? _fat;
  int get fat => _fat ?? 0;
  bool hasFat() => _fat != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  // "logged_at" field.
  DateTime? _loggedAt;
  DateTime? get loggedAt => _loggedAt;
  bool hasLoggedAt() => _loggedAt != null;

  // "created_by" field.
  DocumentReference? _createdBy;
  DocumentReference? get createdBy => _createdBy;
  bool hasCreatedBy() => _createdBy != null;

  void _initializeFields() {
    _client = snapshotData['client'] as DocumentReference?;
    _description = snapshotData['description'] as String?;
    _mealType = snapshotData['meal_type'] as String?;
    _calories = castToType<int>(snapshotData['calories']);
    _carbs = castToType<int>(snapshotData['carbs']);
    _protein = castToType<int>(snapshotData['protein']);
    _fat = castToType<int>(snapshotData['fat']);
    _imageUrl = snapshotData['image_url'] as String?;
    _loggedAt = snapshotData['logged_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('food_logs');

  static Stream<FoodLogsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FoodLogsRecord.fromSnapshot(s));

  static Future<FoodLogsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FoodLogsRecord.fromSnapshot(s));

  static FoodLogsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FoodLogsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FoodLogsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FoodLogsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FoodLogsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FoodLogsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createFoodLogsRecordData({
  DocumentReference? client,
  String? description,
  String? mealType,
  int? calories,
  int? carbs,
  int? protein,
  int? fat,
  String? imageUrl,
  DateTime? loggedAt,
  DocumentReference? createdBy,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'client': client,
      'description': description,
      'meal_type': mealType,
      'calories': calories,
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
      'image_url': imageUrl,
      'logged_at': loggedAt,
      'created_by': createdBy,
    }.withoutNulls,
  );

  return firestoreData;
}

class FoodLogsRecordDocumentEquality implements Equality<FoodLogsRecord> {
  const FoodLogsRecordDocumentEquality();

  @override
  bool equals(FoodLogsRecord? e1, FoodLogsRecord? e2) {
    return e1?.client == e2?.client &&
        e1?.description == e2?.description &&
        e1?.mealType == e2?.mealType &&
        e1?.calories == e2?.calories &&
        e1?.carbs == e2?.carbs &&
        e1?.protein == e2?.protein &&
        e1?.fat == e2?.fat &&
        e1?.imageUrl == e2?.imageUrl &&
        e1?.loggedAt == e2?.loggedAt &&
        e1?.createdBy == e2?.createdBy;
  }

  @override
  int hash(FoodLogsRecord? e) => const ListEquality().hash([
        e?.client,
        e?.description,
        e?.mealType,
        e?.calories,
        e?.carbs,
        e?.protein,
        e?.fat,
        e?.imageUrl,
        e?.loggedAt,
        e?.createdBy
      ]);

  @override
  bool isValidKey(Object? o) => o is FoodLogsRecord;
}
