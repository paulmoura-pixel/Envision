import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProgressPhotosRecord extends FirestoreRecord {
  ProgressPhotosRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "client" field.
  DocumentReference? _client;
  DocumentReference? get client => _client;
  bool hasClient() => _client != null;

  // "photo_path" field.
  String? _photoPath;
  String get photoPath => _photoPath ?? '';
  bool hasPhotoPath() => _photoPath != null;

  // "photo_type" field.
  String? _photoType;
  String get photoType => _photoType ?? '';
  bool hasPhotoType() => _photoType != null;

  // "taken_at" field.
  DateTime? _takenAt;
  DateTime? get takenAt => _takenAt;
  bool hasTakenAt() => _takenAt != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  bool hasNotes() => _notes != null;

  // "shared_with_coach" field.
  bool? _sharedWithCoach;
  bool get sharedWithCoach => _sharedWithCoach ?? false;
  bool hasSharedWithCoach() => _sharedWithCoach != null;

  void _initializeFields() {
    _client = snapshotData['client'] as DocumentReference?;
    _photoPath = snapshotData['photo_path'] as String?;
    _photoType = snapshotData['photo_type'] as String?;
    _takenAt = snapshotData['taken_at'] as DateTime?;
    _notes = snapshotData['notes'] as String?;
    _sharedWithCoach = snapshotData['shared_with_coach'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('progress_photos');

  static Stream<ProgressPhotosRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ProgressPhotosRecord.fromSnapshot(s));

  static Future<ProgressPhotosRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ProgressPhotosRecord.fromSnapshot(s));

  static ProgressPhotosRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ProgressPhotosRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ProgressPhotosRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ProgressPhotosRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ProgressPhotosRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ProgressPhotosRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createProgressPhotosRecordData({
  DocumentReference? client,
  String? photoPath,
  String? photoType,
  DateTime? takenAt,
  String? notes,
  bool? sharedWithCoach,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'client': client,
      'photo_path': photoPath,
      'photo_type': photoType,
      'taken_at': takenAt,
      'notes': notes,
      'shared_with_coach': sharedWithCoach,
    }.withoutNulls,
  );

  return firestoreData;
}

class ProgressPhotosRecordDocumentEquality
    implements Equality<ProgressPhotosRecord> {
  const ProgressPhotosRecordDocumentEquality();

  @override
  bool equals(ProgressPhotosRecord? e1, ProgressPhotosRecord? e2) {
    return e1?.client == e2?.client &&
        e1?.photoPath == e2?.photoPath &&
        e1?.photoType == e2?.photoType &&
        e1?.takenAt == e2?.takenAt &&
        e1?.notes == e2?.notes &&
        e1?.sharedWithCoach == e2?.sharedWithCoach;
  }

  @override
  int hash(ProgressPhotosRecord? e) => const ListEquality().hash([
        e?.client,
        e?.photoPath,
        e?.photoType,
        e?.takenAt,
        e?.notes,
        e?.sharedWithCoach
      ]);

  @override
  bool isValidKey(Object? o) => o is ProgressPhotosRecord;
}
