import 'package:flutter/material.dart';
import '../../model/order/order.dart';
import '../../resource/colors.dart';
import '../../resource/images.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';
import '../../utils/extensions.dart';

class DeliveryPersonInformation extends StatelessWidget {
  final DeliveryPersonDetail deliveryPersonDetail;

  DeliveryPersonInformation({this.deliveryPersonDetail});
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      SizedBox(height: 5),
      Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: borderDeliveryPersonInformationColor, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          padding: EdgeInsets.all(10),
          child: Row(children: [
            Image.asset(deliveryBoyImage, scale: 4),
            SizedBox(width: 10),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(deliveryPersonDetail.name.value,
                      style: deliveryPersonNameStyle),
                  Wrap(children: [
                    Text(
                        '$deliveryBoyArrivingIn ${deliveryPersonDetail.arrivingDateTime.value.dateTimeyyyyMMddhhmma()}',
                        style: arrivingMinuteStyle)
                  ])
                ])),
            GestureDetector(
                child: Image.asset(callImage, scale: 4),
                onTap: () => '${deliveryPersonDetail.mobileNo.value}'.mobileCalling())
          ])),
      SizedBox(height: 5)
    ]);
  }
}
