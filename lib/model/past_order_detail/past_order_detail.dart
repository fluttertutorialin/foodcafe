class PastOrderDetail {
  String uniqueId, typeDelivery, remark, orderStatus, paymentType;
  int dateTime,
      isRefundable,
      totalQuantity,
      totalOrderQuantity,
      totalExtraOrderQuantity;
  double totalAmount,
      totalOrderAmount,
      extraOrderTotalAmount,
      totalOtherChargeAmount;
  OrderPersonDetail orderPersonDetail;
  DeliveryPersonDetail deliveryPersonDetail;
  List<OtherCharge> otherChargeList;
  List<ExtraOrder> extraOrderList;
  List<Order> orderList;

  PastOrderDetail(
      {this.uniqueId,
      this.typeDelivery,
      this.isRefundable,
      this.remark,
      this.orderStatus,
      this.paymentType,
      this.totalQuantity,
      this.totalOrderQuantity,
      this.totalExtraOrderQuantity,
      this.dateTime,
      this.totalAmount,
      this.totalOrderAmount,
      this.extraOrderTotalAmount,
      this.totalOtherChargeAmount,
      this.orderPersonDetail,
      this.deliveryPersonDetail,
      this.otherChargeList,
      this.extraOrderList,
      this.orderList});
}

class OtherCharge {
  String name;
  double chargeAmount;

  OtherCharge({this.name, this.chargeAmount});
}

class Order {
  String uniqueId, recipeName;
  int quantity, isVegNonVeg;
  double price;
  int orderType;

  Order(
      {this.uniqueId,
      this.recipeName,
      this.quantity,
      this.isVegNonVeg,
      this.price,
      this.orderType});
}

class ExtraOrder {
  String extraOrderName;
  double price;
  int quantity;

  ExtraOrder({this.extraOrderName, this.quantity, this.price});
}

class OrderPersonDetail {
  String name, email, address;
  int mobile;
  double latitude, longitude;

  OrderPersonDetail({this.name, this.email, this.mobile, this.address});
}

class DeliveryPersonDetail {
  String uniqueId, name;
  int arrivingDateTime, mobileNo, otp;

  DeliveryPersonDetail(
      {this.uniqueId,
      this.name,
      this.arrivingDateTime,
      this.mobileNo,
      this.otp});
}
