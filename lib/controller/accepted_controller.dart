import 'package:foodcafe/model/order/order.dart';
import 'package:foodcafe/model/order/order_response.dart';
import 'package:foodcafe/resource/colors.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';
import 'package:foodcafe/utils/extensions.dart';

class AcceptedController extends GetxController {
  static AcceptedController get to => Get.find();

  var rxAcceptedList = RxList<OrderMainList>([]);
  var search = Rx<String>('');

  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);
  var refreshStatus = Rx<RefreshStatus>(RefreshStatus.INITIAL);

/*  @override
  onInit() {
    super.onInit();
    fetchAccepted();
  }*/

  Future<void> fetchAccepted({bool isRefresh = false}) async {
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.LOADING;
    }

    stateStatus.value = StateStatus.LOADING;

    List<OrderMainList> orderMainList = [
      OrderMainList(
          uniqueId: 'FCO2026',
          dateTime: 1607919790946705,
          typeDelivery: 'Home delivery',
          paymentType: 'Paid',
          totalQuantity: 2,
          totalAmount: 4000,
          totalOtherChargeAmount: 400,
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
                isVegNonVeg: 2,
                quantity: 2,
                price: 2000,
                orderType: 1)
          ]),
      OrderMainList(
          uniqueId: 'FCO2029',
          dateTime: 1607919790946705,
          typeDelivery: 'Home delivery',
          paymentType: 'Paid',
          totalQuantity: 2,
          totalAmount: 4000,
          totalOtherChargeAmount: 400,
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
                isVegNonVeg: 2,
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
    rxAcceptedList.assignAll(
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

  void deliveryPersonalDetailSelect(
      {String uniqueId,
      String deliveryPersonUniqueId,
      String deliveryPersonName,
      int deliveryPersonMobile,
      int deliveryDateTime}) {
    int indexGet =
        rxAcceptedList.indexWhere((element) => element.uniqueId == uniqueId);
    if (indexGet != -1) {
      rxAcceptedList[indexGet].deliveryPersonDetail.name.value =
          deliveryPersonName;
      rxAcceptedList[indexGet].deliveryPersonDetail.uniqueId.value =
          deliveryPersonUniqueId;
      rxAcceptedList[indexGet].deliveryPersonDetail.mobileNo.value =
          deliveryPersonMobile;
      rxAcceptedList[indexGet].deliveryPersonDetail.arrivingDateTime.value =
          deliveryDateTime;

      rxAcceptedList[indexGet].deliveryPersonDetail.isSelect.value = true;
    }
  }

  void deliveryPersonalDetailUnSelect({String uniqueId}) {
    int indexGet =
        rxAcceptedList.indexWhere((element) => element.uniqueId == uniqueId);
    if (indexGet != -1) {
      rxAcceptedList[indexGet].deliveryPersonDetail.name.value = '';
      rxAcceptedList[indexGet].deliveryPersonDetail.uniqueId.value = '';
      rxAcceptedList[indexGet].deliveryPersonDetail.mobileNo.value = null;
      rxAcceptedList[indexGet].deliveryPersonDetail.arrivingDateTime.value = null;

      rxAcceptedList[indexGet].deliveryPersonDetail.isSelect.value = false;
    }
  }

  void removeOrder(
      {String uniqueId, String message, bool isShowToast = false}) {
    int indexGet =
        rxAcceptedList.indexWhere((element) => element.uniqueId == uniqueId);
    if (indexGet != -1) {
      if (isShowToast)
      toast(
            title: rxAcceptedList[indexGet].orderPersonDetail.name,
            message: message,
            textColor: toastMessageOrderColor,
            backgroundColor: toastBackgroundOrderColor,
            flushBarPosition: toastPositionBottom);
      rxAcceptedList.removeAt(indexGet);
    }
  }
}
