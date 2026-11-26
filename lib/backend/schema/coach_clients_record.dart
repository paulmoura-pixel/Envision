import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CoachClientsRecord extends FirestoreRecord {
  CoachClientsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "coach" field.
  DocumentReference? _coach;
  DocumentReference? get coach => _coach;
  bool hasCoach() => _coach != null;

  // "client" field.
  DocumentReference? _client;
  DocumentReference? get client => _client;
  bool hasClient() => _client != null;

  // "invitation" field.
  DocumentReference? _invitation;
  DocumentReference? get invitation => _invitation;
  bool hasInvitation() => _invitation != null;

  // "client_id" field.
  String? _clientId;
  String get clientId => _clientId ?? '';
  bool hasClientId() => _clientId != null;

  // "coach_id" field.
  String? _coachId;
  String get coachId => _coachId ?? '';
  bool hasCoachId() => _coachId != null;

  // "gym_id" field.
  String? _gymId;
  String get gymId => _gymId ?? '';
  bool hasGymId() => _gymId != null;

  // "joined_at" field.
  DateTime? _joinedAt;
  DateTime? get joinedAt => _joinedAt;
  bool hasJoinedAt() => _joinedAt != null;

  // "share_photos" field.
  bool? _sharePhotos;
  bool get sharePhotos => _sharePhotos ?? false;
  bool hasSharePhotos() => _sharePhotos != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  void _initializeFields() {
    _coach = snapshotData['coach'] as DocumentReference?;
    _client = snapshotData['client'] as DocumentReference?;
    _invitation = snapshotData['invitation'] as DocumentReference?;
    _clientId = snapshotData['client_id'] as String?;
    _coachId = snapshotData['coach_id'] as String?;
    _gymId = snapshotData['gym_id'] as String?;
    _joinedAt = snapshotData['joined_at'] as DateTime?;
    _sharePhotos = snapshotData['share_photos'] as bool?;
    _status = snapshotData['status'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('coach_clients');

  static Stream<CoachClientsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CoachClientsRecord.fromSnapshot(s));

  static Future<CoachClientsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CoachClientsRecord.fromSnapshot(s));

  static CoachClientsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CoachClientsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CoachClientsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CoachClientsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CoachClientsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CoachClientsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createCoachClientsRecordData({
  DocumentReference? coach,
  DocumentReference? client,
  DocumentReference? invitation,
  String? clientId,
  String? coachId,
  String? gymId,
  DateTime? joinedAt,
  bool? sharePhotos,
  String? status,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'coach': coach,
      'client': client,
      'invitation': invitation,
      'client_id': clientId,
      'coach_id': coachId,
      'gym_id': gymId,
      'joined_at': joinedAt,
      'share_photos': sharePhotos,
      'status': status,
    }.withoutNulls,
  );

  return firestoreData;
}

class CoachClientsRecordDocumentEquality
    implements Equality<CoachClientsRecord> {
  const CoachClientsRecordDocumentEquality();

  @override
  bool equals(CoachClientsRecord? e1, CoachClientsRecord? e2) {
    return e1?.coach == e2?.coach &&
        e1?.client == e2?.client &&
        e1?.invitation == e2?.invitation &&
        e1?.clientId == e2?.clientId &&
        e1?.coachId == e2?.coachId &&
        e1?.gymId == e2?.gymId &&
        e1?.joinedAt == e2?.joinedAt &&
        e1?.sharePhotos == e2?.sharePhotos &&
        e1?.status == e2?.status;
  }

  @override
  int hash(CoachClientsRecord? e) => const ListEquality().hash([
        e?.coach,
        e?.client,
        e?.invitation,
        e?.clientId,
        e?.coachId,
        e?.gymId,
        e?.joinedAt,
        e?.sharePhotos,
        e?.status
      ]);

  @override
  bool isValidKey(Object? o) => o is CoachClientsRecord;
}
