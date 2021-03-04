import 'package:foodcafe/model/notification/notification_response.dart';
import 'package:foodcafe/ui/widget/animation/slide_in_transition.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController with SingleGetTickerProviderMixin {
  static NotificationController get to => Get.find();
  var rxNotificationList = RxList<Notification>([]);
  var rxTotalNotificationCounter = Rx<int>(0);
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  SlideInController animationController;

   @override
  onInit() {
    super.onInit();
    animationController = SlideInController(vsync: this);
    animationController.forward();
    fetchNotification();
  }

  Future<void> fetchNotification() async {
    stateStatus.value = StateStatus.LOADING;

    var notificationResponse =
        NotificationResponse(totalNotification: 1, notificationList: [
      Notification(
          uniqueId: '1',
          title: 'Login',
          description: 'Login successful',
          dateTime: 1607919790946705)
    ]);

    await Future.delayed(Duration(seconds: 2));
    stateStatus.value = StateStatus.SUCCESS;

    rxTotalNotificationCounter.value = notificationResponse.totalNotification;
    rxNotificationList.assignAll(notificationResponse.notificationList);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}
