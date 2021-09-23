import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../model/notification_counter.dart';
import '../../resource/api.dart';
import '../http_hepler.dart';

class FireStoreDatabaseProvider {
  final FirebaseFirestore _firebaseFireStore;
  final FirebaseAuth _firebaseAuth;
  final HttpHelper _httpHelper;

  final _googleSignIn = GoogleSignIn();

  FireStoreDatabaseProvider(
      this._firebaseFireStore, this._firebaseAuth, this._httpHelper);

  Stream<List<NotificationCounterResponse>> notificationCounter() =>
      _firebaseFireStore
          .collection(tableNameNotificationCounter)
          .snapshots()
          .map((docs) => docs.docChanges
              .map<NotificationCounterResponse>((response) =>
                  NotificationCounterResponse.fromDocumentSnapshot(response))
              .toList());

  void notificationCounterUpdate(String docId, String columnName,
      {String notificationCounter = '0'}) {
    _firebaseFireStore
        .collection(tableNameNotificationCounter)
        .doc(docId)
        .update({'columnName': notificationCounter});
  }

  Future<UserInfo> googleLogin() async {
    return null;
  }

  Future<void> googleLogout() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  void login({@required dynamic body, @required HttpSuccessCallback success, @required HttpFailureCallback error}) {
    _httpHelper.requestToServer('',
        method: Method.post, body: body, success: success, error: error);
  }

  void changePassword(
      {HttpSuccessCallback success, HttpFailureCallback error}) {
    /*var formData = new FormData.fromMap({
      "": "",
    });*/

    _httpHelper.requestToServer('',
        method: Method.post, success: success, error: error);
  }
}
