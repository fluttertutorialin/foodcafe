import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../resource/api.dart';
import '../../resource/colors.dart';
import '../../resource/routes.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';
import '../widget/delivery_person_information.dart';
import '../widget/extra_order_detail.dart';
import '../widget/order_address.dart';
import '../widget/order_detail.dart';
import '../widget/order_status.dart';
import '../widget/preparation_time.dart';
import '../widget/text_field_search.dart';
import '../../utils/state_status.dart';
import '../../utils/extensions.dart';

class AllFindPage extends StatelessWidget {
  final _infoKey = <GlobalKey>[];
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  AllFindPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: appBarColor,
            elevation: appBarElevation,
            titleSpacing: 0.0,
            automaticallyImplyLeading: false,
            title: TextFieldSearch(
                hintText: hintAllFind,
                isPrefixIconVisible: true,
                isSuffixIconVisible:
                    AllFindController.to.isVisibleSearchClearIcon,
                callBackPrefix: () {
                  FocusScope.of(context).requestFocus(FocusNode());

                  HomeController.to
                      .searchClear(HomeController.to.currentPageIndex.value);
                  HomeController.to.searchController.clear();

                  Get.back();
                },
                textEditingController: AllFindController.to.searchController,
                callBackSearch: () {
                  ///HIDE KEYBOARD
                  if (AllFindController.to.search.value.isNotEmpty) {
                    var _currentFocus = FocusScope.of(context);
                    if (!_currentFocus.hasPrimaryFocus) {
                      _currentFocus.unfocus();
                    }

                    AllFindController.to.fetchAllFind(
                        allFind: AllFindController.to.search.value);
                  } else {
                  }
                },
                onChanged: AllFindController.to.search)),
        body: GetX(
            initState: (_) {
              AllFindController.to.search.value = '';
              AllFindController.to.searchController.clear();
              AllFindController.to.rxAllFindList.clear();
              AllFindController.to.stateStatus = StateStatus.initial.obs;
            },
            init: AllFindController(),
            builder: (_) => RefreshIndicator(
                key: _refreshKey,
                backgroundColor: refreshBackgroundColor,
                color: refreshColor,
                onRefresh: () async {
                  if (AllFindController.to.search.value.isNotEmpty) {
                    if (AllFindController.to.refreshStatus.value ==
                        RefreshStatus.initial) {
                      _refreshKey.currentState.show();
                      AllFindController.to.fetchAllFind(isRefresh: true);
                    }
                  }
                },
                child: listView(
                    stateStatus: AllFindController.to.stateStatus.value,
                    dataNotFoundMessage: '',
                    length: AllFindController.to.rxAllFindList.length,
                    itemBuilder: (BuildContext context, int index) {
                      _infoKey.add(GlobalKey(debugLabel: '$index'));
                      var _allFind = AllFindController.to.rxAllFindList[index];
                      return GestureDetector(
                          onTap: () {
                            if (_allFind.orderStatus != '') {
                              Get.toNamed(pastOrderDetailRoute);
                            }
                          },
                          child: Card(
                              elevation: cardViewElevation,
                              child: Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Visibility(
                                            visible: _allFind
                                                        .whereToReachOrder ==
                                                    whereToReachOrderPending ||
                                                _allFind.whereToReachOrder ==
                                                    whereToReachOrderAccepted ||
                                                _allFind.whereToReachOrder ==
                                                    whereToReachOrderReady ||
                                                _allFind.whereToReachOrder ==
                                                    whereToReachOrderDispatched,
                                            child: Column(children: [
                                              OrderDetail(
                                                  infoKey: _infoKey[index],
                                                  orderMainList: _allFind,
                                                  orderList: _allFind.orderList,
                                                  otherChargeList:
                                                      _allFind.otherChargeList),
                                              _allFind.extraOrderList.isEmpty
                                                  ? Container()
                                                  : ExtraOrderDetail(
                                                      extraTotalAmount: _allFind
                                                          .extraOrderTotalAmount,
                                                      extraOrderList: _allFind
                                                          .extraOrderList),
                                            ])),
                                        Visibility(
                                            visible: _allFind.orderStatus != '',
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(_allFind.uniqueId,
                                                            style: idStyle),
                                                        Text(
                                                            _allFind.dateTime
                                                                .dateTimeyyyyMMddhhmma(),
                                                            style:
                                                                dateTimeStyle)
                                                      ]),
                                                  Text(
                                                      _allFind.orderPersonDetail
                                                          .name,
                                                      style:
                                                          pastOrderNameStyle),
                                                  Text(
                                                      _allFind.orderPersonDetail
                                                          .email,
                                                      style:
                                                          pastOrderEmailStyle),
                                                  Text(
                                                      _allFind.orderPersonDetail
                                                          .address,
                                                      style:
                                                          pastOrderAddressStyle),
                                                  const SizedBox(height: 5),
                                                  Text(_allFind.typeDelivery,
                                                      style: deliveryType),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(children: [
                                                          Text(
                                                              _allFind
                                                                  .paymentType,
                                                              style:
                                                                  paymentPaidStatusStyle),
                                                          const SizedBox(width: 3),
                                                          Text(
                                                              '($codPaymentType)',
                                                              style:
                                                                  paymentCollectStyle)
                                                        ]),
                                                        Text(
                                                            '$rsSymbol ${_allFind.totalAmount}.',
                                                            style:
                                                                totalAmountStyle)
                                                      ]),
                                                ])),
                                        Visibility(
                                          visible: _allFind.whereToReachOrder ==
                                              whereToReachOrderPending,
                                          child: PreparationTime(
                                              preparationTimeSelect: (value) =>
                                                  AllFindController.to
                                                      .preparationTimeSelect(
                                                          _allFind.uniqueId,
                                                          value),
                                              preparationTimeMinus: (value) =>
                                                  AllFindController.to.preparationTimeMinus(
                                                      _allFind.uniqueId, value),
                                              preparationTimePlus: (value) =>
                                                  AllFindController.to.preparationTimePlus(
                                                      _allFind.uniqueId, value),
                                              preparationTimeDefault: _allFind
                                                  .preparationTimeDefault,
                                              preparationTimeList:
                                                  _allFind.preparationTimeList),
                                        ),
                                        Visibility(
                                            visible: _allFind
                                                        .whereToReachOrder ==
                                                    whereToReachOrderReady ||
                                                _allFind.whereToReachOrder ==
                                                    whereToReachOrderDispatched ||
                                                _allFind.orderStatus ==
                                                    'Completed',
                                            child: DeliveryPersonInformation(
                                                deliveryPersonDetail: _allFind
                                                    .deliveryPersonDetail)),
                                        Obx(() => Visibility(
                                            visible: _allFind
                                                    .deliveryPersonDetail
                                                    .isSelect
                                                    .value &&
                                                _allFind.whereToReachOrder ==
                                                    whereToReachOrderAccepted,
                                            child: DeliveryPersonInformation(
                                                deliveryPersonDetail: _allFind
                                                    .deliveryPersonDetail))),
                                        Visibility(
                                            visible: _allFind
                                                        .whereToReachOrder ==
                                                    whereToReachOrderPending ||
                                                _allFind.whereToReachOrder ==
                                                    whereToReachOrderAccepted ||
                                                _allFind.whereToReachOrder ==
                                                    whereToReachOrderReady ||
                                                _allFind.whereToReachOrder ==
                                                    whereToReachOrderDispatched,
                                            child: Column(children: [
                                              OrderAddress(
                                                  orderPersonDetail: _allFind
                                                      .orderPersonDetail),
                                              const SizedBox(height: 10)
                                            ])),
                                        Visibility(
                                            visible:
                                                _allFind.whereToReachOrder !=
                                                    null,
                                            child: OrderStatus(
                                                uniqueId: _allFind.uniqueId,
                                                orderStatus: AllFindController.to
                                                    .orderStatus(_allFind
                                                        .whereToReachOrder),
                                                rejectCallBack: () =>
                                                    AllFindController.to.removeOrder(
                                                        _allFind.uniqueId,
                                                        _allFind
                                                            .whereToReachOrder),
                                                orderCallBack: () =>
                                                    AllFindController.to
                                                        .removeOrder(
                                                            _allFind.uniqueId,
                                                            _allFind
                                                                .whereToReachOrder))),
                                        Visibility(
                                            visible: _allFind.orderStatus != '',
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Visibility(
                                                      visible: _allFind
                                                          .remark.isNotEmpty,
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(remarkItem,
                                                                style:
                                                                    pastOrderRemarkStyle),
                                                            Text(
                                                                _allFind.remark ==
                                                                        ''
                                                                    ? ''
                                                                    : _allFind
                                                                        .remark,
                                                                style:
                                                                    pastOrderRemarkCommentStyle)
                                                          ])),
                                                  Text(_allFind.orderStatus,
                                                      style: pastOrderStatusStyle(
                                                          _allFind.orderStatus
                                                              .toLowerCase()
                                                              .pastOrderColor()))
                                                ]))
                                      ]))));
                    }))));
  }
}
