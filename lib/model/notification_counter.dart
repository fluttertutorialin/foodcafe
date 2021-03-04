import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationCounterResponse{
  String pending, accepted, ready, dispatched;

  NotificationCounterResponse({
    this.pending = '0',
    this.accepted = '0',
    this.ready = '0',
    this.dispatched = '0',
  });

  NotificationCounterResponse.fromDocumentSnapshot(DocumentChange documentChange) {
    pending = documentChange.doc["pending"];
    accepted = documentChange.doc["accepted"];
    ready = documentChange.doc["ready"];
    dispatched = documentChange.doc["dispatched"];
  }
}