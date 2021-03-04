import 'package:flutter/material.dart';
import 'package:foodcafe/model/order/order.dart';
import 'package:foodcafe/model/order/order_response.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';
import 'controller.dart';

class AllFindController extends GetxController {
  static AllFindController get to => Get.find();
  var stateStatus = StateStatus.INITIAL.obs;
  var refreshStatus = Rx<RefreshStatus>(RefreshStatus.INITIAL);

  var rxAllFindList = RxList<OrderMainList>([]);
  var searchController = TextEditingController();
  var _homeController = Get.put(HomeController());

  var isTimeSelect = Rx<bool>(false);
  var isVisibleSearchClearIcon = false.obs;

  var search = Rx<String>('');

  Future<void> fetchAllFind({bool isRefresh = false, String allFind}) async {
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
          totalOtherChargeAmount: 500,
          whereToReachOrder: 1,
          extraOrderList: [],
          deliveryPersonDetail: DeliveryPersonDetail(isSelect: false),
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
      OrderMainList(
          uniqueId: 'FCO2023',
          dateTime: 1607919790946705,
          typeDelivery: 'Home delivery',
          paymentType: 'Paid',
          totalQuantity: 2,
          totalAmount: 4000,
          totalOtherChargeAmount: 500,
          orderStatus: 'Rejected',
          remark: 'Items are not available',
          extraOrderList: [],
          deliveryPersonDetail: DeliveryPersonDetail(isSelect: false),
          orderPersonDetail: OrderPersonDetail(
              name: 'Kamlesh',
              address: 'G-503, FLUTTER STYLE, NIKOL (AHMEDABAD) 123456',
              mobile: 9586331823,
              email: 'food.cafe@gmail.com'),
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
                quantity: 2,
                price: 2000,
                orderType: 1)
          ]),
      OrderMainList(
          uniqueId: 'FCO2030',
          dateTime: 1607919790946705,
          typeDelivery: 'Home delivery',
          paymentType: 'Paid',
          totalQuantity: 2,
          totalAmount: 4000,
          totalOtherChargeAmount: 500,
          orderStatus: 'Completed',
          extraOrderList: [],
          deliveryPersonDetail: DeliveryPersonDetail(
              isSelect: true,
              uniqueId: '1',
              name: 'Lakhani Kamlesh',
              arrivingDateTime: 1607919790946705,
              mobileNo: 9586331823),
          orderPersonDetail: OrderPersonDetail(
              name: 'Kamlesh',
              address: 'G-503, FLUTTER STYLE, NIKOL (AHMEDABAD) 123456',
              mobile: 9586331823,
              email: 'food.cafe@gmail.com'),
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
                quantity: 2,
                price: 2000,
                orderType: 1)
          ]),
      OrderMainList(
          uniqueId: 'FCO2024',
          dateTime: 1607919790946705,
          typeDelivery: 'Home delivery',
          paymentType: 'Paid',
          totalQuantity: 2,
          totalAmount: 4000,
          totalOtherChargeAmount: 500,
          whereToReachOrder: 3,
          extraOrderList: [],
          orderPersonDetail: OrderPersonDetail(
              name: 'Kamlesh',
              address: 'G-503, FLUTTER STYLE, NIKOL (AHMEDABAD) 123456',
              mobile: 9586331823,
              email: 'food.cafe@gmail.com'),
          deliveryPersonDetail: DeliveryPersonDetail(
              isSelect: true,
              uniqueId: '1',
              name: 'Lakhani Kamlesh',
              arrivingDateTime: 1607919790946705,
              mobileNo: 9586331823),
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
                quantity: 2,
                price: 2000,
                orderType: 1)
          ]),
      OrderMainList(
          uniqueId: 'FCO2025',
          dateTime: 1607919790946705,
          typeDelivery: 'Home delivery',
          paymentType: 'Paid',
          totalQuantity: 2,
          totalAmount: 4000,
          totalOtherChargeAmount: 500,
          whereToReachOrder: 4,
          extraOrderList: [],
          orderPersonDetail: OrderPersonDetail(
              name: 'Kamlesh',
              address: 'G-503, FLUTTER STYLE, NIKOL (AHMEDABAD) 123456',
              mobile: 9586331823,
              email: 'food.cafe@gmail.com'),
          deliveryPersonDetail: DeliveryPersonDetail(
              isSelect: true,
              uniqueId: '1',
              name: 'Lakhani Kamlesh',
              arrivingDateTime: 1607919790946705,
              mobileNo: 9586331823),
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
                quantity: 2,
                price: 2000,
                orderType: 1)
          ]),
      OrderMainList(
          uniqueId: 'FCO2026',
          dateTime: 1607919790946705,
          typeDelivery: 'Home delivery',
          paymentType: 'Paid',
          totalQuantity: 2,
          totalAmount: 4000,
          totalOtherChargeAmount: 500,
          whereToReachOrder: 2,
          extraOrderList: [],
          deliveryPersonDetail: DeliveryPersonDetail(isSelect: false),
          orderPersonDetail: OrderPersonDetail(
              name: 'Kamlesh',
              address: 'G-503, FLUTTER STYLE, NIKOL (AHMEDABAD) 123456',
              mobile: 9586331823,
              email: 'food.cafe@gmail.com'),
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
                quantity: 2,
                price: 2000,
                orderType: 1)
          ])
    ];

    await Future.delayed(Duration(seconds: 2));

    if (isRefresh) {
      refreshStatus.value = RefreshStatus.SUCCESS;
      refreshStatus.value = RefreshStatus.INITIAL;
    }

    stateStatus.value = StateStatus.SUCCESS;

    rxAllFindList.assignAll(
        PendingResponse(orderMainList: orderMainList).orderMainList.obs);
  }

  void deliveryPersonalDetailSelect(
      {String uniqueId,
      String deliveryPersonUniqueId,
      String deliveryPersonName,
      int deliveryPersonMobile,
      int deliveryDateTime}) {
    int indexGet =
        rxAllFindList.indexWhere((element) => element.uniqueId == uniqueId);

    if (indexGet != -1) {
      rxAllFindList[indexGet].deliveryPersonDetail.name.value =
          deliveryPersonName;
      rxAllFindList[indexGet].deliveryPersonDetail.uniqueId.value =
          deliveryPersonUniqueId;
      rxAllFindList[indexGet].deliveryPersonDetail.mobileNo.value =
          deliveryPersonMobile;
      rxAllFindList[indexGet].deliveryPersonDetail.arrivingDateTime.value =
          deliveryDateTime;

      rxAllFindList[indexGet].deliveryPersonDetail.isSelect.value = true;
    }
  }

  void deliveryPersonalDetailUnSelect({String uniqueId}) {
    int indexGet =
    rxAllFindList.indexWhere((element) => element.uniqueId == uniqueId);
    if (indexGet != -1) {
      rxAllFindList[indexGet].deliveryPersonDetail.name.value = '';
      rxAllFindList[indexGet].deliveryPersonDetail.uniqueId.value = '';
      rxAllFindList[indexGet].deliveryPersonDetail.mobileNo.value = null;
      rxAllFindList[indexGet].deliveryPersonDetail.arrivingDateTime.value = null;

      rxAllFindList[indexGet].deliveryPersonDetail.isSelect.value = false;
    }
  }

  orderStatus(int whereToReachOrder) {
    switch (whereToReachOrder) {
      case 1:
        return acceptButton;
        break;

      case 2:
        return foodReadyButton;
        break;

      case 3:
        return dispatchButton;
        break;

      case 4:
        return settleOrderButton;
        break;
    }
  }

  void removeOrder(String uniqueId, int whereToReachOrder) {
    int currentPageIndex = _homeController.currentPageIndex.value;

    switch (currentPageIndex){
      case pendingIndex:
        _homeController.pendingController.removeOrder(uniqueId: uniqueId);
        break;

      case acceptedIndex:
        _homeController.acceptedController.removeOrder(uniqueId: uniqueId);
        break;

      case readyIndex:
        _homeController.readyController.removeOrder(uniqueId: uniqueId);
        break;

      case dispatchedIndex:
        _homeController.dispatchedController.removeOrder(uniqueId: uniqueId);
        break;
    }

    rxAllFindList.removeAt(
        rxAllFindList.indexWhere((element) => element.uniqueId == uniqueId));
  }

  void preparationTimeSelect(String uniqueId, int time) {
    _homeController.pendingController.preparationTimeSelect(uniqueId, time);

    int getIndex =
        rxAllFindList.indexWhere((element) => element.uniqueId == uniqueId);
    int timeIndex = rxAllFindList[getIndex]
        .preparationTimeList
        .indexWhere((element) => element.time.value == time);

    if (rxAllFindList[getIndex].preparationTimeList[timeIndex].isSelect.value) {
      rxAllFindList[getIndex].preparationTimeList[timeIndex].isSelect.value =
          false;
      rxAllFindList[getIndex].preparationTimeDefault.setSelectTime(0);
    } else {
      int previousSelectIndex = rxAllFindList[getIndex]
          .preparationTimeList
          .indexWhere((element) => element.isSelect.value == true);
      if (previousSelectIndex != -1) {
        rxAllFindList[getIndex]
            .preparationTimeList[previousSelectIndex]
            .isSelect
            .value = false;
        rxAllFindList[getIndex].preparationTimeDefault.setSelectTime(0);
      }
      rxAllFindList[getIndex].preparationTimeDefault.setSelectTime(time);
      rxAllFindList[getIndex].preparationTimeList[timeIndex].isSelect.value =
          true;
    }
  }

  void preparationTimePlus(String uniqueId, int time) {
    _homeController.pendingController.preparationTimePlus(uniqueId, time);

    int getIndex =
        rxAllFindList.indexWhere((element) => element.uniqueId == uniqueId);
    rxAllFindList[getIndex].preparationTimeDefault.selectTime.value = time + 5;

    _preparationTimeSelectUnSelect(rxAllFindList[getIndex].preparationTimeList,
        rxAllFindList[getIndex].preparationTimeDefault);
  }

  void preparationTimeMinus(String uniqueId, int time) {
    if (time > 0) {
      _homeController.pendingController.preparationTimeMinus(uniqueId, time);

      int getIndex =
          rxAllFindList.indexWhere((element) => element.uniqueId == uniqueId);
      rxAllFindList[getIndex].preparationTimeDefault.selectTime.value =
          time - 5;

      _preparationTimeSelectUnSelect(
          rxAllFindList[getIndex].preparationTimeList,
          rxAllFindList[getIndex].preparationTimeDefault);
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
