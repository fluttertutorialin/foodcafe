import 'package:foodcafe/model/notification_counter.dart';
import 'package:foodcafe/shared/repository/firestore_database_repository.dart';
import 'package:get/get.dart';

class NotificationFirebaseController extends GetxController {
  static NotificationFirebaseController get to => Get.find();

  var fireStoreDatabaseRepository = Get.find<FireStoreDatabaseRepository>();
  var rxNotificationList = Rx<List<NotificationCounterResponse>>([]);

  List<NotificationCounterResponse> get notificationList =>
      rxNotificationList.value;

  @override
  void onInit() {
    super.onInit();
    rxNotificationList
        .bindStream(fireStoreDatabaseRepository.notificationCounter());
  }

  sentNotificationUpdateCounter(String docId, String columnName,
      {String notificationCounter = '0'}) {
    fireStoreDatabaseRepository.notificationCounterUpdate('', '',
        notificationCounter: notificationCounter);
  }

  @override
  void dispose() {
    super.dispose();
    rxNotificationList.close();
  }
}
