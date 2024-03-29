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

class ReadyPage extends StatelessWidget {
  final _infoKey = <GlobalKey>[];
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  ReadyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetX(
            initState: (_) {
              HomeController.to.searchController.clear();
              HomeController.to.acceptedController.search.value = '';
              ReadyController.to.fetchReady();
            },
            init: ReadyController(),
            builder: (_) => RefreshIndicator(
                key: _refreshKey,
                backgroundColor: refreshBackgroundColor,
                color: refreshColor,
                onRefresh: () async {
                  if (ReadyController.to.refreshStatus.value ==
                      RefreshStatus.success) {
                    _refreshKey.currentState.dispose();
                  }

                  if (ReadyController.to.refreshStatus.value ==
                      RefreshStatus.initial) {
                    _refreshKey.currentState.show();
                    ReadyController.to.fetchReady(isRefresh: true);
                  }
                },
                child: listView(
                    stateStatus: ReadyController.to.stateStatus.value,
                    dataNotFoundMessage: dataNotReadyMessage,
                    length: ReadyController.to.rxReadyList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var _ready = ReadyController.to.rxReadyList[index];
                      _infoKey.add(GlobalKey(debugLabel: '$index'));

                      return Obx(() => Visibility(
                          visible:
                              ReadyController.to.findUniqueId(_ready.uniqueId),
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
                                            orderMainList: _ready,
                                            orderList: _ready.orderList,
                                            otherChargeList:
                                                _ready.otherChargeList),
                                        _ready.extraOrderList.isEmpty
                                            ? Container()
                                            : ExtraOrderDetail(
                                                extraTotalAmount: _ready
                                                    .extraOrderTotalAmount,
                                                extraOrderList:
                                                    _ready.extraOrderList),
                                        DeliveryPersonInformation(
                                            deliveryPersonDetail:
                                                _ready.deliveryPersonDetail),
                                        OrderAddress(
                                            orderPersonDetail:
                                                _ready.orderPersonDetail),
                                        const SizedBox(height: 10),
                                        OrderStatus(
                                            rejectCallBack: () =>
                                                ReadyController.to.removeOrder(
                                                    uniqueId: _ready.uniqueId,
                                                    message:
                                                        dispatchOrderRejectMessage,
                                                    isShowToast: true),
                                            orderCallBack: () =>
                                                ReadyController.to.removeOrder(
                                                    uniqueId: _ready.uniqueId,
                                                    message:
                                                        readyOrderDispatchMessage,
                                                    isShowToast: true),
                                            orderStatus: dispatchButton,
                                            isRejectShow: true)
                                      ])))));
                    }))));
  }
}
