import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationsRecord extends FirestoreRecord {
  NotificationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "recipient" field.
  DocumentReference? _recipient;
  DocumentReference? get recipient => _recipient;
  bool hasRecipient() => _recipient != null;

  // "body" field.
  String? _body;
  String get body => _body ?? '';
  bool hasBody() => _body != null;

  // "client" field.
  DocumentReference? _client;
  DocumentReference? get client => _client;
  bool hasClient() => _client != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "read" field.
  bool? _read;
  bool get read => _read ?? false;
  bool hasRead() => _read != null;

  // "recipient_id" field.
  String? _recipientId;
  String get recipientId => _recipientId ?? '';
  bool hasRecipientId() => _recipientId != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  void _initializeFields() {
    _recipient = snapshotData['recipient'] as DocumentReference?;
    _body = snapshotData['body'] as String?;
    _client = snapshotData['client'] as DocumentReference?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _read = snapshotData['read'] as bool?;
    _recipientId = snapshotData['recipient_id'] as String?;
    _title = snapshotData['title'] as String?;
    _type = snapshotData['type'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('notifications');

  static Stream<NotificationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotificationsRecord.fromSnapshot(s));

  static Future<NotificationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NotificationsRecord.fromSnapshot(s));

  static NotificationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NotificationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotificationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotificationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotificationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotificationsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createNotificationsRecordData({
  DocumentReference? recipient,
  String? body,
  DocumentReference? client,
  DateTime? createdAt,
  bool? read,
  String? recipientId,
  String? title,
  String? type,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'recipient': recipient,
      'body': body,
      'client': client,
      'created_at': createdAt,
      'read': read,
      'recipient_id': recipientId,
      'title': title,
      'type': type,
    }.withoutNulls,
  );

  return firestoreData;
}

class NotificationsRecordDocumentEquality
    implements Equality<NotificationsRecord> {
  const NotificationsRecordDocumentEquality();

  @override
  bool equals(NotificationsRecord? e1, NotificationsRecord? e2) {
    return e1?.recipient == e2?.recipient &&
        e1?.body == e2?.body &&
        e1?.client == e2?.client &&
        e1?.createdAt == e2?.createdAt &&
        e1?.read == e2?.read &&
        e1?.recipientId == e2?.recipientId &&
        e1?.title == e2?.title &&
        e1?.type == e2?.type;
  }

  @override
  int hash(NotificationsRecord? e) => const ListEquality().hash([
        e?.recipient,
        e?.body,
        e?.client,
        e?.createdAt,
        e?.read,
        e?.recipientId,
        e?.title,
        e?.type
      ]);

  @override
  bool isValidKey(Object? o) => o is NotificationsRecord;
}
