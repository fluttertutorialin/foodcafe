import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import '../resource/api.dart';
import '../resource/routes.dart';
import '../resource/value.dart';
import '../shared/repository/firestore_database_repository.dart';
import '../shared/repository/local_auth_repository.dart';
import '../ui/page/accepted_page.dart';
import '../ui/page/dispatched_page.dart';
import '../ui/page/kds_view_page.dart';
import '../ui/page/past_order_page.dart';
import '../ui/page/pause_menu_page.dart';
import '../ui/page/pending_page.dart';
import '../ui/page/ready_page.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final _localAuthRepository = Get.find<LocalAuthRepository>();
  final fireStoreDatabaseRepository = Get.find<FireStoreDatabaseRepository>();

  var searchController = TextEditingController();

  final pendingController = Get.put(PendingController());
  final acceptedController = Get.put(AcceptedController());
  final readyController = Get.put(ReadyController());
  final dispatchedController = Get.put(DispatchedController());
  PageController pageController;

  var currentPageIndex = Rx<int>(0);
  var drawerMenuIndex = Rx<int>(0);

  var secureStorageUserNameRx = Rx<String>('');
  var secureStorageProfileUrlRx = Rx<String>('');
  var secureStorageEmailRx = Rx<String>('');
  var secureStorageMobileRx = Rx<String>('');
  var secureStoragePinCodeRx = Rx<String>('');
  var secureStorageAddressRx = Rx<String>('');
  var secureStorageWhereLoginRx = Rx<String>('');

  @override
  onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentPageIndex.value);
    getUserDetails();
  }

  onTabChange(int index) {
    currentPageIndex.value = index;

    if (drawerMenuIndex.value > 3) drawerMenuIndex.value = 0;
  }

  drawerMenuChange(int index) {
    drawerMenuIndex.value = index;
  }

  _tabPages(int index) {
    switch (index) {
      case pendingIndex:
        return PendingPage();
        break;
      case acceptedIndex:
        return AcceptedPage();
        break;
      case readyIndex:
        return ReadyPage();
        break;
      case dispatchedIndex:
        return DispatchedPage();
        break;
    }
  }

  searchTab(String value, int currentPageIndex) {
    switch (currentPageIndex) {
      case pendingIndex:
        pendingController.search(value);
        break;

      case acceptedIndex:
        acceptedController.search(value);
        break;

      case readyIndex:
        readyController.search(value);
        break;

      case dispatchedIndex:
        dispatchedController.search(value);
        break;
    }
  }

  redirectPage() {
    if (drawerMenuIndex.value == pauseMenuIndex) {
      return const PauseMenuPage();
    } else if (drawerMenuIndex.value == pastOrder) {
      return PastOrderPage();
    } else if (drawerMenuIndex.value == kdsView) {
      return KDSViewPage();
    } else {
      return _tabPages(currentPageIndex.value);
    }
  }

  isVisibleSearchClearIcon(int currentPageIndex) {
    switch (currentPageIndex) {
      case pendingIndex:
        return pendingController.search.value == '' ? false.obs : true.obs;
        break;

      case acceptedIndex:
        return acceptedController.search.value == '' ? false.obs : true.obs;
        break;

      case readyIndex:
        return readyController.search.value == '' ? false.obs : true.obs;
        break;

      case dispatchedIndex:
        return dispatchedController.search.value == '' ? false.obs : true.obs;
        break;
    }
  }

  void getUserDetails() {
    secureStorageUserNameRx.value =
        _localAuthRepository.readSession(secureStorageUsername);

    secureStorageProfileUrlRx.value =
        _localAuthRepository.readSession(secureStorageProfileUrl);

    secureStorageEmailRx.value =
        _localAuthRepository.readSession(secureStorageEmail);

    secureStorageMobileRx.value =
        _localAuthRepository.readSession(secureStorageMobile);

    secureStoragePinCodeRx.value =
        _localAuthRepository.readSession(secureStoragePinCode);

    secureStorageAddressRx.value =
        _localAuthRepository.readSession(secureStorageAddress);

    secureStorageWhereLoginRx.value =
        _localAuthRepository.readSession(secureStorageWhereLogin);
  }

  void setUserDetails(
      {String userName,
      String mobile,
      String pinCode,
      String address,
      String profileUrl}) {
    _localAuthRepository.writeSession(secureStorageUsername, userName);
    _localAuthRepository.writeSession(secureStorageMobile, mobile);
    _localAuthRepository.writeSession(secureStoragePinCode, pinCode);
    _localAuthRepository.writeSession(secureStorageAddress, address);
  }

  searchClear(int currentPageIndex) {
    switch (currentPageIndex) {
      case pendingIndex:
        pendingController.search.value = '';
        break;

      case acceptedIndex:
        acceptedController.search.value = '';
        break;

      case readyIndex:
        readyController.search.value = '';
        break;

      case dispatchedIndex:
        dispatchedController.search.value = '';
        break;
    }
  }

  callLogout() {
    _localAuthRepository.clearSession();
    fireStoreDatabaseRepository.googleLogout();

    //Get.offAllNamed(loginRoute);
    Get.offNamedUntil(loginRoute, (_) => false);
  }

  @override
  onClose() {
    super.onClose();
    pageController.dispose();

    secureStorageUserNameRx.value = '';
    secureStorageProfileUrlRx.value = '';
    secureStorageEmailRx.value = '';
    secureStorageMobileRx.value = '';
    secureStoragePinCodeRx.value = '';
    secureStorageAddressRx.value = '';
  }
}
