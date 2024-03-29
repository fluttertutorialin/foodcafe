import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../resource/colors.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';
import '../../ui/widget/custom_slidable/slidable.dart';
import '../../ui/widget/custom_slidable/slidable_action_pane.dart';
import '../../ui/widget/custom_slidable/slide_action.dart';
import '../../utils/state_status.dart';
import '../../utils/extensions.dart';

class KDSViewPage extends StatelessWidget {
  KDSViewPage({Key key}) : super(key: key);
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => RefreshIndicator(
        key: _refreshKey,
        backgroundColor: refreshBackgroundColor,
        color: refreshColor,
        onRefresh: () async {
          if (KDSViewController.to.refreshStatus.value ==
              RefreshStatus.success) {
            _refreshKey.currentState.show(atTop: false);
          }

          if (KDSViewController.to.refreshStatus.value ==
              RefreshStatus.initial) {
            _refreshKey.currentState.show();
            KDSViewController.to.fetchKDSView(isRefresh: true);
          }
        },
        child: listView(
            stateStatus: KDSViewController.to.stateStatus.value,
            dataNotFoundMessage: dataNotKDSViewMessage,
            length: KDSViewController.to.rxKDSViewList.length,
            itemBuilder: (BuildContext context, int index) {
              var kdsView = KDSViewController.to.rxKDSViewList[index];
              return Column(children: [
                Slidable(
                    actionPane: const SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: _itemMenuPause(
                        menu: kdsView.menuName,
                        stockCounter: kdsView.stockCounter),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                          caption: kdsView.isPause ? 'Pause' : 'Start',
                          color: Colors.deepOrange,
                          onTap: () {})
                    ]),
                Container(
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Dash(
                        length: Get.width - 35,
                        dashColor: Colors.grey,
                        dashThickness: 1,
                        dashLength: 2))
              ]);
            })));
  }

  _itemMenuPause({String menu, double stockCounter}) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 0.0, right: 10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(children: [
                          const SizedBox(width: 10),
                          Text(menu,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: kdsViewTitleStyle)
                        ]),
                        Text('$quantitySymbol $stockCounter',
                            style: kdsViewAmountStyle)
                      ]))
            ]));
  }
}
