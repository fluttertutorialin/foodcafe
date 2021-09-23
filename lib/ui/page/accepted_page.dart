import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../resource/colors.dart';
import '../../resource/value.dart';
import '../../ui/widget/delivery_person_information.dart';
import '../../ui/widget/extra_order_detail.dart';
import '../../ui/widget/order_address.dart';
import '../../ui/widget/order_detail.dart';
import '../../ui/widget/order_status.dart';
import '../../utils/state_status.dart';
import '../../utils/extensions.dart';

class AcceptedPage extends StatelessWidget {
  final _infoKey = <GlobalKey>[];
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  AcceptedPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetX(
            initState: (_) {
              HomeController.to.searchController.clear();
              HomeController.to.acceptedController.search.value = '';
              AcceptedController.to.fetchAccepted();
            },
            init: AcceptedController(),
            builder: (_) => RefreshIndicator(
                key: _refreshKey,
                backgroundColor: refreshBackgroundColor,
                color: refreshColor,
                onRefresh: () async {
                  if (AcceptedController.to.refreshStatus.value ==
                      RefreshStatus.success) {
                    _refreshKey.currentState.dispose();
                  }

                  if (AcceptedController.to.refreshStatus.value ==
                      RefreshStatus.initial) {
                    _refreshKey.currentState.show();
                    AcceptedController.to.fetchAccepted(isRefresh: true);
                  }
                },
                child: listView(
                    stateStatus:  AcceptedController.to.stateStatus.value,
                    dataNotFoundMessage: dataNotAcceptedMessage,
                    length:  AcceptedController.to.rxAcceptedList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var _accepted =  AcceptedController.to.rxAcceptedList[index];
                      _infoKey.add(GlobalKey(debugLabel: '$index'));

                      return Obx(() => Visibility(
                          visible:  AcceptedController.to
                              .findUniqueId(_accepted.uniqueId),
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
                                            orderMainList: _accepted,
                                            orderList: _accepted.orderList,
                                            otherChargeList:
                                                _accepted.otherChargeList),
                                        _accepted.extraOrderList.isEmpty
                                            ? Container()
                                            : ExtraOrderDetail(
                                                extraTotalAmount: _accepted
                                                    .extraOrderTotalAmount,
                                                extraOrderList:
                                                    _accepted.extraOrderList),
                                        Obx(() => Visibility(
                                            visible: _accepted
                                                .deliveryPersonDetail
                                                .isSelect
                                                .value,
                                            child: DeliveryPersonInformation(
                                                deliveryPersonDetail: _accepted
                                                    .deliveryPersonDetail))),
                                        OrderAddress(
                                            orderPersonDetail:
                                                _accepted.orderPersonDetail),
                                        const SizedBox(height: 10),
                                        OrderStatus(
                                            uniqueId: _accepted.uniqueId,
                                            orderStatus: foodReadyButton,
                                            rejectCallBack: () =>
                                                AcceptedController.to.removeOrder(
                                                    uniqueId:
                                                        _accepted.uniqueId,
                                                    message:
                                                        acceptedOrderRejectMessage,
                                                    isShowToast: true),
                                            orderCallBack: () =>
                                                AcceptedController.to.removeOrder(
                                                    uniqueId:
                                                        _accepted.uniqueId,
                                                    message:
                                                        acceptedOrderReadyMessage,
                                                    isShowToast: true))
                                      ])))));
                    }))));
  }
}
