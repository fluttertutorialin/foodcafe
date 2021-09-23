import 'package:get/get.dart';
import '../model/notification/notification_response.dart';
import '../ui/widget/animation/slide_in_transition.dart';
import '../utils/state_status.dart';

class NotificationController extends GetxController with SingleGetTickerProviderMixin {
  static NotificationController get to => Get.find();
  var rxNotificationList = RxList<Notification>([]);
  var rxTotalNotificationCounter = Rx<int>(0);
  var stateStatus = Rx<StateStatus>(StateStatus.initial);

  SlideInController animationController;

   @override
  onInit() {
    super.onInit();
    animationController = SlideInController(vsync: this);
    animationController.forward();
    fetchNotification();
  }

  Future<void> fetchNotification() async {
    stateStatus.value = StateStatus.loading;

    var notificationResponse =
        NotificationResponse(totalNotification: 1, notificationList: [
      Notification(
          uniqueId: '1',
          title: 'Login',
          description: 'Login successful',
          dateTime: 1607919790946705)
    ]);

    await Future.delayed(const Duration(seconds: 2));
    stateStatus.value = StateStatus.success;

    rxTotalNotificationCounter.value = notificationResponse.totalNotification;
    rxNotificationList.assignAll(notificationResponse.notificationList);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}
