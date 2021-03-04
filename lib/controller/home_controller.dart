import 'package:flutter/material.dart';
import 'package:foodcafe/resource/api.dart';
import 'package:foodcafe/resource/routes.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:foodcafe/shared/repository/firestore_database_repository.dart';
import 'package:foodcafe/shared/repository/local_auth_repository.dart';
import 'package:foodcafe/ui/page/accepted_page.dart';
import 'package:foodcafe/ui/page/dispatched_page.dart';
import 'package:foodcafe/ui/page/kds_view_page.dart';
import 'package:foodcafe/ui/page/past_order_page.dart';
import 'package:foodcafe/ui/page/pause_menu_page.dart';
import 'package:foodcafe/ui/page/pending_page.dart';
import 'package:foodcafe/ui/page/ready_page.dart';
import 'package:get/get.dart';
import 'controller.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  var _localAuthRepository = Get.find<LocalAuthRepository>();
  var fireStoreDatabaseRepository = Get.find<FireStoreDatabaseRepository>();

  var searchController = TextEditingController();

  final pendingController = Get.put(PendingController());
  final acceptedController = Get.put(AcceptedController());
  final readyController = Get.put(ReadyController());
  final dispatchedController = Get.put(DispatchedController());
  PageController pageController;

  var currentPageIndex = Rx<int>(0);
  var drawerMenuIndex = Rx<int>(0);

  var secureStorageUserName = Rx<String>('');
  var secureStorageProfileURL = Rx<String>('');
  var secureStorageEmail = Rx<String>('');
  var secureStorageMobile = Rx<String>('');
  var secureStoragePinCode = Rx<String>('');
  var secureStorageAddress = Rx<String>('');
  var secureStorageWhereLogin = Rx<String>('');

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
      return PauseMenuPage();
    } else if (drawerMenuIndex.value == pastOrder) {
      return PastOrderPage();
    } else if (drawerMenuIndex.value == KDSView) {
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
    secureStorageUserName.value =
        _localAuthRepository.readSession(SECURE_STORAGE_USERNAME);

    secureStorageProfileURL.value =
        _localAuthRepository.readSession(SECURE_STORAGE_PROFILE_URL);

    secureStorageEmail.value =
        _localAuthRepository.readSession(SECURE_STORAGE_EMAIL);

    secureStorageMobile.value =
        _localAuthRepository.readSession(SECURE_STORAGE_MOBILE);

    secureStoragePinCode.value =
        _localAuthRepository.readSession(SECURE_STORAGE_PINCODE);

    secureStorageAddress.value =
        _localAuthRepository.readSession(SECURE_STORAGE_ADDRESS);

    secureStorageWhereLogin.value =
        _localAuthRepository.readSession(SECURE_STORAGE_WHERE_LOGIN);
  }

  void setUserDetails(
      {String userName,
      String mobile,
      String pinCode,
      String address,
      String profileUrl}) {
    _localAuthRepository.writeSession(SECURE_STORAGE_USERNAME, userName);
    _localAuthRepository.writeSession(SECURE_STORAGE_MOBILE, mobile);
    _localAuthRepository.writeSession(SECURE_STORAGE_PINCODE, pinCode);
    _localAuthRepository.writeSession(SECURE_STORAGE_ADDRESS, address);
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

  callLogout()  {
    _localAuthRepository.clearSession();
    fireStoreDatabaseRepository.googleLogout();

    //Get.offAllNamed(loginRoute);
    Get.offNamedUntil(loginRoute, (_) => false);
  }

  @override
  onClose() {
    super.onClose();
    pageController.dispose();

    secureStorageUserName.value = '';
    secureStorageProfileURL.value = '';
    secureStorageEmail.value = '';
    secureStorageMobile.value = '';
    secureStoragePinCode.value = '';
    secureStorageAddress.value = '';
  }
}
