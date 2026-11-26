import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CoachDailyNotesRecord extends FirestoreRecord {
  CoachDailyNotesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "coachRef" field.
  DocumentReference? _coachRef;
  DocumentReference? get coachRef => _coachRef;
  bool hasCoachRef() => _coachRef != null;

  // "clientRef" field.
  DocumentReference? _clientRef;
  DocumentReference? get clientRef => _clientRef;
  bool hasClientRef() => _clientRef != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

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
    _coachRef = snapshotData['coachRef'] as DocumentReference?;
    _clientRef = snapshotData['clientRef'] as DocumentReference?;
    _date = snapshotData['date'] as DateTime?;
    _content = snapshotData['content'] as String?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _updatedAt = snapshotData['updatedAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('coach_daily_notes');

  static Stream<CoachDailyNotesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CoachDailyNotesRecord.fromSnapshot(s));

  static Future<CoachDailyNotesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CoachDailyNotesRecord.fromSnapshot(s));

  static CoachDailyNotesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CoachDailyNotesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CoachDailyNotesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CoachDailyNotesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CoachDailyNotesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CoachDailyNotesRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createCoachDailyNotesRecordData({
  DocumentReference? coachRef,
  DocumentReference? clientRef,
  DateTime? date,
  String? content,
  DateTime? createdAt,
  DateTime? updatedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'coachRef': coachRef,
      'clientRef': clientRef,
      'date': date,
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class CoachDailyNotesRecordDocumentEquality
    implements Equality<CoachDailyNotesRecord> {
  const CoachDailyNotesRecordDocumentEquality();

  @override
  bool equals(CoachDailyNotesRecord? e1, CoachDailyNotesRecord? e2) {
    return e1?.coachRef == e2?.coachRef &&
        e1?.clientRef == e2?.clientRef &&
        e1?.date == e2?.date &&
        e1?.content == e2?.content &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt;
  }

  @override
  int hash(CoachDailyNotesRecord? e) => const ListEquality().hash([
        e?.coachRef,
        e?.clientRef,
        e?.date,
        e?.content,
        e?.createdAt,
        e?.updatedAt
      ]);

  @override
  bool isValidKey(Object? o) => o is CoachDailyNotesRecord;
}
