import 'dart:ui';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../resource/colors.dart';
import '../../resource/images.dart';
import '../../resource/routes.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
          body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
        SliverAppBar(
            pinned: true,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(backIcon, color: appBarTitleColor)),
            stretch: true,
            elevation: appBarElevation,
            expandedHeight: 200.0,
            backgroundColor: Colors.white,
            title: Text(titleAccounts, style: appBarTitleStyle),
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(fit: StackFit.expand, children: <Widget>[
              Image.asset(accountsTopImage, fit: BoxFit.cover),
              DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topRight,
                          colors: <Color>[
                    Colors.deepOrange.withOpacity(0.5),
                    const Color(0x00000000)
                  ])))
            ]))),
        SliverToBoxAdapter(
            child: Container(
                color: Colors.white,
                margin: const EdgeInsets.only(top: 10),
                child: InkWell(
                    onTap: () => Get.toNamed(turnOfOrderingRoute),
                    child: ListTile(
                      leading: Icon(pauseMenuIcon),
                      title: Text(titleTurnOfOrdering,
                          style: allReportLabelStyle(Colors.deepOrange)),
                      subtitle: Text(labelTurnOfOrder,
                          style: allReportDescriptionStyle(
                              Colors.black.withOpacity(0.8))),
                    )))),
        SliverToBoxAdapter(
            child: Container(
                color: Colors.white,
                margin: const EdgeInsets.only(top: 10),
                child: InkWell(
                    onTap: () => Get.toNamed(reportRoute),
                    child: ListTile(
                      leading: const Icon(LineIcons.dashboard),
                      title: Text(titleReport,
                          style: allReportLabelStyle(Colors.deepOrange)),
                      subtitle: Text(labelReport,
                          style: allReportDescriptionStyle(
                              Colors.black.withOpacity(0.8))),
                    )))),
        SliverToBoxAdapter(
            child: Container(
                color: Colors.white,
                margin: const EdgeInsets.only(top: 10),
                child: InkWell(
                    onTap: () => Get.toNamed(walletRoute),
                    child: ListTile(
                      leading: const Icon(LineIcons.rupee),
                      title: Text(titleWallet,
                          style: allReportLabelStyle(Colors.deepOrange)),
                      subtitle: Text(labelWallet,
                          style: allReportDescriptionStyle(
                              Colors.black.withOpacity(0.8))),
                    )))),
        SliverToBoxAdapter(
            child: Container(
                color: Colors.white,
                margin: const EdgeInsets.only(top: 10),
                child: InkWell(
                    onTap: () => Get.toNamed(reviewsRoute),
                    child: ListTile(
                      leading: const Icon(LineIcons.archive),
                      title: Text(titleReviews,
                          style: allReportLabelStyle(Colors.deepOrange)),
                      subtitle: Text(labelReviews,
                          style: allReportDescriptionStyle(
                              Colors.black.withOpacity(0.8))),
                    )))),
        SliverToBoxAdapter(
            child: Container(
                color: Colors.white,
                margin: const EdgeInsets.only(top: 10),
                child: InkWell(
                    child: ListTile(
                      leading: Icon(changePasswordIcon),
                      title: Text(titleChangePassword,
                          style: allReportLabelStyle(Colors.deepOrange)),
                      subtitle: Text(labelChangePassword,
                          style: allReportDescriptionStyle(
                              Colors.black.withOpacity(0.8))),
                    ),
                    onTap: () => Get.toNamed(changePasswordRoute)))),
        SliverToBoxAdapter(
            child: Container(
                color: Colors.white,
                margin: const EdgeInsets.only(top: 10),
                child: InkWell(
                    onTap: () => Get.toNamed(supportRoute),
                    child: ListTile(
                      leading: const Icon(LineIcons.mobile),
                      title: Text(titleSupport,
                          style: allReportLabelStyle(Colors.deepOrange)),
                      subtitle: Text(labelSupport,
                          style: allReportDescriptionStyle(
                              Colors.black.withOpacity(0.8))),
                    )))),
        SliverToBoxAdapter(
            child: Container(
                color: Colors.white,
                margin: const EdgeInsets.only(top: 10),
                child: ListTile(
                  leading: const Icon(LineIcons.share_alt_square),
                  title: Text(titleShareApp,
                      style: allReportLabelStyle(Colors.deepOrange)),
                  subtitle: Text(labelShareApp,
                      style: allReportDescriptionStyle(
                          Colors.black.withOpacity(0.8))),
                ))),
      ]));
}
