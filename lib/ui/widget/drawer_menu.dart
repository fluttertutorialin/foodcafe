import 'package:flutter/material.dart';
import 'package:foodcafe/resource/colors.dart';
import 'package:foodcafe/resource/images.dart';
import 'package:foodcafe/resource/routes.dart';
import 'package:foodcafe/resource/style.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:foodcafe/ui/widget/dialog_exit.dart';
import 'package:get/get.dart';
import 'package:recase/recase.dart';

class DrawerMenu extends StatelessWidget {
  final String userName, email, profileURL;
  final ValueChanged<String> drawerCallBack;

  DrawerMenu(
      {@required this.userName,
      @required this.email,
      @required this.profileURL,
      this.drawerCallBack});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.1),
              backgroundImage: profileURL.isEmpty
                  ? ExactAssetImage(profileImage)
                  : NetworkImage(profileURL)),
          title: Text(userName.titleCase, style: drawerUserNameStyle),
          subtitle: Text(email.toLowerCase(), style: drawerEmailStyle),
          trailing: GestureDetector(
              child: Icon(notificationIcon, color: accentColor),
              onTap: () => drawerCallBack(titleNotification)),
          onTap: () {
            Get.back();
            Get.toNamed(profileEditRoute);
          }),
      ListTile(
          leading: Icon(pauseMenuIcon, size: 16),
          title: Text(titlePauseMenu, style: drawerMenuStyle),
          onTap: () => drawerCallBack(titlePauseMenu)),
      ListTile(
          leading: Icon(pastOrderIcon, size: 16),
          title: Text(titlePastOrder, style: drawerMenuStyle),
          onTap: () => drawerCallBack(titlePastOrder)),
      ListTile(
          leading: Icon(newOrderIcon, size: 16),
          title: Text(titleNewOrder, style: drawerMenuStyle),
          onTap: () => drawerCallBack(titleNewOrder)),
      ListTile(
          leading: Icon(kdsViewIcon, size: 16),
          title: Text(titleKDSView, style: drawerMenuStyle),
          onTap: () => drawerCallBack(titleKDSView)),
      ListTile(
          trailing: CircleAvatar(
              radius: 15,
              backgroundColor: notificationBackgroundColor,
              child: Text('2', style: birthDayCounterStyle)),
          leading: Icon(birthDayIcon, size: 16),
          title: Text(titleBirthDay, style: drawerMenuStyle),
          onTap: () => drawerCallBack(titleBirthDay)),
      ListTile(
          leading: Icon(profileIcon, size: 16),
          title: Text(titleAccounts, style: drawerMenuStyle),
          onTap: () => drawerCallBack(titleAccounts)),
      ListTile(
          leading: Icon(logoutIcon, size: 16),
          title: Text(titleLogout, style: drawerMenuStyle),
          onTap: () {
            Get.back();
            showDialog(
                context: context,
                builder: (_) => DialogExit(
                    callBackCancel: () => Get.back(),
                    callBackOk: () => drawerCallBack(titleLogout)));
          })
    ]));
  }
}
