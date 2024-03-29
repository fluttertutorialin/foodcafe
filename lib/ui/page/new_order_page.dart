import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../resource/colors.dart';
import '../../resource/images.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';
import '../../ui/widget/extra_order_detail.dart';
import '../../ui/widget/order_detail.dart';
import '../../ui/widget/order_status.dart';
import '../../ui/widget/preparation_time.dart';
import '../../utils/state_status.dart';
import '../../utils/extensions.dart';

class NewOrderPage extends StatelessWidget {
  final _infoKey = <GlobalKey>[];
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  NewOrderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: appBarColor,
            elevation: appBarElevation,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(backIcon, size: 18, color: appBarTitleColor)),
            title: Text(titleNewOrder, style: appBarTitleStyle)),
        body: Obx(() => RefreshIndicator(
            key: _refreshKey,
            backgroundColor: refreshBackgroundColor,
            color: refreshColor,
            onRefresh: () async {
              if (NewOrderController.to.refreshStatus.value ==
                  RefreshStatus.success) {
                _refreshKey.currentState.show(atTop: false);
              }

              if (NewOrderController.to.refreshStatus.value ==
                  RefreshStatus.initial) {
                _refreshKey.currentState.show();
                NewOrderController.to.fetchNewOrder(isRefresh: true);
              }
            },
            child: listView(
                stateStatus: NewOrderController.to.stateStatus.value,
                dataNotFoundMessage: dataNotNewOrderMessage,
                length: NewOrderController.to.rxNewOrderList.length,
                itemBuilder: (BuildContext context, int index) {
                  var _newOrder = NewOrderController.to.rxNewOrderList[index];
                  _infoKey.add(GlobalKey(debugLabel: '$index'));
                  return Card(
                      elevation: cardViewElevation,
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OrderDetail(
                                    infoKey: _infoKey[index],
                                    orderMainList: _newOrder,
                                    orderList: _newOrder.orderList,
                                    otherChargeList: _newOrder.otherChargeList),
                                _newOrder.extraOrderList.isEmpty
                                    ? Container()
                                    : ExtraOrderDetail(
                                        extraTotalAmount:
                                            _newOrder.extraOrderTotalAmount,
                                        extraOrderList:
                                            _newOrder.extraOrderList),
                                PreparationTime(
                                    preparationTimeSelect: (value) =>
                                        NewOrderController.to
                                            .preparationTimeSelect(
                                                _newOrder.uniqueId, value),
                                    preparationTimeMinus: (value) =>
                                        NewOrderController.to
                                            .preparationTimeMinus(
                                                _newOrder.uniqueId, value),
                                    preparationTimePlus: (value) =>
                                        NewOrderController.to
                                            .preparationTimePlus(
                                                _newOrder.uniqueId, value),
                                    preparationTimeDefault:
                                        _newOrder.preparationTimeDefault,
                                    preparationTimeList:
                                        _newOrder.preparationTimeList),
                                OrderStatus(
                                    orderStatus: acceptButton,
                                    rejectCallBack: () => NewOrderController.to
                                        .removeOrder(
                                            uniqueId: _newOrder.uniqueId,
                                            message: pendingOrderRejectMessage,
                                            isShowToast: false),
                                    orderCallBack: () => NewOrderController.to
                                        .removeOrder(
                                            uniqueId: _newOrder.uniqueId,
                                            message:
                                                pendingOrderAcceptedMessage,
                                            isShowToast: false))
                              ])));
                }))));
  }
}
