import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodcafe/controller/controller.dart';
import 'package:foodcafe/resource/colors.dart';
import 'package:foodcafe/resource/images.dart';
import 'package:foodcafe/resource/style.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';
import 'package:foodcafe/utils/extensions.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      bottomNavigationBar: Container(
          padding: EdgeInsets.all(10),
          color: Colors.deepOrange,
          margin: EdgeInsets.only(top: 10),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white.withOpacity(0.1),
                    border: Border.all(color: Colors.white.withOpacity(0.1))),
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
                child: Row(children: [
                  Text(sentToBankButton, style: walletSentToBank)
                ])),
            SizedBox(width: 20),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                    border: Border.all(color: Colors.deepOrange)),
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
                child: Row(children: [
                  Text(addMoneyButton, style: walletAddMoneyStyle)
                ]))
          ])),
      body:
          CustomScrollView(physics: BouncingScrollPhysics(), slivers: <Widget>[
        SliverAppBar(
            pinned: true,
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: Container(
                    alignment: Alignment.center,
                    child: Column(children: [
                      Text(labelAvailableBalance, style: walletAvailableBalance),
                      Text('$rsSymbol ${00}', style: walletBalanceRsStyle)
                    ]))),
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(backIcon, color: appBarTitleColor)),
            stretch: true,
            elevation: appBarElevation,
            expandedHeight: 50.0,
            backgroundColor: Colors.white),
        Obx(() => WalletController.to.stateStatus.value == StateStatus.LOADING
            ? SliverFillRemaining(child: circleProgressIndicator())
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                var wallet = WalletController.to.rxWalletList[index];
                return Card(
                    elevation: cardViewElevation,
                    child: Container(
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, left: 10, right: 0),
                        child: IntrinsicHeight(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('$labelOrderId ${wallet.uniqueId}',
                                            style: idStyle),
                                        Text(wallet.dateTime,
                                            style: dateTimeStyle),
                                        Row(children: [
                                          if (wallet.totalItems > 0)
                                            Wrap(children: [
                                              Text(
                                                  '${wallet.totalItems} $labelItems',
                                                  style: walletTotalItems),
                                              SizedBox(width: 10)
                                            ]),
                                          Text('$rsSymbol ${wallet.amount}',
                                              style: totalPayStyle)
                                        ])
                                      ])),
                              Center(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              bottomLeft:
                                                  Radius.circular(10.0)),
                                          color: Colors.grey.withOpacity(0.1),
                                          border:
                                              Border.all(color: Colors.white)),
                                      padding: EdgeInsets.only(
                                          left: 5, right: 5, top: 2, bottom: 2),
                                      child: Text(
                                          wallet.orderStatus.toUpperCase(),
                                          style: walletStatusStyle(wallet
                                              .orderStatus
                                              .toLowerCase()
                                              .pastOrderColor()))))
                            ]))));
              }, childCount: WalletController.to.rxWalletList.length)))
      ]));
}
