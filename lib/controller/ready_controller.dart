import 'package:get/get.dart';
import '../model/order/order.dart';
import '../model/order/order_response.dart';
import '../resource/colors.dart';
import '../resource/value.dart';
import '../utils/state_status.dart';
import '../utils/extensions.dart';

class ReadyController extends GetxController {
  static ReadyController get to => Get.find();
  var refreshStatus = Rx<RefreshStatus>(RefreshStatus.initial);
  var stateStatus = Rx<StateStatus>(StateStatus.initial);

  var rxReadyList = RxList<OrderMainList>([]);
  var search = Rx<String>('');

/*  @override
  onInit() {
    super.onInit();
    fetchReady();
  }*/

  Future<void> fetchReady({bool isRefresh = false}) async {
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.loading;
    }
    stateStatus.value = StateStatus.loading;

    List<OrderMainList> orderMainList = [
      OrderMainList(
          uniqueId: 'FCO2024',
          dateTime: 1607919790946705,
          typeDelivery: 'Home delivery',
          paymentType: 'Paid',
          totalQuantity: 1,
          totalOtherChargeAmount: 400,
          totalAmount: 2000,
          extraOrderList: [],
          orderPersonDetail: OrderPersonDetail(
              name: 'Kamlesh',
              address: 'G-503, FLUTTER STYLE, NIKOL (AHMEDABAD) 123456',
              mobile: 9586331823,
              email: 'food.cafe@gmail.com'),
          deliveryPersonDetail: DeliveryPersonDetail(
              uniqueId: '1',
              name: 'Lakhani Kamlesh',
              arrivingDateTime: 1607919790946705,
              mobileNo: 9586331823),
          preparationTimeList: [
            PreparationTimeList(time: 10, isSelect: false),
            PreparationTimeList(time: 20, isSelect: false),
            PreparationTimeList(time: 30, isSelect: false),
            PreparationTimeList(time: 40, isSelect: false),
            PreparationTimeList(time: 50, isSelect: false),
            PreparationTimeList(time: 60, isSelect: false),
          ],
          otherChargeList: [
            OtherCharge(name: 'GST', chargeAmount: 200),
            OtherCharge(name: 'Delivery charge', chargeAmount: 100),
            OtherCharge(name: 'Discount', chargeAmount: 100),
            OtherCharge(name: 'CGST', chargeAmount: 50),
            OtherCharge(name: 'SGST', chargeAmount: 50)
          ],
          orderList: [
            Order(
                uniqueId: 'FCO2021OR',
                recipeName: 'Chicken biryani',
                isVegNonVeg: 2,
                quantity: 1,
                price: 2000,
                orderType: 1)
          ])
    ];

    await Future.delayed(const Duration(seconds: 2));

    if (isRefresh) {
      refreshStatus.value = RefreshStatus.success;
      refreshStatus.value = RefreshStatus.initial;
    }

    stateStatus.value = StateStatus.success;
    rxReadyList.assignAll(
        PendingResponse(orderMainList: orderMainList).orderMainList);
  }

  bool findUniqueId(String value) {
    if (search.value == null) {
      return true;
    } else if (search.value.isEmpty) {
      return true;
    } else if (value.toLowerCase().contains(search.value.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }

  void removeOrder(
      {String uniqueId, String message, bool isShowToast = false}) {
    int indexGet =
        rxReadyList.indexWhere((element) => element.uniqueId == uniqueId);
    if (indexGet != -1) {
      if (isShowToast)
        toast(
            title: rxReadyList[indexGet].orderPersonDetail.name,
            message: message,
            textColor: toastMessageOrderColor,
            backgroundColor: toastBackgroundOrderColor,
            flushBarPosition: toastPositionBottom);
      rxReadyList.removeAt(indexGet);
    }
  }
}
