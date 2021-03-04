import 'package:flutter/material.dart';
import 'package:foodcafe/controller/controller.dart';
import 'package:foodcafe/resource/colors.dart';
import 'package:foodcafe/resource/style.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:get/get.dart';
import 'bottom_sheet_custom.dart';
import 'delivery_types.dart';

class OrderStatus extends StatelessWidget {
  final String uniqueId;
  final String orderStatus;
  final bool isRejectShow;
  final VoidCallback rejectCallBack, orderCallBack;

  final _deliveryTypesController = Get.put(DeliveryTypesController());
  final _allFindController = Get.put(AllFindController());
  final _acceptedController = Get.put(AcceptedController());

  OrderStatus(
      {this.uniqueId,
      this.orderStatus,
      this.isRejectShow = true,
      this.rejectCallBack,
      this.orderCallBack});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        isRejectShow
            ? IntrinsicWidth(
                child: InkWell(
                    highlightColor: Colors.blue.withOpacity(0.2),
                    onTap: rejectCallBack,
                    borderRadius: BorderRadius.circular(5.0),
                    child: Column(children: [
                      Text(rejectButton, style: orderStatusLinkStyle),
                      Container(color: Colors.blue, height: 1)
                    ])))
            : Container()
      ]),
      Row(children: [
        Visibility(
            visible: orderStatus == foodReadyButton,
            child: InkWell(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5.0)),
                    padding: EdgeInsets.all(3),
                    child:
                        Text(' DELIVERY PERSON ', style: deliveryPersonStyle)),
                onTap: () {
                  var _currentFocus = FocusScope.of(context);

                  if (!_currentFocus.hasPrimaryFocus) {
                    _currentFocus.unfocus();
                  }

                  _allFindController.deliveryPersonalDetailUnSelect(
                      uniqueId: uniqueId);
                  _acceptedController.deliveryPersonalDetailUnSelect(
                      uniqueId: uniqueId);

                  _deliveryTypesController.rxSelectDeliveryType.value = '1';
                  _deliveryTypesController.rxSelectPartyType.value = '';
                  _deliveryTypesController.rxSelectFreeDeliveryPerson.value = '';

                  bottomSheetCustom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10))),
                      isScrollControlled: false,
                      isDismissible: false,
                      backgroundColor: backgroundColor,
                      context: context,
                      builder: (context) => DeliveryTypes(uniqueId: uniqueId));
                })),
        SizedBox(width: 10),
        InkWell(
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5.0)),
                padding: EdgeInsets.all(3),
                child: Text(' $orderStatus ', style: orderStatusStyle)),
            onTap: orderCallBack)
      ])
    ]);
  }
}
