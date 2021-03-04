import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodcafe/model/notification_counter.dart';
import 'package:foodcafe/resource/api.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../http_hepler.dart';

class FireStoreDatabaseProvider {
  FirebaseFirestore _firebaseFireStore;
  FirebaseAuth _firebaseAuth;
  HttpHelper _httpHelper;

  var _googleSignIn = GoogleSignIn();

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

  Future<User> googleLogin() async {
    var googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      var googleSignInAuthentication = await googleSignInAccount.authentication;

      var credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      var authResult = await _firebaseAuth.signInWithCredential(credential);
      var user = authResult.user;

      if (user != null)
        return _firebaseAuth.currentUser;
      else
        return null;
    }
    return null;
  }

  Future<void> googleLogout() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  void login({@required dynamic body, @required HttpSuccessCallback success, @required HttpFailureCallback error}) {
    _httpHelper.requestToServer(LOGIN_URL,
        method: Method.POST, body: body, success: success, error: error);
  }

  void changePassword(
      {HttpSuccessCallback success, HttpFailureCallback error}) {
    /*var formData = new FormData.fromMap({
      "": "",
    });*/

    _httpHelper.requestToServer(CHANGE_PASSWORD_URL,
        method: Method.POST, success: success, error: error);
  }
}
