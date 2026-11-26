import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InvitationsRecord extends FirestoreRecord {
  InvitationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "coachName" field.
  String? _coachName;
  String get coachName => _coachName ?? '';
  bool hasCoachName() => _coachName != null;

  // "coachPhoto" field.
  String? _coachPhoto;
  String get coachPhoto => _coachPhoto ?? '';
  bool hasCoachPhoto() => _coachPhoto != null;

  // "coachRole" field.
  String? _coachRole;
  String get coachRole => _coachRole ?? '';
  bool hasCoachRole() => _coachRole != null;

  // "gymId" field.
  String? _gymId;
  String get gymId => _gymId ?? '';
  bool hasGymId() => _gymId != null;

  // "gymName" field.
  String? _gymName;
  String get gymName => _gymName ?? '';
  bool hasGymName() => _gymName != null;

  // "gymLocation" field.
  String? _gymLocation;
  String get gymLocation => _gymLocation ?? '';
  bool hasGymLocation() => _gymLocation != null;

  // "gymPhoto" field.
  String? _gymPhoto;
  String get gymPhoto => _gymPhoto ?? '';
  bool hasGymPhoto() => _gymPhoto != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "maxUses" field.
  int? _maxUses;
  int get maxUses => _maxUses ?? 0;
  bool hasMaxUses() => _maxUses != null;

  // "useCount" field.
  int? _useCount;
  int get useCount => _useCount ?? 0;
  bool hasUseCount() => _useCount != null;

  // "expiresAt" field.
  DateTime? _expiresAt;
  DateTime? get expiresAt => _expiresAt;
  bool hasExpiresAt() => _expiresAt != null;

  // "coach" field.
  DocumentReference? _coach;
  DocumentReference? get coach => _coach;
  bool hasCoach() => _coach != null;

  // "code" field.
  String? _code;
  String get code => _code ?? '';
  bool hasCode() => _code != null;

  void _initializeFields() {
    _coachName = snapshotData['coachName'] as String?;
    _coachPhoto = snapshotData['coachPhoto'] as String?;
    _coachRole = snapshotData['coachRole'] as String?;
    _gymId = snapshotData['gymId'] as String?;
    _gymName = snapshotData['gymName'] as String?;
    _gymLocation = snapshotData['gymLocation'] as String?;
    _gymPhoto = snapshotData['gymPhoto'] as String?;
    _status = snapshotData['status'] as String?;
    _maxUses = castToType<int>(snapshotData['maxUses']);
    _useCount = castToType<int>(snapshotData['useCount']);
    _expiresAt = snapshotData['expiresAt'] as DateTime?;
    _coach = snapshotData['coach'] as DocumentReference?;
    _code = snapshotData['code'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('invitations');

  static Stream<InvitationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => InvitationsRecord.fromSnapshot(s));

  static Future<InvitationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => InvitationsRecord.fromSnapshot(s));

  static InvitationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      InvitationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static InvitationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      InvitationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'InvitationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is InvitationsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createInvitationsRecordData({
  String? coachName,
  String? coachPhoto,
  String? coachRole,
  String? gymId,
  String? gymName,
  String? gymLocation,
  String? gymPhoto,
  String? status,
  int? maxUses,
  int? useCount,
  DateTime? expiresAt,
  DocumentReference? coach,
  String? code,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'coachName': coachName,
      'coachPhoto': coachPhoto,
      'coachRole': coachRole,
      'gymId': gymId,
      'gymName': gymName,
      'gymLocation': gymLocation,
      'gymPhoto': gymPhoto,
      'status': status,
      'maxUses': maxUses,
      'useCount': useCount,
      'expiresAt': expiresAt,
      'coach': coach,
      'code': code,
    }.withoutNulls,
  );

  return firestoreData;
}

class InvitationsRecordDocumentEquality implements Equality<InvitationsRecord> {
  const InvitationsRecordDocumentEquality();

  @override
  bool equals(InvitationsRecord? e1, InvitationsRecord? e2) {
    return e1?.coachName == e2?.coachName &&
        e1?.coachPhoto == e2?.coachPhoto &&
        e1?.coachRole == e2?.coachRole &&
        e1?.gymId == e2?.gymId &&
        e1?.gymName == e2?.gymName &&
        e1?.gymLocation == e2?.gymLocation &&
        e1?.gymPhoto == e2?.gymPhoto &&
        e1?.status == e2?.status &&
        e1?.maxUses == e2?.maxUses &&
        e1?.useCount == e2?.useCount &&
        e1?.expiresAt == e2?.expiresAt &&
        e1?.coach == e2?.coach &&
        e1?.code == e2?.code;
  }

  @override
  int hash(InvitationsRecord? e) => const ListEquality().hash([
        e?.coachName,
        e?.coachPhoto,
        e?.coachRole,
        e?.gymId,
        e?.gymName,
        e?.gymLocation,
        e?.gymPhoto,
        e?.status,
        e?.maxUses,
        e?.useCount,
        e?.expiresAt,
        e?.coach,
        e?.code
      ]);

  @override
  bool isValidKey(Object? o) => o is InvitationsRecord;
}
