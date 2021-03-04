import 'package:flutter/material.dart';
import 'package:foodcafe/model/order/order.dart';
import 'package:foodcafe/resource/images.dart';
import 'package:foodcafe/resource/style.dart';

class OrderAddress extends StatelessWidget {
  final OrderPersonDetail orderPersonDetail;

  OrderAddress({@required this.orderPersonDetail});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
          backgroundColor: Colors.grey.withOpacity(0.1),
          backgroundImage: ExactAssetImage(profileImage)),
      SizedBox(width: 10),
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(orderPersonDetail.name, style: orderUserNameStyle),
        SizedBox(height: 1),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: Text(orderPersonDetail.address,
                  style: orderUserAddressStyle)),
          SizedBox(width: 5),
          Text('30 KM', style: orderUserKMStyle)
        ])
      ]))
    ]);
  }
}
