import 'package:flutter/material.dart';
import 'package:foodcafe/controller/pause_menu_controller.dart';
import 'package:foodcafe/resource/colors.dart';
import 'package:foodcafe/resource/style.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:foodcafe/ui/widget/bottom_sheet_custom.dart';
import 'package:foodcafe/ui/widget/bottom_sheet_pause_menu.dart';
import 'package:foodcafe/ui/widget/custom_switch.dart';
import 'package:foodcafe/ui/widget/text_field_search.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';
import 'package:foodcafe/utils/extensions.dart';

class PauseMenuPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        body: PauseMenuController.to.stateStatus.value == StateStatus.LOADING
            ? circleProgressIndicator()
            : Container(
                color: backgroundPauseMenuColor,
                child: Column(children: [
                  Expanded(
                      flex: 0,
                      child: Column(children: [
                        SizedBox(height: 10),
                        Text(labelTurnOfOrdering, style: pauseMenuTitleStyle),
                        Column(
                            children: PauseMenuController.to.rxPauseShopList
                                .map((item) => Container(
                                    margin: EdgeInsets.only(
                                        bottom: 0, left: 10, right: 10),
                                    child: Column(children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(item.menuName.value,
                                                      style: switchLabelStyle),
                                                  Obx(() => Text(
                                                      item.orderAvailableDateTime
                                                                  .value !=
                                                              null
                                                          ? '${item.orderAvailableDateTime.value.dateTimeyyyyMMddhhmma()}'
                                                          : '',
                                                      style:
                                                          menuAvailableStyle))
                                                ]),
                                            Obx(() => CustomSwitch(
                                                value: item.switchCase.value,
                                                onChanged: (bool value) {
                                                  bottomSheetCustom(
                                                      isScrollControlled: true,
                                                      isDismissible: false,
                                                      backgroundColor:
                                                          Colors.white,
                                                      context: Get.context,
                                                      builder: (context) =>
                                                          BottomSheetPauseMenu(
                                                              menuName: item
                                                                  .menuName
                                                                  .value,
                                                              voidCallbackOk:
                                                                  () {
                                                                    PauseMenuController.to
                                                                    .isTurnOfOrdering(
                                                                        item);

                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus();
                                                                Get.back();
                                                              }));
                                                },
                                                activeColor: switchActiveColor,
                                                inactiveTrackColor:
                                                    switchTrackColor,
                                                inactiveThumbColor:
                                                    switchInActiveColor))
                                          ])
                                    ])))
                                .toList())
                      ])),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0))),
                          child: Column(children: [
                            Obx(() => TextFieldSearch(
                                isSuffixIconVisible:
                                PauseMenuController.to.search.value.isEmpty
                                        ? false.obs
                                        : true.obs,
                                textEditingController:
                                PauseMenuController.to.searchController,
                                callBackClear: () {
                                  if (PauseMenuController.to
                                      .searchController.value.text.isNotEmpty) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());

                                    PauseMenuController.to.searchController
                                        .clear();
                                    PauseMenuController.to.findRecipeName('');
                                  }
                                },
                                onChanged: PauseMenuController.to.findRecipeName)),
                            Expanded(
                                child: Column(children: [
                              Text(labelMenu, style: pauseMenuTitleStyle),
                              Expanded(
                                  child: Obx(() =>
                                  PauseMenuController.to
                                              .rxPauseMenuList.isEmpty
                                          ? emptySearchWidget()
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: PauseMenuController.to
                                                  .rxPauseMenuList.length,
                                              itemBuilder: (context, index) {
                                                var item = PauseMenuController.to
                                                    .rxPauseMenuList[index];
                                                return Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              '${item.parentName}  (${item.pauseMenuList.length})',
                                                              style:
                                                                  groupByParentNameStyle),
                                                          Column(
                                                              children: item
                                                                  .pauseMenuList
                                                                  .map((item) =>
                                                                      Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                              Text(item.menuName.value, style: switchLabelStyle),
                                                                              Obx(() => Text(item.orderAvailableDateTime.value != null ? '${item.orderAvailableDateTime.value.dateTimeyyyyMMddhhmma()}' : '', style: menuAvailableStyle))
                                                                            ]),
                                                                            Obx(() => CustomSwitch(
                                                                                value: item.switchCase.value,
                                                                                onChanged: (bool value) {
                                                                                  bottomSheetCustom(
                                                                                      isScrollControlled: true,
                                                                                      isDismissible: false,
                                                                                      backgroundColor: Colors.white,
                                                                                      context: Get.context,
                                                                                      builder: (context) => BottomSheetPauseMenu(
                                                                                          menuName: item.menuName.value,
                                                                                          voidCallbackOk: () {
                                                                                            PauseMenuController.to.isTurnOfOrdering(item);

                                                                                            FocusScope.of(context).unfocus();
                                                                                            Get.back();
                                                                                          }));
                                                                                },
                                                                                activeColor: switchActiveColor,
                                                                                inactiveTrackColor: switchTrackColor,
                                                                                inactiveThumbColor: switchInActiveColor))
                                                                          ]))
                                                                  .toList())
                                                        ]));
                                              })))
                            ]))
                          ])))
                ]))));
  }
}
