import 'package:get/get.dart';

class OrderMainList {
  String uniqueId, typeDelivery, paymentType;
  int dateTime, totalQuantity;
  double totalAmount, extraOrderTotalAmount, totalOtherChargeAmount;
  int whereToReachOrder;
  String orderStatus, remark;

  List<Order> orderList;
  List<ExtraOrder> extraOrderList;
  List<PreparationTimeList> preparationTimeList;
  PreparationTimeDefault preparationTimeDefault;
  List<OtherCharge> otherChargeList;
  DeliveryPersonDetail deliveryPersonDetail;
  OrderPersonDetail orderPersonDetail;

  OrderMainList(
      {this.uniqueId,
      this.dateTime,
      this.typeDelivery,
      this.paymentType,
      this.totalQuantity,
      this.totalAmount,
      this.extraOrderTotalAmount,
      this.totalOtherChargeAmount,
      this.orderList,
      this.extraOrderList,
      this.preparationTimeList,
      this.preparationTimeDefault,
      this.otherChargeList,
      this.deliveryPersonDetail,
      this.orderPersonDetail,
      this.whereToReachOrder,
      this.orderStatus = '',
      this.remark = ''});
}

class ExtraOrder {
  String extraOrderName;
  double price;
  int quantity;

  ExtraOrder({this.extraOrderName, this.quantity, this.price});
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

class PreparationTimeDefault {
  PreparationTimeDefault({int defaultTime, int selectTime, int isMinHour}) {
    setDefaultTime(defaultTime);
    setSelectTime(selectTime);
    setIsMinHour(isMinHour);
  }

  RxInt defaultTime = RxInt(null);
  setDefaultTime(int value) => defaultTime.value = value;

  RxInt selectTime = RxInt(0);
  setSelectTime(int value) => selectTime.value = value;

  RxInt isMinHour = RxInt(0);
  setIsMinHour(int value) => isMinHour.value = value;
}

class PreparationTimeList {
  PreparationTimeList({int time, bool isSelect}) {
    setSelect(isSelect);
    setTime(time);
  }

  RxInt time = RxInt(null);
  setTime(int value) => time.value = value;

  RxBool isSelect = RxBool(null);
  setSelect(bool value) => isSelect.value = value;
}

class DeliveryPersonDetail {
  DeliveryPersonDetail(
      {String uniqueId, String name, int arrivingDateTime, int mobileNo, bool isSelect}) {
    setUniqueId(uniqueId);
    setName(name);
    setArrivingDateTime(arrivingDateTime);
    setMobileNo(mobileNo);
    setSelect(isSelect);
  }

  RxString uniqueId = RxString('');
  setUniqueId(String value) => uniqueId.value = value;

  RxString name = RxString('');
  setName(String value) => name.value = value;

  RxInt arrivingDateTime = RxInt(0);
  setArrivingDateTime(int value) => arrivingDateTime.value = value;

  RxInt mobileNo = RxInt(0);
  setMobileNo(int value) => mobileNo.value = value;

  RxBool isSelect = RxBool(false);
  setSelect(bool value) => isSelect.value = value;
}

class OtherCharge {
  String name;
  double chargeAmount;

  OtherCharge({this.name, this.chargeAmount});
}

class OrderPersonDetail {
  String name, email, address;
  int mobile;
  double latitude, longitude;

  OrderPersonDetail({this.name, this.email, this.mobile, this.address});
}
