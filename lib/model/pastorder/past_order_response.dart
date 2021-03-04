class PastOrderResponse {
  List<PastOrder> pastOrderList;
  PastOrderResponse({this.pastOrderList});
}


class PastOrder {
  String uniqueId, typeDelivery, orderStatus, paymentType, remark;
  double orderTotalAmount;
  int dateTime, isRefundable, orderStatusId;

  PastOrder(
      {this.uniqueId,
      this.orderTotalAmount = 0.0,
      this.dateTime,
      this.typeDelivery,
      this.orderStatus,
      this.paymentType,
      this.remark,
      this.isRefundable,
      this.orderStatusId});
}
