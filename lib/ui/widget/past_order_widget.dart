import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:foodcafe/resource/colors.dart';
import 'package:foodcafe/resource/style.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:foodcafe/utils/extensions.dart';

class PastOrderWidget extends StatelessWidget {
  final String uniqueId,
      dateTime,
      typeDelivery,
      orderStatus,
      paymentType,
      remark;
  final int isRefundable;
  final double orderTotalAmount;
  final String selectOrderStatus;

  PastOrderWidget(
      {this.uniqueId,
      this.orderTotalAmount,
      this.dateTime,
      this.typeDelivery,
      this.orderStatus,
      this.paymentType,
      this.remark,
      this.isRefundable,
      this.selectOrderStatus});

  @override
  Widget build(BuildContext context) {
    final cardRadius = 10.0;

    final _dottedLine = DottedBorder(
        color: pastOrderBorderColor,
        strokeWidth: 1,
        strokeCap: StrokeCap.round,
        dashPattern: [2, 2],
        customPath: (size) {
          return Path()
            ..moveTo(cardRadius, 0)
            ..lineTo(size.width - cardRadius, 0)
            ..arcToPoint(Offset(size.width, cardRadius),
                radius: Radius.circular(cardRadius))
            ..lineTo(size.width, size.height - cardRadius)
            ..arcToPoint(Offset(size.width - cardRadius, size.height),
                radius: Radius.circular(cardRadius))
            ..lineTo(cardRadius, size.height)
            ..arcToPoint(Offset(0, size.height - cardRadius),
                radius: Radius.circular(cardRadius))
            ..lineTo(0, cardRadius)
            ..arcToPoint(Offset(cardRadius, 0),
                radius: Radius.circular(cardRadius));
        },
        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(uniqueId, style: idStyle),
                  Text(orderStatus,
                      style: pastOrderStatusStyle(
                          orderStatus.toLowerCase().pastOrderColor()))
              ]),
              Text('Kamlesh', style: pastOrderNameStyle),
              Text('kamal.lakhani56@gmail.com', style: pastOrderEmailStyle),
              Text('Ahmedabad (Nikol) 123456', style: pastOrderAddressStyle),
              SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(typeDelivery, style: deliveryType),
                Text(dateTime, style: timeCalculationStyle)
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  Text(paymentType, style: paymentPaidStatusStyle),
                  SizedBox(width: 3),
                  Text('($CODPaymentType)', style: paymentCollectStyle)
                ]),
                Text('$rsSymbol $orderTotalAmount.', style: totalAmountStyle)
              ]),
              isRefundable == null ? Container() : SizedBox(height: 5),
              isRefundable == null
                  ? Container()
                  : Text('$refundable', style: pastOrderRefundableStyle),
              remark == null
                  ? Container()
                  : Row(children: [
                      Text('$remarkItem', style: pastOrderRemarkStyle),
                      SizedBox(width: 5),
                      Text(remark, style: pastOrderRemarkCommentStyle)
                    ])
            ])));

    return Container(margin: EdgeInsets.all(10), child: _dottedLine);
  }
}
