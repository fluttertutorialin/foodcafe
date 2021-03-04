import 'package:flutter/material.dart';
import 'package:foodcafe/controller/controller.dart';
import 'package:foodcafe/controller/notification_firebase_controller.dart';
import 'package:foodcafe/resource/colors.dart';
import 'package:foodcafe/resource/images.dart';
import 'package:foodcafe/resource/routes.dart';
import 'package:foodcafe/resource/style.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:foodcafe/ui/widget/bottom_sheet_custom.dart';
import 'package:foodcafe/ui/widget/dialog_search.dart';
import 'package:foodcafe/ui/widget/drawer_menu.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _renderBody(context);

  _renderBody(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
            elevation: appBarElevation,
            actions: [
              HomeController.to.drawerMenuIndex.value == 0
                  ? Container(
                      margin: EdgeInsets.only(right: 10),
                      child: GestureDetector(
                          child: Icon(searchIcon,
                              size: 18, color: appBarTitleColor),
                          onTap: () => showDialog(
                              barrierColor: Colors.white.withOpacity(0),
                              context: context,
                              builder: (BuildContext context) {
                                return Obx(() => DialogSearch(
                                    isVisibleSearchClearIcon: HomeController.to
                                        .isVisibleSearchClearIcon(HomeController
                                            .to.currentPageIndex.value),
                                    callSearchClear: () {
                                      HomeController.to.searchClear(
                                          HomeController
                                              .to.currentPageIndex.value);
                                      HomeController.to.searchController
                                          .clear();
                                    },
                                    textEditingController:
                                        HomeController.to.searchController,
                                    onChanged: (onChange) => HomeController.to
                                        .searchTab(
                                            onChange,
                                            HomeController
                                                .to.currentPageIndex.value)));
                              })))
                  : Container()
            ],
            leading: IconButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  bottomSheetCustom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10))),
                      isScrollControlled: true,
                      isDismissible: true,
                      backgroundColor: backgroundColor,
                      context: context,
                      builder: (context) => DrawerMenu(
                          userName:
                              HomeController.to.secureStorageUserName.value,
                          email: HomeController.to.secureStorageEmail.value,
                          profileURL:
                              HomeController.to.secureStorageProfileURL.value,
                          drawerCallBack: (String value) {
                            Get.back();
                            switch (value) {
                              case titleNotification:
                                Get.toNamed(notificationRoute);
                                break;

                              case titlePauseMenu:
                                HomeController.to.currentPageIndex.value =
                                    pendingIndex; //Tab selected 0 index
                                HomeController.to
                                    .drawerMenuChange(pauseMenuIndex);
                                break;

                              case titlePastOrder:
                                HomeController.to.currentPageIndex.value =
                                    pendingIndex; //Tab selected 0 index
                                HomeController.to.drawerMenuChange(pastOrder);
                                break;

                              case titleKDSView:
                                HomeController.to.currentPageIndex.value =
                                    pendingIndex; //Tab selected 0 index
                                HomeController.to.drawerMenuChange(KDSView);
                                break;

                              case titleNewOrder:
                                Get.toNamed(newOrderRoute);
                                break;

                              case titleAccounts:
                                Get.toNamed(accountsRoute);
                                break;

                              case titleBirthDay:
                                Get.toNamed(birthDayRoute);
                                break;

                              case titleLogout:
                                HomeController.to.callLogout();
                                break;
                            }
                          }));
                },
                icon: Icon(navigationIcon, size: 18, color: appBarTitleColor)),
            title: Text(appName, style: appBarTitleStyle)),
        body: PageView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomeController.to.redirectPage(),
              HomeController.to.redirectPage(),
              HomeController.to.redirectPage(),
              HomeController.to.redirectPage()
            ],
            controller: HomeController.to.pageController),
        bottomNavigationBar: _bottomNavigationBar()));
  }

  _bottomNavigationBar() => Container(
          child: BottomNavigationBar(
              elevation: 4,
              backgroundColor: tabBackgroundColor,
              fixedColor: tabSelectColor,
              unselectedItemColor: tabUnSelectColor,
              type: BottomNavigationBarType.fixed,
              onTap: HomeController.to.onTabChange,
              selectedLabelStyle: tabSelectStyle,
              unselectedLabelStyle: tabUnSelectStyle,
              currentIndex: HomeController.to.currentPageIndex.value,
              items: [
            BottomNavigationBarItem(
                icon: _notification(
                    iconData: tabPendingIcon,
                    notificationCounter: NotificationFirebaseController
                            .to.notificationList.isEmpty
                        ? '0'
                        : NotificationFirebaseController
                            .to.notificationList[0].pending,
                    selectIndex: HomeController.to.currentPageIndex.value ==
                        pendingIndex),
                label: drawerMenuPending),
            BottomNavigationBarItem(
                icon: _notification(
                    iconData: tabAcceptedIcon,
                    notificationCounter: NotificationFirebaseController
                            .to.notificationList.isEmpty
                        ? '0'
                        : NotificationFirebaseController
                            .to.notificationList[0].accepted,
                    selectIndex: HomeController.to.currentPageIndex.value ==
                        acceptedIndex),
                label: drawerMenuAccepted),
            BottomNavigationBarItem(
                icon: _notification(
                    iconData: tabReadyIcon,
                    notificationCounter: NotificationFirebaseController
                            .to.notificationList.isEmpty
                        ? '0'
                        : NotificationFirebaseController
                            .to.notificationList[0].ready,
                    selectIndex:
                        HomeController.to.currentPageIndex.value == readyIndex),
                label: drawerMenuReady),
            BottomNavigationBarItem(
                icon: _notification(
                    iconData: tabDispatchedIcon,
                    notificationCounter: NotificationFirebaseController
                            .to.notificationList.isEmpty
                        ? '0'
                        : NotificationFirebaseController
                            .to.notificationList[0].dispatched,
                    selectIndex: HomeController.to.currentPageIndex.value ==
                        dispatchedIndex),
                label: drawerMenuDispatched)
          ]));

  _notification(
          {@required IconData iconData,
          String notificationCounter,
          bool selectIndex = false}) =>
      Stack(children: <Widget>[
        Container(
            width: 30,
            height: 25,
            padding: const EdgeInsets.only(right: 0.0, top: 4),
            child: Icon(iconData)),
        //if (count > 0)
        Positioned(
            right: 0,
            top: 0,
            child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: selectIndex
                        ? countSelectBackgroundColor
                        : countBackgroundColor,
                    borderRadius: BorderRadius.circular(8)),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(notificationCounter,
                    style: countStyle, textAlign: TextAlign.center)))
      ]);
}
