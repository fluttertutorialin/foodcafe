import 'package:flutter/material.dart';
import 'package:foodcafe/controller/controller.dart';
import 'package:foodcafe/resource/colors.dart';
import 'package:foodcafe/resource/images.dart';
import 'package:foodcafe/resource/style.dart';
import 'package:get/get.dart';

class DeliveryTypes extends StatelessWidget {
  final String uniqueId;
  DeliveryTypes({this.uniqueId});

  final _deliveryTypesController = Get.put(DeliveryTypesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.2,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(searchClearIcon, size: 18, color: appBarTitleColor)),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _deliveryTypesController
                    .rxDeliveryTypes.value.whichDeliveryTypeList
                    .map((item) => InkWell(
                        highlightColor: appBarTitleColor.withOpacity(0.2),
                        onTap: () => _deliveryTypesController
                            .selectDeliveryType(orderUniqueId: uniqueId, uniqueId: item.uniqueId),
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            padding: EdgeInsets.all(5),
                            child: Obx(() => Text(item.name,
                                style: _deliveryTypesController.rxSelectDeliveryType.value == item.uniqueId
                                    ? deliveryTypeSelectStyle
                                    : deliveryTypeUnSelectStyle)))))
                    .toList())),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 5),
          Wrap(
              children: _deliveryTypesController.rxPartyType.value.partyList
                  .map((item) => Container(
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                          highlightColor: appBarTitleColor.withOpacity(0.2),
                          onTap: () => _deliveryTypesController
                              .selectPartyType(orderUniqueId: uniqueId, uniqueId: item.uniqueId),
                          borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(5.0)),
                              padding: EdgeInsets.all(5),
                              child: Obx(() => Text(item.name.toUpperCase(),
                                  style: _deliveryTypesController
                                              .rxSelectPartyType.value ==
                                          item.uniqueId
                                      ? deliveryTypeNameSelectStyle
                                      : deliveryTypeNameUnSelectStyle))))))
                  .toList()),
          SizedBox(height: 5),
          Expanded(
              child: ListView(children: [
            Column(
                children: _deliveryTypesController
                    .rxFreeDeliveryPerson.value.freeDeliveryPersonList
                    .map((item) => Column(children: [
                          InkWell(
                              highlightColor: appBarTitleColor.withOpacity(0.2),
                              onTap: () => _deliveryTypesController
                                  .selectFreeDeliveryPerson(
                                      name: item.name,
                                      mobile: item.mobile,
                                      orderUniqueId: uniqueId,
                                      uniqueId: item.uniqueId),
                              child: Container(
                                  padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Obx(() => Text(item.name,
                                                  style: _deliveryTypesController
                                                              .rxSelectFreeDeliveryPerson
                                                              .value ==
                                                          item.uniqueId
                                                      ? deliveryBottomPersonNameUnSelectStyle
                                                      : deliveryBottomPersonNameSelectStyle))
                                            ]),
                                        GestureDetector(
                                            child: Image.asset(callImage,
                                                scale: 4),
                                            onTap: () {})
                                      ]))),
                          Divider(color: Colors.grey)
                        ]))
                    .toList())
          ]))
        ]));
  }
}
