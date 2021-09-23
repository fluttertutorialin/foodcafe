import 'package:flutter/material.dart';
import '../../model/order/order.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';

class ExtraOrderDetail extends StatelessWidget {
  final double extraTotalAmount;
  final List<ExtraOrder> extraOrderList;
  const ExtraOrderDetail({Key key, this.extraTotalAmount, this.extraOrderList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 1),
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
      const SizedBox(height: 1),
    ]);
  }
}
