class ReportResponse {
  int todayPendingOrderTotal, todayAcceptedOrderTotal, todayReadyOrderTotal, todayDispatchedOrderTotal;
  List<ReportPastOrder> reportPastOrderList;

  ReportResponse(
      {this.todayPendingOrderTotal,
      this.todayAcceptedOrderTotal,
      this.todayReadyOrderTotal,
      this.todayDispatchedOrderTotal,
      this.reportPastOrderList});
}

class ReportPastOrder {
  String title, message;
  int total, success;

  ReportPastOrder({this.title, this.message, this.total, this.success});
}
