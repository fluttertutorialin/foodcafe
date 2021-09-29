import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../resource/colors.dart';
import '../../resource/images.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';
import '../../utils/state_status.dart';
import '../../utils/extensions.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: <
            Widget>[
      SliverToBoxAdapter(child: _topHeader()),
      Obx(() => ReportController.to.stateStatus.value == StateStatus.loading
              ? SliverFillRemaining(child: circleProgressIndicator())
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                  var report = ReportController.to.rxReportPastOrderList[index];
                  return Container(
                      margin: const EdgeInsets.only(top: 10),
                      color: Colors.grey.withOpacity(0.1),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(report.title,
                                      style: allReportLabelStyle(Colors.black)),
                                  Text(report.message,
                                      style: allReportDescriptionStyle(
                                          Colors.black.withOpacity(0.8)))
                                ]),
                            Text('${report.success}',
                                style: allReportCounterStyle(Colors.deepOrange))
                          ]));
                },
                      childCount:
                          ReportController.to.rxReportPastOrderList.length))
          /*SliverPadding(
                  padding: EdgeInsets.all(8.0),
                  sliver: SliverGrid.count(
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    crossAxisCount: 2,
                    childAspectRatio: 0.62,
                    children: list.map((model) => Container()).toList()
                  )
                )*/
          )
    ]));
  }

  _topHeader() {
    return Container(
        color: primarySwatchColor,
        child: Stack(children: [
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            _headerSetting(),
            const SizedBox(height: 16),
            _todayReportCounter(),
            const SizedBox(height: 13),
            _bottomVip()
          ])
        ]));
  }

  _headerSetting() => Padding(
      padding: const EdgeInsets.fromLTRB(10, 40, 0, 0),
      child: Row(children: [
        GestureDetector(
            onTap: () => {},
            child: const CircleAvatar(
                radius: 30, backgroundImage: ExactAssetImage(profileImage))),
        Expanded(
            flex: 1,
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(titleReport, style: titleReportStyle)]))),
        Expanded(
            flex: 0,
            child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(searchClearIcon, size: 18, color: Colors.white)))
      ]));

  _bottomVip() => Container(
      color: Colors.white.withOpacity(0.1),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(labelAllReport.toUpperCase(), style: todayReportStyle),
      ]));

  _todayReportCounter() => Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(children: [
          Text(drawerMenuPending, style: reportLabelStyle),
          const SizedBox(height: 3),
          Obx(() => Text('${ReportController.to.todayPendingOrderTotal.value}',
              style: reportCounterStyle))
        ]),
        Column(children: [
          Text(drawerMenuAccepted, style: reportLabelStyle),
          const SizedBox(height: 3),
          Obx(() => Text('${ReportController.to.todayAcceptedOrderTotal.value}',
              style: reportCounterStyle))
        ]),
        Column(children: [
          Text(drawerMenuReady, style: reportLabelStyle),
          const SizedBox(height: 3),
          Obx(() => Text('${ReportController.to.todayReadyOrderTotal.value}',
              style: reportCounterStyle))
        ]),
        Column(children: [
          Text(drawerMenuDispatched, style: reportLabelStyle),
          const SizedBox(height: 3),
          Obx(() => Text('${ReportController.to.todayDispatchedOrderTotal.value}',
              style: reportCounterStyle))
        ])
      ]));
}
