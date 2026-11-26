import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MealCommentsRecord extends FirestoreRecord {
  MealCommentsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "mealRef" field.
  DocumentReference? _mealRef;
  DocumentReference? get mealRef => _mealRef;
  bool hasMealRef() => _mealRef != null;

  // "coachRef" field.
  DocumentReference? _coachRef;
  DocumentReference? get coachRef => _coachRef;
  bool hasCoachRef() => _coachRef != null;

  // "clientRef" field.
  DocumentReference? _clientRef;
  DocumentReference? get clientRef => _clientRef;
  bool hasClientRef() => _clientRef != null;

  // "authorRef" field.
  DocumentReference? _authorRef;
  DocumentReference? get authorRef => _authorRef;
  bool hasAuthorRef() => _authorRef != null;

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  bool hasContent() => _content != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "updatedAt" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  void _initializeFields() {
    _mealRef = snapshotData['mealRef'] as DocumentReference?;
    _coachRef = snapshotData['coachRef'] as DocumentReference?;
    _clientRef = snapshotData['clientRef'] as DocumentReference?;
    _authorRef = snapshotData['authorRef'] as DocumentReference?;
    _content = snapshotData['content'] as String?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _updatedAt = snapshotData['updatedAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('meal_comments');

  static Stream<MealCommentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MealCommentsRecord.fromSnapshot(s));

  static Future<MealCommentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MealCommentsRecord.fromSnapshot(s));

  static MealCommentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MealCommentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MealCommentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MealCommentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MealCommentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MealCommentsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createMealCommentsRecordData({
  DocumentReference? mealRef,
  DocumentReference? coachRef,
  DocumentReference? clientRef,
  DocumentReference? authorRef,
  String? content,
  DateTime? createdAt,
  DateTime? updatedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'mealRef': mealRef,
      'coachRef': coachRef,
      'clientRef': clientRef,
      'authorRef': authorRef,
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class MealCommentsRecordDocumentEquality
    implements Equality<MealCommentsRecord> {
  const MealCommentsRecordDocumentEquality();

  @override
  bool equals(MealCommentsRecord? e1, MealCommentsRecord? e2) {
    return e1?.mealRef == e2?.mealRef &&
        e1?.coachRef == e2?.coachRef &&
        e1?.clientRef == e2?.clientRef &&
        e1?.authorRef == e2?.authorRef &&
        e1?.content == e2?.content &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt;
  }

  @override
  int hash(MealCommentsRecord? e) => const ListEquality().hash([
        e?.mealRef,
        e?.coachRef,
        e?.clientRef,
        e?.authorRef,
        e?.content,
        e?.createdAt,
        e?.updatedAt
      ]);

  @override
  bool isValidKey(Object? o) => o is MealCommentsRecord;
}
