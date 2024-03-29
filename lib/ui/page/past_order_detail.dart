import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../model/past_order_detail/past_order_detail.dart';
import '../../resource/api.dart';
import '../../resource/colors.dart';
import '../../resource/images.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';
import '../../utils/extensions.dart';

class PastOrderDetailPage extends StatelessWidget {
  const PastOrderDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          backgroundColor: appBarColor,
          elevation: appBarElevation,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(backIcon, size: 18, color: appBarTitleColor)),
          title: Text(titlePastOrderDetail, style: appBarTitleStyle)),
      body: Obx(() => ListView(children: [
            Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Personal Details',
                          style: pastOrderDetailLabelStyle),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                PastOrderDetailController.to
                                    .rxPastOrderDetail.value.uniqueId,
                                style: idStyle),
                            Text(
                                '${ PastOrderDetailController.to.rxPastOrderDetail.value.dateTime.dateTimeyyyyMMddhhmma()}',
                                style: timeCalculationStyle),
                          ]),
                      Row(children: [
                        Expanded(
                            flex: 1,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      PastOrderDetailController.to
                                          .rxPastOrderDetail
                                          .value
                                          .orderPersonDetail
                                          .name,
                                      style: pastOrderNameStyle),
                                  Text(
                                      PastOrderDetailController.to
                                          .rxPastOrderDetail
                                          .value
                                          .orderPersonDetail
                                          .email,
                                      style: pastOrderEmailStyle),
                                  Text(
                                      PastOrderDetailController.to
                                          .rxPastOrderDetail
                                          .value
                                          .orderPersonDetail
                                          .address,
                                      style: pastOrderAddressStyle)
                                ])),
                        GestureDetector(
                            child: Image.asset(callImage, scale: 4),
                            onTap: () =>
                                '${ PastOrderDetailController.to.rxPastOrderDetail.value.orderPersonDetail.mobile}'
                                    .mobileCalling())
                      ]),
                      const SizedBox(height: 10),
                      Text('Delivery Detail', style: pastOrderDetailLabelStyle),
                      _deliveryDetail( PastOrderDetailController.to
                          .rxPastOrderDetail.value.deliveryPersonDetail),
                      const SizedBox(height: 10),
                      Text('Order Detail', style: pastOrderDetailLabelStyle),
                      orderDetail( PastOrderDetailController.to
                          .rxPastOrderDetail.value.orderList),
                      orderTotal(
                          PastOrderDetailController.to
                              .rxPastOrderDetail.value.totalOrderQuantity,
                          PastOrderDetailController.to
                              .rxPastOrderDetail.value.totalOrderAmount),
                      const SizedBox(height: 10),
                      Text('Extra Order Detail',
                          style: pastOrderDetailLabelStyle),
                      _extraOrderDetail( PastOrderDetailController.to
                          .rxPastOrderDetail.value.extraOrderList),
                      orderTotal(
                          PastOrderDetailController.to
                              .rxPastOrderDetail.value.totalExtraOrderQuantity,
                          PastOrderDetailController.to
                              .rxPastOrderDetail.value.extraOrderTotalAmount),
                      const SizedBox(height: 10),
                      Text('Payment Detail', style: pastOrderDetailLabelStyle),
                      _otherCharge( PastOrderDetailController.to
                          .rxPastOrderDetail.value.otherChargeList),
                      paymentDetail(
                          PastOrderDetailController.to
                              .rxPastOrderDetail.value.totalQuantity,
                          PastOrderDetailController.to
                              .rxPastOrderDetail.value.totalAmount),
                      const SizedBox(height: 10),
                      Text('Order', style: pastOrderDetailLabelStyle),
                      _orderStatus(
                          PastOrderDetailController.to
                              .rxPastOrderDetail.value.typeDelivery,
                          PastOrderDetailController.to
                              .rxPastOrderDetail.value.orderStatus,
                          PastOrderDetailController.to
                              .rxPastOrderDetail.value.isRefundable,
                          PastOrderDetailController.to
                              .rxPastOrderDetail.value.remark)
                    ]))
          ])));

  _orderStatus(String typeDelivery, String orderStatus, int isRefundable,
          String remark) =>
      Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(typeDelivery, style: deliveryType),
          Text(orderStatus,
              style: pastOrderStatusStyle(
                  orderStatus.toLowerCase().pastOrderColor()))
        ]),
        isRefundable == null
            ? Container()
            : Text(refundable, style: pastOrderRefundableStyle),
        remark == null
            ? Container()
            : Row(children: [
                Text(remarkItem, style: pastOrderRemarkStyle),
                const SizedBox(width: 5),
                Text(remark, style: pastOrderRemarkCommentStyle)
              ])
      ]);

  _otherCharge(List<OtherCharge> otherChargeList) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: otherChargeList
          .map((item) => Column(children: [
                Row(children: [
                  Flexible(
                      flex: 3500,
                      child: Row(
                          children: [Text(item.name, style: menuNameStyle)])),
                  Flexible(flex: 600, child: Container()),
                  Flexible(
                      flex: 1100,
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Text('$rsSymbol ${item.chargeAmount}',
                              style: menuPriceStyle)))
                ]),
                const SizedBox(height: 3)
              ]))
          .toList());

  paymentDetail(int totalQuantity, double totalAmount) => Column(children: [
        Divider(color: Colors.grey.withOpacity(0.2)),
        Row(children: [
          Flexible(
              flex: 3500,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Text('Paid', style: paymentPaidStatusStyle),
                      const SizedBox(width: 3),
                      Text('($codPaymentType)', style: paymentCollectStyle)
                    ]),
                    Row(children: [
                      Text(labelTotal, style: totalQuantityStyle),
                      const SizedBox(width: 3),
                    ])
                  ])),
          Flexible(
              flex: 600,
              child: Row(children: [
                Text(quantitySymbol, style: quantitySymbolStyle),
                Text('$totalQuantity', style: quantityStyle)
              ])),
          Flexible(
              flex: 1100,
              child: Align(
                  alignment: Alignment.topRight,
                  child: Text('$rsSymbol ${(totalAmount).roundToDouble()}',
                      style: totalAmountStyle)))
        ])
      ]);

  orderTotal(int quantity, double totalAmount) => Column(children: [
        Divider(color: Colors.grey.withOpacity(0.2)),
        Row(children: [
          Flexible(
              flex: 3500,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Row(children: [
                  Text(labelTotal, style: totalQuantityStyle),
                  const SizedBox(width: 3),
                ])
              ])),
          Flexible(
              flex: 600,
              child: Row(children: [
                Text(quantitySymbol, style: quantitySymbolStyle),
                Text('$quantity', style: quantityStyle)
              ])),
          Flexible(
              flex: 1100,
              child: Align(
                  alignment: Alignment.topRight,
                  child: Text('$rsSymbol ${(totalAmount).roundToDouble()}',
                      style: totalAmountStyle)))
        ])
      ]);

  orderDetail(List<Order> orderList) => Column(
      children: orderList
          .map((item) => Column(children: [
                Row(children: [
                  Flexible(
                      flex: 3500,
                      child: Row(children: [
                        Container(
                            margin: const EdgeInsets.only(bottom: 3),
                            child: Image.asset(
                                item.isVegNonVeg == vegIcon
                                    ? foodVegImage
                                    : foodNonVegImage,
                                height: 12,
                                width: 12)),
                        const SizedBox(width: 5),
                        Text(item.recipeName, style: menuNameStyle),
                        const SizedBox(width: 5),
                        Text(
                            1 == fullOrderTypeApi
                                ? fullOrderType
                                : halfOrderType,
                            style: orderTypeStyle)
                      ])),
                  Flexible(
                      flex: 600,
                      child: Row(children: [
                        Text(quantitySymbol, style: quantitySymbolStyle),
                        Text('${item.quantity}', style: quantityStyle)
                      ])),
                  Flexible(
                      flex: 1100,
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Text('$rsSymbol ${item.price * item.quantity}',
                              style: menuPriceStyle)))
                ]),
                const SizedBox(height: 3)
              ]))
          .toList());

  _extraOrderDetail(List<ExtraOrder> extraOrderList) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: extraOrderList
          .map((item) => Column(children: [
                Row(children: [
                  Flexible(
                      flex: 3500,
                      child: Row(children: [
                        Text(item.extraOrderName, style: menuNameStyle)
                      ])),
                  Flexible(
                      flex: 600,
                      child: Row(children: [
                        Text(quantitySymbol, style: quantitySymbolStyle),
                        Text('${item.quantity}', style: quantityStyle)
                      ])),
                  Flexible(
                      flex: 1100,
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Text('$rsSymbol ${item.price * item.quantity}',
                              style: menuPriceStyle)))
                ]),
                const SizedBox(height: 3)
              ]))
          .toList());

  _deliveryDetail(DeliveryPersonDetail deliveryPersonDetail) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            Image.asset(deliveryBoyImage, scale: 4),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(deliveryPersonDetail.name, style: deliveryPersonNameStyle),
              Text(deliveryPersonDetail.arrivingDateTime.dateTimeyyyyMMddhhmma(),
                  style: timeCalculationStyle)
            ])
          ]),
          GestureDetector(
              child: Image.asset(callImage, scale: 4),
              onTap: () => '${deliveryPersonDetail.mobileNo}'.mobileCalling())
        ])
      ]);
}
