import 'package:flutter/material.dart';
import 'package:foodcafe/controller/controller.dart';
import 'package:foodcafe/resource/colors.dart';
import 'package:foodcafe/resource/images.dart';
import 'package:foodcafe/resource/style.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';
import 'package:foodcafe/utils/extensions.dart';

class TurnOfOrderingPage extends StatelessWidget {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: appBarElevation,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(backIcon, size: 18, color: appBarTitleColor)),
            title: Text(titleTurnOfOrdering, style: appBarTitleStyle)),
        body: Obx(() => RefreshIndicator(
            key: _refreshKey,
            backgroundColor: refreshBackgroundColor,
            color: refreshColor,
            onRefresh: () async {
              if (TurnOfOrderingController.to.refreshStatus.value ==
                  RefreshStatus.SUCCESS) {
                _refreshKey.currentState.dispose();
              }

              if (TurnOfOrderingController.to.refreshStatus.value ==
                  RefreshStatus.INITIAL) {
                _refreshKey.currentState.show();
                TurnOfOrderingController.to
                    .fetchTurnOfOrdering(isRefresh: true);
              }
            },
            child: TurnOfOrderingController.to.stateStatus.value ==
                    StateStatus.LOADING
                ? circleProgressIndicator()
                : TurnOfOrderingController.to.turnOfOrderingResponse.value
                        .turnOfOrderingList.isEmpty
                    ? emptyWidget(message: dataNotTurnOfOrdering)
                    : ListView.builder(
                        itemCount: TurnOfOrderingController
                            .to
                            .turnOfOrderingResponse
                            .value
                            .turnOfOrderingList
                            .length,
                        itemBuilder: (context, index) {
                          var turnOfOrdering = TurnOfOrderingController
                              .to
                              .turnOfOrderingResponse
                              .value
                              .turnOfOrderingList[index];
                          return Container(
                              margin: EdgeInsets.all(0),
                              child: Card(
                                  elevation: cardViewElevation,
                                  child: Container(
                                      margin: EdgeInsets.all(5),
                                      child: Row(children: [
                                        CircleAvatar(
                                            radius: 25,
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.1),
                                            backgroundImage:
                                                ExactAssetImage(profileImage)),
                                        SizedBox(width: 5),
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
                                                    Text(
                                                        turnOfOrdering.userName,
                                                        style:
                                                            turnOfOrderingNameStyle),
                                                    Text(
                                                        turnOfOrdering.dateTime,
                                                        style: dateTimeStyle)
                                                  ]),
                                              Text(turnOfOrdering.recipeName,
                                                  style:
                                                      turnOfOrderingMenuStyle),
                                              Text(
                                                  '$availableOn ${turnOfOrdering.availableRecipe}',
                                                  style: menuAvailableStyle)
                                            ]))
                                      ]))));
                        }))));
  }
}
