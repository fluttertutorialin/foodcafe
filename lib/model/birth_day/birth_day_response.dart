import 'package:get/get.dart';

class BirthDayResponse {
  List<BirthDay> birthDayList;

  BirthDayResponse({this.birthDayList});
}

class BirthDay {
  String birthDayWishName;

  BirthDay({String uniqueId, String name, this.birthDayWishName, String address, String birthDate, String mobile, String profilePictureUrl, int year, bool isSentMessage, bool isCall}) {
    this.setUniqueId(uniqueId);
    this.setName(name);
    this.setBirthDayWishName(name);
    this.setAddress(address);
    this.setBirthDate(birthDate);
    this.setMobile(mobile);
    this.setProfilePictureUrl(profilePictureUrl);
    this.setYear(year);
    this.setIsSentMessage(isSentMessage);
    this.setIsCall(isCall);
  }

  RxString uniqueId = RxString();
  setUniqueId(String value) => uniqueId.value = value;

  RxString name = RxString();
  setName(String value) => name.value = value;

  RxString birthDayWishNameRx = RxString("");
  setBirthDayWishName(String value) => birthDayWishNameRx.value = value;

  RxString address = RxString();
  setAddress(String value) => address.value = value;

  RxString birthDate = RxString();
  setBirthDate(String value) => birthDate.value = value;

  RxString mobile = RxString();
  setMobile(String value) => mobile.value = value;

  RxString profilePictureUrl = RxString();
  setProfilePictureUrl(String value) => profilePictureUrl.value = value;

  RxInt year = RxInt(0);
  setYear(int value) => year.value = value;

  RxBool isSentMessage = RxBool(false);
  setIsSentMessage(bool value) => isSentMessage.value = value;

  RxBool isCall = RxBool(false);
  setIsCall(bool value) => isCall.value = value;
}
