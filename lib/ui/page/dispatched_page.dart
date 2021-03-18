import 'package:flutter/material.dart';
import '../../controller/controller.dart';
import '../../resource/colors.dart';
import '../../resource/value.dart';
import '../../ui/widget/delivery_person_information.dart';
import '../../ui/widget/extra_order_detail.dart';
import '../../ui/widget/order_address.dart';
import '../../ui/widget/order_detail.dart';
import '../../ui/widget/order_status.dart';
import '../../utils/state_status.dart';
import 'package:get/get.dart';
import '../../utils/extensions.dart';

class DispatchedPage extends StatelessWidget {
  final _infoKey = <GlobalKey>[];
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetX(
            initState: (_) {
              HomeController.to.searchController.clear();
              HomeController.to.acceptedController.search.value = '';
              DispatchedController.to.fetchDispatched();
            },
            init: DispatchedController(),
            builder: (_) => RefreshIndicator(
                key: _refreshKey,
                backgroundColor: refreshBackgroundColor,
                color: refreshColor,
                onRefresh: () async {
                  if (DispatchedController.to.refreshStatus.value ==
                      RefreshStatus.SUCCESS) {
                    _refreshKey.currentState.dispose();
                  }

                  if (DispatchedController.to.refreshStatus.value ==
                      RefreshStatus.INITIAL) {
                    _refreshKey.currentState.show();
                    DispatchedController.to.fetchDispatched(isRefresh: true);
                  }
                },
                child: listView(
                    stateStatus: DispatchedController.to.stateStatus.value,
                    dataNotFoundMessage: dataNotDispatchedMessage,
                    length: DispatchedController.to.rxDispatchedList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var _dispatched =
                          DispatchedController.to.rxDispatchedList[index];
                      _infoKey.add(GlobalKey(debugLabel: '$index'));

                      return Obx(() => Visibility(
                          visible: DispatchedController.to
                              .findUniqueId(_dispatched.uniqueId),
                          child: Card(
                              elevation: cardViewElevation,
                              child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        OrderDetail(
                                            infoKey: _infoKey[index],
                                            orderMainList: _dispatched,
                                            orderList: _dispatched.orderList,
                                            otherChargeList:
                                                _dispatched.otherChargeList),
                                        _dispatched.extraOrderList.isEmpty
                                            ? Container()
                                            : ExtraOrderDetail(
                                                extraTotalAmount: _dispatched
                                                    .extraOrderTotalAmount,
                                                extraOrderList:
                                                    _dispatched.extraOrderList),
                                        DeliveryPersonInformation(
                                            deliveryPersonDetail: _dispatched
                                                .deliveryPersonDetail),
                                        OrderAddress(
                                            orderPersonDetail:
                                                _dispatched.orderPersonDetail),
                                        SizedBox(height: 10),
                                        OrderStatus(
                                            orderStatus: settleOrderButton,
                                            rejectCallBack: () =>
                                                DispatchedController.to.removeOrder(
                                                    uniqueId:
                                                        _dispatched.uniqueId,
                                                    message:
                                                        readyOrderRejectMessage,
                                                    isShowToast: true),
                                            orderCallBack: () =>
                                                DispatchedController.to.removeOrder(
                                                    uniqueId:
                                                        _dispatched.uniqueId,
                                                    message:
                                                        pendingOrderAcceptedMessage,
                                                    isShowToast: true))
                                      ])))));
                    }))));
  }
}
