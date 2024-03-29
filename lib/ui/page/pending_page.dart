import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../resource/colors.dart';
import '../../resource/value.dart';
import '../../ui/widget/extra_order_detail.dart';
import '../../ui/widget/order_address.dart';
import '../../ui/widget/order_detail.dart';
import '../../ui/widget/order_status.dart';
import '../../ui/widget/preparation_time.dart';
import '../../utils/state_status.dart';
import '../../utils/extensions.dart';

class PendingPage extends StatelessWidget {
  final _infoKey = <GlobalKey>[];
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  PendingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetX<PendingController>(
            initState: (_) {
              HomeController.to.searchController.clear();
              HomeController.to.pendingController.search.value = '';
              PendingController.to.fetchPending();
            },
            init: PendingController(),
            builder: (_) => RefreshIndicator(
                key: _refreshKey,
                backgroundColor: refreshBackgroundColor,
                color: refreshColor,
                onRefresh: () async {
                  if (PendingController.to.refreshStatus.value ==
                      RefreshStatus.success) {
                    _refreshKey.currentState.dispose();
                  }

                  if (PendingController.to.refreshStatus.value ==
                      RefreshStatus.initial) {
                    _refreshKey.currentState.show();
                    PendingController.to.fetchPending(isRefresh: true);
                  }
                },
                child: listView(
                    stateStatus: PendingController.to.stateStatus.value,
                    dataNotFoundMessage: dataNotPendingMessage,
                    length: PendingController.to.rxPendingList.length,
                    itemBuilder: (BuildContext context, int index) {
                      _infoKey.add(GlobalKey(debugLabel: '$index'));
                      var _pending = PendingController.to.rxPendingList[index];

                      return Obx(() => Visibility(
                          visible: PendingController.to
                              .findUniqueId(_pending.uniqueId),
                          child: Card(
                              elevation: cardViewElevation,
                              child: Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        OrderDetail(
                                            infoKey: _infoKey[index],
                                            orderMainList: _pending,
                                            orderList: _pending.orderList,
                                            otherChargeList:
                                                _pending.otherChargeList),
                                        _pending.extraOrderList.isEmpty
                                            ? Container()
                                            : ExtraOrderDetail(
                                                extraTotalAmount: _pending
                                                    .extraOrderTotalAmount,
                                                extraOrderList:
                                                    _pending.extraOrderList),
                                        PreparationTime(
                                            preparationTimeSelect: (value) =>
                                                PendingController.to
                                                    .preparationTimeSelect(
                                                        _pending.uniqueId,
                                                        value),
                                            preparationTimeMinus: (value) =>
                                                PendingController.to
                                                    .preparationTimeMinus(
                                                        _pending.uniqueId,
                                                        value),
                                            preparationTimePlus: (value) =>
                                                PendingController.to
                                                    .preparationTimePlus(
                                                        _pending.uniqueId,
                                                        value),
                                            preparationTimeDefault:
                                                _pending.preparationTimeDefault,
                                            preparationTimeList:
                                                _pending.preparationTimeList),
                                        OrderAddress(
                                            orderPersonDetail:
                                                _pending.orderPersonDetail),
                                        const SizedBox(height: 10),
                                        OrderStatus(
                                            orderStatus: acceptButton,
                                            rejectCallBack: () =>
                                                PendingController.to.removeOrder(
                                                    uniqueId: _pending.uniqueId,
                                                    message:
                                                        pendingOrderRejectMessage,
                                                    isShowToast: true),
                                            orderCallBack: () =>
                                                PendingController.to.removeOrder(
                                                    uniqueId: _pending.uniqueId,
                                                    message:
                                                        pendingOrderAcceptedMessage,
                                                    isShowToast: true))
                                      ])))));
                    }))));
  }
}
