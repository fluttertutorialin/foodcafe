import 'package:foodcafe/model/pastorder/past_order_response.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';

class PastOrderController extends GetxController {
  static PastOrderController get to => Get.find();
  var pastOrder = Rx<PastOrderResponse>();

  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);
  var refreshStatus = Rx<RefreshStatus>(RefreshStatus.INITIAL);

  @override
  onInit() {
    super.onInit();
    fetchPastOrder();
  }

  Future<void> fetchPastOrder(
      {int orderStatus = 1, bool isRefresh = false}) async {
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.LOADING;
    }

    stateStatus.value = StateStatus.LOADING;

    var pastOrderResponse = PastOrderResponse(pastOrderList: [
      PastOrder(
          uniqueId: 'ECOM2000',
          orderTotalAmount: 6000.0,
          typeDelivery: 'Home delivery',
          orderStatus: 'Completed',
          paymentType: 'Paid',
          orderStatusId: 2,
          dateTime: 1607919790946705),
      PastOrder(
          uniqueId: 'ECOM2001',
          orderTotalAmount: 3000,
          typeDelivery: 'Home delivery',
          orderStatus: 'Rejected',
          paymentType: 'Paid',
          dateTime: 1607919790946705,
          isRefundable: 1,
          orderStatusId: 3,
          remark: 'Items are not available')
    ]);

    await Future.delayed(Duration(seconds: 2));
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.SUCCESS;
      refreshStatus.value = RefreshStatus.INITIAL;
    }
    stateStatus.value = StateStatus.SUCCESS;

    pastOrder = pastOrderResponse.obs;
  }
}
