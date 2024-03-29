import 'package:flutter/material.dart';
import 'popup_window.dart';
import '../../model/order/order.dart';
import '../../resource/api.dart';
import '../../resource/font.dart';
import '../../resource/images.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';
import '../../utils/extensions.dart';

class OrderDetail extends StatelessWidget {
  final GlobalKey infoKey;
  final List<Order> orderList;
  final OrderMainList orderMainList;
  final List<OtherCharge> otherChargeList;

  const OrderDetail(
      {Key key, this.infoKey, this.orderList, this.orderMainList, this.otherChargeList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(orderMainList.uniqueId, style: idStyle),
        Text(orderMainList.dateTime.dateTimeyyyyMMddhhmma(),
            style: dateTimeStyle)
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
      const SizedBox(height: 5),
      Column(
          children: orderList
              .map((item) => Row(children: [
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
                              item.orderType == fullOrderTypeApi
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
                            child: Text('$rsSymbol ${item.price}',
                                style: menuPriceStyle)))
                  ]))
              .toList()),
      const SizedBox(height: 3),
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
                    const SizedBox(width: 3),
                    Text('($codPaymentType)', style: paymentCollectStyle)
                  ]),
                  Row(children: [
                    Text(labelTotal, style: totalQuantityStyle),
                    const SizedBox(width: 3),
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
                                  padding: const EdgeInsets.all(10),
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
                                                            style: const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    regularFont)),
                                                        Text(
                                                            '$rsSymbol ${item.chargeAmount}',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    regularFont))
                                                      ])
                                                ]))
                                            .toList()),
                                    const Divider(),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(labelTotalAmount,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontFamily: mediumFont)),
                                          Text(
                                              '$rsSymbol ${orderMainList.totalOtherChargeAmount}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: mediumFont))
                                        ])
                                  ])));
                        },
                        child: Image.asset(informationImage,
                            height: 15, width: 15)),
                    const SizedBox(width: 3)
                  ])
                ])),
        Flexible(
            flex: 600,
            child: Row(children: [
              Text(quantitySymbol, style: quantitySymbolStyle),
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
        DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
    DateTime nowDateTime = DateTime.fromMicrosecondsSinceEpoch(
        DateTime.now().microsecondsSinceEpoch);
    return fromDateTime.difference(nowDateTime);
  }
}
