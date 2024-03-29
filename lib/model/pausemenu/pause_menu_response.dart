import 'package:get/get.dart';

class PauseMenuResponse {
  List<PauseOrderGroup> pauseOrderGroupList;
  List<PauseOrderMenu> pauseShopList;

  PauseMenuResponse({this.pauseOrderGroupList, this.pauseShopList});
}

class PauseOrderGroup{
  String parentName;
  List<PauseOrderMenu> pauseMenuList;

  PauseOrderGroup({this.parentName, this.pauseMenuList});
}

class PauseOrderMenu {
  PauseOrderMenu({int id, String menuName, int orderAvailableDateTime, bool switchCase}) {
    setId(id);
    setMenuName(menuName);
    setOrderAvailableDateTime(orderAvailableDateTime);
    setSwitchCase(switchCase);
  }

  RxInt id = RxInt(null);
  setId(int value) => id.value = value;

  RxString menuName = RxString(null);
  setMenuName(String value) => menuName.value = value;

  RxInt orderAvailableDateTime = RxInt(0);
  setOrderAvailableDateTime(int value) =>
      orderAvailableDateTime.value = value;

  RxBool switchCase = RxBool(false);
  setSwitchCase(bool value) => switchCase.value = value;
}
