import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodcafe/model/notification_counter.dart';
import 'package:foodcafe/shared/provider/firestore_provider.dart';
import 'package:get/get.dart';
import '../http_hepler.dart';

class FireStoreDatabaseRepository implements FireStoreDatabaseProvider {
  final _fireStoreDatabaseFoodCafe = Get.find<FireStoreDatabaseProvider>();

  @override
  Stream<List<NotificationCounterResponse>> notificationCounter() {
    return _fireStoreDatabaseFoodCafe.notificationCounter();
  }

  @override
  notificationCounterUpdate(String docId, String columnName,
      {String notificationCounter = '0'}) {
    _fireStoreDatabaseFoodCafe.notificationCounterUpdate(docId, columnName,
        notificationCounter: notificationCounter);
  }

  @override
  Future<User> googleLogin() {
    return _fireStoreDatabaseFoodCafe.googleLogin();
  }

  @override
  googleLogout() async {
    _fireStoreDatabaseFoodCafe.googleLogout();
  }

  @override
  void login(
      {@required dynamic body,
      @required HttpSuccessCallback success,
      @required HttpFailureCallback error}) {
    _fireStoreDatabaseFoodCafe.login(
        body: body, success: success, error: error);
  }

  void forgotPassword(
      {@required HttpSuccessCallback success,
      @required HttpFailureCallback error}) {

  }

  @override
  void changePassword(
      {@required HttpSuccessCallback success,
      @required HttpFailureCallback error}) {

  }
}
