import 'package:foodcafe/model/order/order.dart';
import 'package:foodcafe/model/order/order_response.dart';
import 'package:foodcafe/resource/colors.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';
import 'package:foodcafe/utils/extensions.dart';

class PendingController extends GetxController {
  static PendingController get to => Get.find();

  var rxPendingList = RxList<OrderMainList>([]);
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);
  var refreshStatus = Rx<RefreshStatus>(RefreshStatus.INITIAL);

  var search = Rx<String>('');

  /*@override
  onInit() {
    super.onInit();
    fetchPending();
  }*/

  Future<void> fetchPending({bool isRefresh = false}) async {
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.LOADING;
    }
    stateStatus.value = StateStatus.LOADING;

    List<OrderMainList> orderMainList = [
      OrderMainList(
          uniqueId: 'FCO2021',
          dateTime: 1607919790946705,
          typeDelivery: 'Home delivery',
          paymentType: 'Paid',
          totalQuantity: 3,
          totalAmount: 6000,
          extraOrderTotalAmount: 10,
          totalOtherChargeAmount: 400,
          extraOrderList: [
            ExtraOrder(extraOrderName: 'Bowl', quantity: 2, price: 5)],
          orderPersonDetail: OrderPersonDetail(
              name: 'Kamlesh',
              address: 'G-503, FLUTTER STYLE, NIKOL (AHMEDABAD) 123456',
              mobile: 9586331823,
              email: 'food.cafe@gmail.com'),
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
                isVegNonVeg: 2,
                quantity: 1,
                price: 2000,
                orderType: 1),
            Order(
                uniqueId: 'FCO2021',
                recipeName: 'Chicken biryani',
                isVegNonVeg: 2,
                quantity: 2,
                price: 2000,
                orderType: 2)
          ]),
    ];
    await Future.delayed(Duration(seconds: 2));
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.SUCCESS;
      refreshStatus.value = RefreshStatus.INITIAL;
    }
    stateStatus.value = StateStatus.SUCCESS;

    rxPendingList.assignAll(
        PendingResponse(orderMainList: orderMainList).orderMainList.obs);
  }

  void removeOrder(
      {String uniqueId, String message, bool isShowToast = false}) {
    int indexGet =
        rxPendingList.indexWhere((element) => element.uniqueId == uniqueId);
    if (indexGet != -1) {
      if (isShowToast)
        toast(
            title: rxPendingList[indexGet].orderPersonDetail.name,
            message: message,
            textColor: toastMessageOrderColor,
            backgroundColor: toastBackgroundOrderColor,
            flushBarPosition: toastOrderPosition);
      rxPendingList.removeAt(indexGet);
    }
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

  void preparationTimeSelect(String uniqueId, int time) {
    int getIndex =
        rxPendingList.indexWhere((element) => element.uniqueId == uniqueId);
    int timeIndex = rxPendingList[getIndex]
        .preparationTimeList
        .indexWhere((element) => element.time.value == time);

    if (rxPendingList[getIndex].preparationTimeList[timeIndex].isSelect.value) {
      rxPendingList[getIndex].preparationTimeList[timeIndex].isSelect.value =
          false;
      rxPendingList[getIndex].preparationTimeDefault.setSelectTime(0);
    } else {
      int previousSelectIndex = rxPendingList[getIndex]
          .preparationTimeList
          .indexWhere((element) => element.isSelect.value == true);
      if (previousSelectIndex != -1) {
        rxPendingList[getIndex]
            .preparationTimeList[previousSelectIndex]
            .isSelect
            .value = false;
        rxPendingList[getIndex].preparationTimeDefault.setSelectTime(0);
      }
      rxPendingList[getIndex].preparationTimeDefault.setSelectTime(time);
      rxPendingList[getIndex].preparationTimeList[timeIndex].isSelect.value =
          true;
    }
  }

  void preparationTimePlus(String uniqueId, int time) {
    int getIndex =
        rxPendingList.indexWhere((element) => element.uniqueId == uniqueId);
    rxPendingList[getIndex].preparationTimeDefault.selectTime.value = time + 5;

    _preparationTimeSelectUnSelect(rxPendingList[getIndex].preparationTimeList,
        rxPendingList[getIndex].preparationTimeDefault);
  }

  void preparationTimeMinus(String uniqueId, int time) {
    if (time > 0) {
      int getIndex =
          rxPendingList.indexWhere((element) => element.uniqueId == uniqueId);
      rxPendingList[getIndex].preparationTimeDefault.selectTime.value =
          time - 5;

      _preparationTimeSelectUnSelect(
          rxPendingList[getIndex].preparationTimeList,
          rxPendingList[getIndex].preparationTimeDefault);
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
