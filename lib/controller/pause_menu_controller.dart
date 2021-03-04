import 'package:flutter/material.dart';
import 'package:foodcafe/model/pausemenu/PauseMenuResponse.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';

class PauseMenuController extends GetxController {
  static PauseMenuController get to => Get.find();
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  var rxPauseMenuList = RxList<PauseOrderGroup>([]);
  var rxPauseShopList = RxList<PauseOrderMenu>([]);
  var rxTempPauseMenuList = RxList<PauseOrderGroup>([]);
  var searchController = TextEditingController();

  var search = Rx<String>('');

  @override
  onInit() {
    super.onInit();
    fetchPauseMenu();
  }

  Future<void> fetchPauseMenu() async {
    stateStatus.value = StateStatus.LOADING;

    var pauseMenuResponse = PauseMenuResponse(pauseShopList: [
      PauseOrderMenu(id: 1001, menuName: 'Online ordering', switchCase: true),
      PauseOrderMenu(id: 1002, menuName: 'Offline ordering', switchCase: true)
    ], pauseOrderGroupList: [
      PauseOrderGroup(parentName: 'Non - vegetable', pauseMenuList: [
        PauseOrderMenu(id: 1003, menuName: 'Chicken biryani', switchCase: true)
      ]),
      PauseOrderGroup(parentName: 'Vegetable', pauseMenuList: [
        PauseOrderMenu(id: 1004, menuName: 'Rice', switchCase: true),
      ]),
      PauseOrderGroup(parentName: 'Food', pauseMenuList: [
        PauseOrderMenu(
            id: 1005,
            menuName: 'Manchurian',
            switchCase: false,
            orderAvailableDateTime: 1607919790946705),
        PauseOrderMenu(
            id: 1006,
            menuName: 'Hakka Noodles',
            switchCase: false,
            orderAvailableDateTime: 1607919790946705),
      ]),
    ]);

    await Future.delayed(Duration(seconds: 2));
    stateStatus.value = StateStatus.SUCCESS;

    rxPauseShopList.assignAll(pauseMenuResponse.pauseShopList.obs);
    rxPauseMenuList.assignAll(pauseMenuResponse.pauseOrderGroupList.obs);

    rxTempPauseMenuList.assignAll(rxPauseMenuList);
  }

  void isTurnOfOrdering(PauseOrderMenu pauseOrderMenu) {
    pauseOrderMenu.switchCase.value = !pauseOrderMenu.switchCase.value;
    pauseOrderMenu.switchCase.value
        ? pauseOrderMenu.orderAvailableDateTime.value = null
        : pauseOrderMenu.orderAvailableDateTime.value = 1607919790946705;
  }

  void findRecipeName(String value) {
    if (value == '') {
      search('');
      rxPauseMenuList.assignAll(rxTempPauseMenuList);
    } else {
      search(value);
      List<PauseOrderGroup> pauseOrderGroupList = [];
      //List<PauseOrderMenu> pauseMenuList = List();
      String parentName;

      for (PauseOrderGroup pauseOrderGroup in rxTempPauseMenuList) {
        parentName = pauseOrderGroup.parentName;

        /*pauseMenuList = pauseOrderGroup.pauseMenuList
            .where((element) => element.menuName.value.toLowerCase().contains(value.toLowerCase()))
            .toList();

        pauseOrderGroupList.add(PauseOrderGroup(
            parentName: parentName, pauseMenuList: pauseMenuList));*/

        List<PauseOrderMenu> pauseMenuListFilter = pauseOrderGroup.pauseMenuList
            .where((element) => element.menuName.value
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();

        if (pauseMenuListFilter.isNotEmpty) {
          pauseOrderGroupList.add(PauseOrderGroup(
              parentName: parentName, pauseMenuList: pauseMenuListFilter));
        } else {
          parentName = '';
        }
      }

      rxPauseMenuList.assignAll(pauseOrderGroupList);
    }
  }
}
