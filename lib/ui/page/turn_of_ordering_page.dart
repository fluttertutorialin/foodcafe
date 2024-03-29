import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../resource/colors.dart';
import '../../resource/images.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';
import '../../utils/state_status.dart';
import '../../utils/extensions.dart';

class TurnOfOrderingPage extends StatelessWidget {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  TurnOfOrderingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: appBarColor,
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
                  RefreshStatus.success) {
                _refreshKey.currentState.dispose();
              }

              if (TurnOfOrderingController.to.refreshStatus.value ==
                  RefreshStatus.initial) {
                _refreshKey.currentState.show();
                TurnOfOrderingController.to
                    .fetchTurnOfOrdering(isRefresh: true);
              }
            },
            child: TurnOfOrderingController.to.stateStatus.value ==
                    StateStatus.loading
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
