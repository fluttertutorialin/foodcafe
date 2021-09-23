import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../resource/colors.dart';
import '../../resource/images.dart';
import '../../resource/style.dart';

class DeliveryTypes extends StatelessWidget {
  final String uniqueId;
  DeliveryTypes({Key key, this.uniqueId}) : super(key: key);

  final _deliveryTypesController = Get.put(DeliveryTypesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: appBarColor,
            elevation: 0.2,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(searchClearIcon,
                    size: 18, color: appBarTitleColor)),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _deliveryTypesController.rxDeliveryTypes.value.whichDeliveryTypeList
                    .map((item) => InkWell(
                        highlightColor: appBarTitleColor.withOpacity(0.2),
                        onTap: () => _deliveryTypesController.selectDeliveryType(
                            orderUniqueId: uniqueId, uniqueId: item.uniqueId),
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            padding: const EdgeInsets.all(5),
                            child: Obx(() => Text(item.name,
                                style: _deliveryTypesController.rxSelectDeliveryType.value == item.uniqueId
                                    ? deliveryTypeSelectStyle
                                    : deliveryTypeUnSelectStyle)))))
                    .toList())),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 5),
          Wrap(
              children: _deliveryTypesController.rxPartyType.value.partyList
                  .map((item) => Container(
                      margin: const EdgeInsets.all(5),
                      child: InkWell(
                          highlightColor: appBarTitleColor.withOpacity(0.2),
                          onTap: () => _deliveryTypesController.selectPartyType(
                              orderUniqueId: uniqueId, uniqueId: item.uniqueId),
                          borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(5.0)),
                              padding: const EdgeInsets.all(5),
                              child: Obx(() => Text(item.name.toUpperCase(),
                                  style: _deliveryTypesController
                                              .rxSelectPartyType.value ==
                                          item.uniqueId
                                      ? deliveryTypeNameSelectStyle
                                      : deliveryTypeNameUnSelectStyle))))))
                  .toList()),
          const SizedBox(height: 5),
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
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 5, left: 10, right: 10),
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
                          const Divider(color: Colors.grey)
                        ]))
                    .toList())
          ]))
        ]));
  }
}
