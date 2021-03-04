import 'package:flutter/material.dart';
import 'package:foodcafe/model/order/order.dart';
import 'package:foodcafe/resource/api.dart';
import 'package:foodcafe/resource/font.dart';
import 'package:foodcafe/resource/images.dart';
import 'package:foodcafe/resource/style.dart';
import 'package:foodcafe/resource/value.dart';
import 'popup_window.dart';
import 'package:foodcafe/utils/extensions.dart';

class OrderDetail extends StatelessWidget {
  final GlobalKey infoKey;
  final List<Order> orderList;
  final OrderMainList orderMainList;
  final List<OtherCharge> otherChargeList;

  OrderDetail(
      {this.infoKey, this.orderList, this.orderMainList, this.otherChargeList});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(orderMainList.uniqueId, style: idStyle),
        Text(orderMainList.dateTime.dateTimeyyyyMMddhhmma(), style: dateTimeStyle)
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(orderMainList.typeDelivery, style: deliveryType),
        Text(
            timeHourMinute(orderMainList.dateTime).inHours <= -1
                ? timeHourMinute(orderMainList.dateTime).inDays >= -1
                    ? '${timeHourMinute(orderMainList.dateTime).inDays} day ago'
                        .replaceFirst('-', '')
                    : '${timeHourMinute(orderMainList.dateTime).inHours} hour ago'
                        .replaceFirst('-', '')
                : '${timeHourMinute(orderMainList.dateTime).inMinutes} min ago'
                    .replaceFirst('-', ''),
            style: timeCalculationStyle)
      ]),
      SizedBox(height: 5),
      Column(
          children: orderList
              .map((item) => Row(children: [
                    Flexible(
                        flex: 3500,
                        child: Row(children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 3),
                              child: Image.asset(
                                  item.isVegNonVeg == vegIcon
                                      ? foodVegImage
                                      : foodNonVegImage,
                                  height: 12,
                                  width: 12)),
                          SizedBox(width: 5),
                          Text(item.recipeName, style: menuNameStyle),
                          SizedBox(width: 5),
                          Text(
                              item.orderType == fullOrderTypeApi
                                  ? fullOrderType
                                  : halfOrderType,
                              style: orderTypeStyle)
                        ])),
                    Flexible(
                        flex: 600,
                        child: Row(children: [
                          Text('$quantitySymbol', style: quantitySymbolStyle),
                          Text('${item.quantity}', style: quantityStyle)
                        ])),
                    Flexible(
                        flex: 1100,
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Text('$rsSymbol ${item.price}',
                                style: menuPriceStyle)))
                  ]))
              .toList()),
      SizedBox(height: 3),
      Divider(color: Colors.grey.withOpacity(0.2)),
      Row(children: [
        Flexible(
            flex: 3500,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Text(orderMainList.paymentType,
                        style: paymentPaidStatusStyle),
                    SizedBox(width: 3),
                    Text('($CODPaymentType)', style: paymentCollectStyle)
                  ]),
                  Row(children: [
                    Text(labelTotal, style: totalQuantityStyle),
                    SizedBox(width: 3),
                    GestureDetector(
                        key: infoKey,
                        onTap: () {
                          RenderBox renderBox =
                              infoKey.currentContext.findRenderObject();
                          Offset offset = renderBox.localToGlobal(Offset.zero);
                          showPopupWindow(
                              context: context,
                              fullWidth: false,
                              //isShowBg:true,
                              position: RelativeRect.fromLTRB(
                                  0, offset.dy + renderBox.size.height, 0, 0),
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(children: [
                                    Column(
                                        children: otherChargeList
                                            .map((item) => Column(children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(item.name,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    regularFont)),
                                                        Text(
                                                            '$rsSymbol ${item.chargeAmount}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    regularFont))
                                                      ])
                                                ]))
                                            .toList()),
                                    Divider(),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(labelTotalAmount,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontFamily: mediumFont)),
                                          Text(
                                              '$rsSymbol ${orderMainList.totalOtherChargeAmount}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: mediumFont))
                                        ])
                                  ])));
                        },
                        child: Image.asset(informationImage,
                            height: 15, width: 15)),
                    SizedBox(width: 3)
                  ])
                ])),
        Flexible(
            flex: 600,
            child: Row(children: [
              Text('$quantitySymbol', style: quantitySymbolStyle),
              Text('${orderMainList.totalQuantity.round()}',
                  style: quantityStyle)
            ])),
        Flexible(
            flex: 1100,
            child: Align(
                alignment: Alignment.topRight,
                child: Text(
                    '$rsSymbol ${(orderMainList.totalAmount + orderMainList.totalOtherChargeAmount).roundToDouble()}',
                    style: totalAmountStyle)))
      ])
    ]);
  }

  Duration timeHourMinute(int microsecondsSinceEpoch) {
    DateTime fromDateTime =
        new DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
    DateTime nowDateTime = new DateTime.fromMicrosecondsSinceEpoch(
        DateTime.now().microsecondsSinceEpoch);
    return fromDateTime.difference(nowDateTime);
  }
}
