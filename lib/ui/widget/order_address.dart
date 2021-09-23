import 'package:flutter/material.dart';
import '../../model/order/order.dart';
import '../../resource/images.dart';
import '../../resource/style.dart';

class OrderAddress extends StatelessWidget {
  final OrderPersonDetail orderPersonDetail;

  const OrderAddress({Key key, @required this.orderPersonDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
          backgroundColor: Colors.grey.withOpacity(0.1),
          backgroundImage: const ExactAssetImage(profileImage)),
      const SizedBox(width: 10),
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(orderPersonDetail.name, style: orderUserNameStyle),
        const SizedBox(height: 1),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: Text(orderPersonDetail.address,
                  style: orderUserAddressStyle)),
          const SizedBox(width: 5),
          Text('30 KM', style: orderUserKMStyle)
        ])
      ]))
    ]);
  }
}
