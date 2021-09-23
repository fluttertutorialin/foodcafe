import 'package:get/get.dart';
import 'pending_controller.dart';
import '../model/order/order.dart';
import '../model/order/order_response.dart';
import '../resource/colors.dart';
import '../resource/value.dart';
import '../utils/state_status.dart';
import '../utils/extensions.dart';

class NewOrderController extends GetxController {
  static NewOrderController get to => Get.find();
  var refreshStatus = Rx<RefreshStatus>(RefreshStatus.initial);
  var stateStatus = StateStatus.initial.obs;

  var isTimeSelect = Rx<bool>(false);

  var rxNewOrderList = RxList<OrderMainList>([]);
  final _pendingController = Get.put(PendingController());

  @override
  onInit() {
    super.onInit();
    fetchNewOrder();
  }

  Future<void> fetchNewOrder({bool isRefresh = false}) async {
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.loading;
    }

    stateStatus.value = StateStatus.loading;

    List<OrderMainList> orderMainList = [
      OrderMainList(
          uniqueId: 'FCO2021',
          dateTime: 1607919790946705,
          typeDelivery: 'Home delivery',
          paymentType: 'Paid',
          totalQuantity: 3,
          totalAmount: 6000,
          totalOtherChargeAmount: 400,
          extraOrderList: [],
          preparationTimeList: [
            PreparationTimeList(time: 10, isSelect: false),
            PreparationTimeList(time: 20, isSelect: false),
            PreparationTimeList(time: 30, isSelect: false),
            PreparationTimeList(time: 40, isSelect: false),
            PreparationTimeList(time: 50, isSelect: false),
            PreparationTimeList(time: 60, isSelect: false),
          ],
          preparationTimeDefault: PreparationTimeDefault(
              defaultTime: 5, selectTime: 0, isMinHour: 1),
          otherChargeList: [
            OtherCharge(name: 'GST', chargeAmount: 200),
            OtherCharge(name: 'Delivery charge', chargeAmount: 100),
            OtherCharge(name: 'Discount', chargeAmount: 100),
            OtherCharge(name: 'CGST', chargeAmount: 50),
            OtherCharge(name: 'SGST', chargeAmount: 50)
          ],
          orderList: [
            Order(
                uniqueId: 'FCO2021',
                recipeName: 'Chicken biryani',
                quantity: 1,
                price: 2000,
                orderType: 1),
            Order(
                uniqueId: 'FCO2021OR',
                recipeName: 'Chicken biryani',
                quantity: 2,
                price: 2000,
                orderType: 2)
          ]),
    ];

    await Future.delayed(const Duration(seconds: 2));
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.success;
      refreshStatus.value = RefreshStatus.initial;
    }
    stateStatus.value = StateStatus.success;

    rxNewOrderList
        .assignAll(PendingResponse(orderMainList: orderMainList).orderMainList);
  }

  void removeOrder(
      {String uniqueId, String message, bool isShowToast = false}) {
    _pendingController.removeOrder(uniqueId: uniqueId);
    int indexGet =
        rxNewOrderList.indexWhere((element) => element.uniqueId == uniqueId);
    if (indexGet != -1) {
      if (isShowToast) {
        toast(
            title: rxNewOrderList[indexGet].orderPersonDetail.name,
            message: message,
            textColor: toastMessageOrderColor,
            backgroundColor: toastBackgroundOrderColor,
            flushBarPosition: toastPositionBottom);
      }
      rxNewOrderList.removeAt(indexGet);
    }
  }

  void preparationTimeSelect(String uniqueId, int time) {
    _pendingController.preparationTimeSelect(uniqueId, time);

    int getIndex =
        rxNewOrderList.indexWhere((element) => element.uniqueId == uniqueId);
    int timeIndex = rxNewOrderList[getIndex]
        .preparationTimeList
        .indexWhere((element) => element.time.value == time);

    if (rxNewOrderList[getIndex]
        .preparationTimeList[timeIndex]
        .isSelect
        .value) {
      rxNewOrderList[getIndex].preparationTimeList[timeIndex].isSelect.value =
          false;
      rxNewOrderList[getIndex].preparationTimeDefault.setSelectTime(0);
    } else {
      int previousSelectIndex = rxNewOrderList[getIndex]
          .preparationTimeList
          .indexWhere((element) => element.isSelect.value == true);
      if (previousSelectIndex != -1) {
        rxNewOrderList[getIndex]
            .preparationTimeList[previousSelectIndex]
            .isSelect
            .value = false;
        rxNewOrderList[getIndex].preparationTimeDefault.setSelectTime(0);
      }
      rxNewOrderList[getIndex].preparationTimeDefault.setSelectTime(time);
      rxNewOrderList[getIndex].preparationTimeList[timeIndex].isSelect.value =
          true;
    }
  }

  void preparationTimePlus(String uniqueId, int time) {
    int getIndex =
        rxNewOrderList.indexWhere((element) => element.uniqueId == uniqueId);
    rxNewOrderList[getIndex].preparationTimeDefault.selectTime.value = time + 5;

    _preparationTimeSelectUnSelect(rxNewOrderList[getIndex].preparationTimeList,
        rxNewOrderList[getIndex].preparationTimeDefault);

    _pendingController.preparationTimePlus(uniqueId, time);
  }

  void preparationTimeMinus(String uniqueId, int time) {
    if (time > 0) {
      int getIndex =
          rxNewOrderList.indexWhere((element) => element.uniqueId == uniqueId);
      rxNewOrderList[getIndex].preparationTimeDefault.selectTime.value =
          time - 5;

      _preparationTimeSelectUnSelect(
          rxNewOrderList[getIndex].preparationTimeList,
          rxNewOrderList[getIndex].preparationTimeDefault);

      _pendingController.preparationTimeMinus(uniqueId, time);
    }
  }
}

//LOGIC PART 1
void _preparationTimeSelectUnSelect(
    List<PreparationTimeList> preparationTimeList,
    PreparationTimeDefault preparationTimeDefault) {
  if (preparationTimeDefault.selectTime.value >
      0) if (preparationTimeDefault.selectTime.value % 10 == 0) {
    preparationTimeList.forEach((values) {
      values.isSelect.value = false;
    });

    preparationTimeList[int.parse((preparationTimeDefault.selectTime.value / 10)
                .toStringAsFixed(0)) -
            1]
        .isSelect
        .value = true;
  } else {
    preparationTimeList.forEach((values) {
      values.isSelect.value = false;
    });
  }
}
