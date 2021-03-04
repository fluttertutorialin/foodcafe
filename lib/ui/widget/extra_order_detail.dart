import 'package:flutter/material.dart';
import 'package:foodcafe/model/order/order.dart';
import 'package:foodcafe/resource/style.dart';
import 'package:foodcafe/resource/value.dart';

class ExtraOrderDetail extends StatelessWidget {
  final double extraTotalAmount;
  final List<ExtraOrder> extraOrderList;
  ExtraOrderDetail({this.extraTotalAmount, this.extraOrderList});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 1),
      Text('$labelExtraOrder' ' items', style: preparationTimeStyle),
      Row(children: [
        Expanded(
            flex: 1,
            child: Row(
                children: extraOrderList
                    .asMap()
                    .map((index, item) => MapEntry(
                        index,
                        Wrap(children: [
                          Text('${item.extraOrderName} - ',
                              style: menuNameStyle),
                          Text(
                              '${item.quantity}${extraOrderList.length - 1 == index ? '' : ','} ',
                              style: menuNameStyle)
                        ])))
                    .values
                    .toList())),
        Text('$rsSymbol $extraTotalAmount', style: menuPriceStyle)
      ]),
      SizedBox(height: 1),
    ]);
  }
}
