import 'package:flutter/material.dart';
import 'package:foodcafe/model/past_order_detail/past_order_detail.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';

class PastOrderDetailController extends GetxController {
  static PastOrderDetailController get to => Get.find();
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);
  var rxPastOrderDetail = Rx<PastOrderDetail>();

  @override
  onInit() {
    super.onInit();
    fetchPastOrderDetail(userId: '', uniqueId: '');
  }

  fetchPastOrderDetail({@required String userId, @required String uniqueId}) {
    var pastOrderDetail = PastOrderDetail(
      uniqueId: 'ECOM200',
      typeDelivery: 'Home delivery',
      orderStatus: 'Completed',
      paymentType: 'Paid',
      totalQuantity: 5,
      totalOrderQuantity: 3,
      totalExtraOrderQuantity: 2,
      totalOrderAmount: 6000,
      extraOrderTotalAmount: 10,
      totalAmount: 6510,
      totalOtherChargeAmount: 500,
      dateTime: 1607919790946705,
      orderPersonDetail: OrderPersonDetail(
          name: 'Lakhani Kamlesh',
          email: 'kamal.lakhani56@gmail.com',
          mobile: 9586331823,
          address: 'To. Ravani (Kuba) Ta.Visavadar Dis.Junagadh'),
      deliveryPersonDetail: DeliveryPersonDetail(
          uniqueId: '001',
          name: 'Lakhani kamlesh',
          arrivingDateTime: 1607919790946705,
          mobileNo: 9586331823,
          otp: 1234),
      orderList: [
        Order(
            uniqueId: 'FCO2022',
            recipeName: 'Chicken biryani',
            isVegNonVeg: 2,
            quantity: 1,
            price: 2000,
            orderType: 1),
        Order(
            uniqueId: 'FCO2022',
            recipeName: 'Rice',
            isVegNonVeg: 1,
            quantity: 2,
            price: 2000,
            orderType: 2)
      ],
      extraOrderList: [
        ExtraOrder(extraOrderName: 'Bowl', quantity: 2, price: 5)],
      otherChargeList: [
        OtherCharge(name: 'GST', chargeAmount: 200),
        OtherCharge(name: 'Delivery charge', chargeAmount: 100),
        OtherCharge(name: 'Discount', chargeAmount: 100),
        OtherCharge(name: 'CGST', chargeAmount: 50),
        OtherCharge(name: 'SGST', chargeAmount: 50)
      ],
    );
    rxPastOrderDetail = pastOrderDetail.obs;
  }
}
