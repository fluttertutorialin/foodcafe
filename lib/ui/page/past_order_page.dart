import 'package:flutter/material.dart';
import 'package:foodcafe/controller/controller.dart';
import 'package:foodcafe/resource/colors.dart';
import 'package:foodcafe/resource/routes.dart';
import 'package:foodcafe/ui/widget/past_order_widget.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';
import 'package:foodcafe/utils/extensions.dart';

class PastOrderPage extends StatelessWidget {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => RefreshIndicator(
        key: _refreshKey,
        backgroundColor: refreshBackgroundColor,
        color: refreshColor,
        onRefresh: () async {
          if (PastOrderController.to.refreshStatus.value ==
              RefreshStatus.SUCCESS) {
            _refreshKey.currentState.dispose();
          }

          if (PastOrderController.to.refreshStatus.value ==
              RefreshStatus.INITIAL) {
            _refreshKey.currentState.show();
            PastOrderController.to.fetchPastOrder(isRefresh: true);
          }
        },
        child: PastOrderController.to.stateStatus.value == StateStatus.LOADING
            ? circleProgressIndicator()
            : PastOrderController.to.pastOrder.value.pastOrderList.isEmpty
                ? emptyWidget()
                : ListView.builder(
                    itemCount: PastOrderController
                        .to.pastOrder.value.pastOrderList.length,
                    itemBuilder: (context, index) {
                      var _pastOrder = PastOrderController
                          .to.pastOrder.value.pastOrderList[index];
                      return GestureDetector(
                          onTap: () => Get.toNamed(pastOrderDetailRoute),
                          child: PastOrderWidget(
                              uniqueId: _pastOrder.uniqueId,
                              dateTime:
                                  _pastOrder.dateTime.dateTimeyyyyMMddhhmma(),
                              orderTotalAmount: _pastOrder.orderTotalAmount,
                              typeDelivery: _pastOrder.typeDelivery,
                              orderStatus: _pastOrder.orderStatus,
                              paymentType: _pastOrder.paymentType,
                              remark: _pastOrder.remark,
                              isRefundable: _pastOrder.isRefundable,
                              selectOrderStatus: _pastOrder.orderStatus));
                    })));
  }
}
