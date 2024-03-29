import 'package:get/get.dart';
import '../model/report/report_response.dart';
import '../utils/state_status.dart';

class ReportController extends GetxController {
  static ReportController get to => Get.find();
  var stateStatus = Rx<StateStatus>(StateStatus.initial);

  var rxReportPastOrderList = RxList<ReportPastOrder>([]);
  var todayPendingOrderTotal = RxInt(0);
  var todayAcceptedOrderTotal = RxInt(0);
  var todayReadyOrderTotal = RxInt(0);
  var todayDispatchedOrderTotal = RxInt(0);

  @override
  onInit() {
    super.onInit();
    fetchReport();
  }

  Future<void> fetchReport({bool isRefresh = false}) async {
    stateStatus.value = StateStatus.loading;

    var reportResponse = ReportResponse(
        todayPendingOrderTotal: 1,
        todayAcceptedOrderTotal: 2,
        todayDispatchedOrderTotal: 3,
        todayReadyOrderTotal: 4,
        reportPastOrderList: [
          ReportPastOrder(
              title: 'Pending', message: 'Order is not assign.', success: 100),
          ReportPastOrder(
              title: 'Accepted', message: 'Order is assign.', success: 100),
          ReportPastOrder(
              title: 'Ready', message: 'Order is dispatch.', success: 100),
          ReportPastOrder(
              title: 'Dispatched',
              message: 'Order sent to delivery person.',
              success: 100),
          ReportPastOrder(
              title: 'Return order',
              message: 'Order is return some of issues of customer.',
              success: 1)
        ]);

    await Future.delayed(const Duration(seconds: 2));
    stateStatus.value = StateStatus.success;

    todayPendingOrderTotal.value = reportResponse.todayPendingOrderTotal;
    todayAcceptedOrderTotal.value = reportResponse.todayAcceptedOrderTotal;
    todayReadyOrderTotal.value = reportResponse.todayReadyOrderTotal;
    todayDispatchedOrderTotal.value = reportResponse.todayDispatchedOrderTotal;
    rxReportPastOrderList.assignAll(reportResponse.reportPastOrderList.obs);
  }
}
