import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../resource/colors.dart';
import '../../resource/images.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';
import '../../utils/state_status.dart';
import '../../utils/extensions.dart';

class ReviewsPage extends StatelessWidget {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  ReviewsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: appBarColor,
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
                  RefreshStatus.success) {
                _refreshKey.currentState.dispose();
              }

              if (ReviewsController.to.refreshStatus.value ==
                  RefreshStatus.initial) {
                _refreshKey.currentState.show();
                ReviewsController.to.fetchReviews(isRefresh: true);
              }
            },
            child: ReviewsController.to.stateStatus.value == StateStatus.loading
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
                                                  padding: const EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  child: Text('4.0',
                                                      style:
                                                          reviewsRattingCountStyle)),
                                              const SizedBox(height: 5),
                                              Text(reviews.description,
                                                  style:
                                                      reviewsDescriptionStyle)
                                            ]))
                                      ]))));
                        }))));
  }
}
