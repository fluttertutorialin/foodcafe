import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../resource/colors.dart';
import '../../resource/images.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';
import '../../utils/state_status.dart';
import '../../utils/extensions.dart';

class BirthDayPage extends StatelessWidget {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  BirthDayPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: appBarColor,
            elevation: appBarElevation,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(backIcon, size: 18, color: appBarTitleColor)),
            title: Text(titleBirthDay, style: appBarTitleStyle)),
        body: Obx(() => RefreshIndicator(
            key: _refreshKey,
            backgroundColor: refreshBackgroundColor,
            color: refreshColor,
            onRefresh: () async {
              if (BirthDayController.to.refreshStatus.value ==
                  RefreshStatus.success) {
                _refreshKey.currentState.dispose();
              }

              if (BirthDayController.to.refreshStatus.value ==
                  RefreshStatus.initial) {
                _refreshKey.currentState.show();
                BirthDayController.to.fetchBirthDay(isRefresh: true);
              }
            },
            child: BirthDayController.to.stateStatus.value ==
                    StateStatus.loading
                ? circleProgressIndicator()
                : BirthDayController
                        .to.birthDayResponse.value.birthDayList.isEmpty
                    ? emptyWidget(message: dataNotBirthday)
                    : ListView.builder(
                        itemCount: BirthDayController
                            .to.birthDayResponse.value.birthDayList.length,
                        itemBuilder: (context, index) {
                          var _birthDay = BirthDayController
                              .to.birthDayResponse.value.birthDayList[index];
                          return Container(
                              margin: const EdgeInsets.all(0),
                              child: Card(
                                  elevation: cardViewElevation,
                                  child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Row(children: [
                                        CircleAvatar(
                                            radius: 25,
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.1),
                                            backgroundImage:
                                                const ExactAssetImage(profileImage)),
                                        const SizedBox(width: 5),
                                        Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(_birthDay.name.value,
                                                        style:
                                                            turnOfOrderingNameStyle),
                                                    Text(
                                                        _birthDay
                                                            .birthDate.value,
                                                        style: dateTimeStyle)
                                                  ]),
                                              Text(_birthDay.address.value,
                                                  style:
                                                      turnOfOrderingMenuStyle),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(children: [
                                                      Obx(() => Icon(
                                                          birthWishIcon,
                                                          size: 14,
                                                          color: _birthDay
                                                                  .isSentMessage
                                                                  .value
                                                              ? birthDayWish
                                                              : birthDayWishPending)),
                                                      const SizedBox(width: 3),
                                                      Obx(() => Text(
                                                          _birthDay
                                                                  .isSentMessage
                                                                  .value
                                                              ? _birthDay
                                                                  .birthDayWishName
                                                              : labelBirthDayWishPending,
                                                          style: birthDayInformStyle(
                                                              _birthDay
                                                                      .isSentMessage
                                                                      .value
                                                                  ? Colors.green
                                                                  : Colors
                                                                      .grey)))
                                                    ]),
                                                    const SizedBox(width: 10),
                                                    if (_birthDay.isSentMessage.value == false)
                                                      InkWell(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  13.0),
                                                          radius: 14,
                                                          highlightColor: Colors
                                                              .deepOrange
                                                              .withOpacity(0.2),
                                                          onTap: () => BirthDayController.to
                                                              .birthDayWish(
                                                                  birthDay:
                                                                      _birthDay),
                                                          child: CircleAvatar(
                                                              backgroundColor: Colors.black
                                                                  .withOpacity(
                                                                      0.1),
                                                              radius: 13,
                                                              child: const Icon(
                                                                  Icons.sms_outlined,
                                                                  color: accentColor,
                                                                  size: 15)))
                                                  ])
                                            ]))
                                      ]))));
                        }))));
  }
}
