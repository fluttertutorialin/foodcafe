import 'package:flutter/material.dart';
import 'package:foodcafe/controller/controller.dart';
import 'package:foodcafe/resource/colors.dart';
import 'package:foodcafe/resource/images.dart';
import 'package:foodcafe/resource/style.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';
import 'package:foodcafe/utils/extensions.dart';

class ReviewsPage extends StatelessWidget {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: appBarElevation,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(backIcon, size: 18, color: appBarTitleColor)),
            title: Text(titleReviews, style: appBarTitleStyle)),
        body: Obx(() => RefreshIndicator(
            key: _refreshKey,
            backgroundColor: refreshBackgroundColor,
            color: refreshColor,
            onRefresh: () async {
              if (ReviewsController.to.refreshStatus.value ==
                  RefreshStatus.SUCCESS) {
                _refreshKey.currentState.dispose();
              }

              if (ReviewsController.to.refreshStatus.value ==
                  RefreshStatus.INITIAL) {
                _refreshKey.currentState.show();
                ReviewsController.to.fetchReviews(isRefresh: true);
              }
            },
            child: ReviewsController.to.stateStatus.value == StateStatus.LOADING
                ? circleProgressIndicator()
                : ReviewsController.to.reviewsResponse.value.reviewsList.isEmpty
                    ? emptyWidget(message: dataNotTurnOfOrdering)
                    : ListView.builder(
                        itemCount: ReviewsController
                            .to.reviewsResponse.value.reviewsList.length,
                        itemBuilder: (context, index) {
                          var reviews = ReviewsController
                              .to.reviewsResponse.value.reviewsList[index];
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
                                                    Text(reviews.name,
                                                        style:
                                                            reviewsNameStyle),
                                                    Text(reviews.dateTime,
                                                        style: dateTimeStyle)
                                                  ]),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      color: Colors.deepOrange,
                                                      border: Border.all(
                                                          color:
                                                              Colors.red[500])),
                                                  padding: EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  child: Text('4.0',
                                                      style:
                                                          reviewsRattingCountStyle)),
                                              SizedBox(height: 5),
                                              Text(reviews.description,
                                                  style:
                                                      reviewsDescriptionStyle)
                                            ]))
                                      ]))));
                        }))));
  }
}
