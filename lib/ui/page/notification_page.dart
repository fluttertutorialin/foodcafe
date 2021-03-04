import 'package:flutter/material.dart';
import 'package:foodcafe/controller/controller.dart';
import 'package:foodcafe/resource/images.dart';
import 'package:foodcafe/resource/style.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:foodcafe/ui/widget/animation/slide_in_transition.dart';
import 'package:foodcafe/ui/widget/header_dialog_container.dart';
import 'package:foodcafe/ui/widget/rounded_shadow_container.dart';
import 'package:foodcafe/utils/extensions.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => HeaderContainer(
                child: Column(children: <Widget>[
              _buildHeader(
                  NotificationController.to.rxTotalNotificationCounter.value),
              Expanded(
                  child: SlideInTransition(
                      controller: NotificationController.to.animationController,
                      child: RoundedShadowContainer(
                          child: Container(
                              child: listView(
                                  stateStatus: NotificationController
                                      .to.stateStatus.value,
                                  dataNotFoundMessage:
                                      dataNotNotificationMessage,
                                  length: NotificationController
                                      .to.rxNotificationList.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    var notification = NotificationController
                                        .to.rxNotificationList[i];
                                    return Card(
                                        elevation: cardViewElevation,
                                        child: Container(
                                            margin: EdgeInsets.all(10),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Align(
                                                      child: Text(
                                                          notification.dateTime
                                                              .dateTimeyyyyMMddhhmma(),
                                                          style: dateTimeStyle),
                                                      alignment:
                                                          Alignment.topRight),
                                                  Text(notification.title,
                                                      style:
                                                          getNotificationTitleStyle),
                                                  Text(notification.description,
                                                      style:
                                                          getNotificationDescriptionStyle)
                                                ])));
                                  }),
                              margin: EdgeInsets.only(top: 0)))))
            ]))));
  }

  Widget _buildHeader(int totalNotificationCounter) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
        child: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              SizedBox(width: double.infinity),
              IconButton(
                  onPressed: () => Get.back(),
                  color: Colors.white,
                  icon: Icon(backIcon)),
              Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 34.0, vertical: 10.0),
                  child: _notificationHeader(totalNotificationCounter))
            ])));
  }

  _notificationHeader(int totalNotificationCounter) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text(labelTotalNotification, style: notificationTitleStyle),
        Text('$totalNotificationCounter', style: totalNotificationStyle)
      ]);
}
