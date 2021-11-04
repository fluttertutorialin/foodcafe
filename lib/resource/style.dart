import 'package:flutter/material.dart';
import 'colors.dart';
import 'font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//TITLE STYLE
var splashTitleStyle = TextStyle(fontSize: 70.sp, color: appBarTitleColor, fontFamily: mediumFont);
var appBarTitleStyle = TextStyle(fontSize: 36.sp, color: appBarTitleColor, fontFamily: mediumFont);
var appBarSubTitleStyle = TextStyle(fontSize: 30.sp, color: Colors.grey, fontFamily: mediumFont);
var appBarAddressStyle = TextStyle(fontSize: 24.sp, color: appBarAddressColor, fontFamily: mediumFont);
var countStyle = TextStyle(fontSize: 16.sp, color: countColor, fontFamily: mediumFont);
var descriptionStyle = TextStyle(fontSize: 32.sp, color: Colors.black, fontFamily: regularFont);

//NOT FOUND
var dataNotAvailableStyle = TextStyle(fontSize: 18.h, color: Colors.black, fontFamily: semiBoldFont);
var searchDataNotAvailableStyle = TextStyle(fontSize: 18.h, color: searchDataNotAvailableColor, fontFamily: regularFont);

var notificationTitleStyle = TextStyle(fontSize: 40.sp, color: Colors.white, fontFamily: mediumFont);
var totalNotificationStyle = TextStyle(fontSize: 50.sp, color: Colors.white, fontFamily: mediumFont);
var getNotificationTitleStyle = TextStyle(fontSize: 36.sp, color: Colors.black, fontFamily: mediumFont);
var getNotificationDescriptionStyle = TextStyle(fontSize: 30.sp, color: Colors.black, fontFamily: regularFont);

//BUTTON STYLE
var btnOkStyle = TextStyle(fontSize: 30.sp, color: Colors.black, fontFamily: mediumFont);
var btnCloseStyle = TextStyle(fontSize: 30.sp, color: Colors.red, fontFamily: mediumFont);
var btnFindStyle = TextStyle(fontSize: 25.sp, color: Colors.black, fontFamily: mediumFont);
var btnOnBoardingStyle = TextStyle(fontSize: 30.sp, color: accentColor, fontFamily: mediumFont);

//TOAST STYLE
flushBarMessageStyle(Color color) => TextStyle(fontSize: 24.sp, color: color, fontFamily: mediumFont);
flushBarTitleStyle(Color color) => TextStyle(fontSize: 28.sp, color: color, fontFamily: semiBoldFont);

//ON BOARDING STYLE
var onBoardingTitleStyle = TextStyle(fontSize: 40.sp, color: Colors.black, fontFamily: semiBoldFont);
var onBoardingMessageStyle = TextStyle(fontSize: 32.sp, color: Colors.black54, fontFamily: mediumFont);

//LINK STYLE
doNotHaveAccountStyle(Color color) => TextStyle(fontSize: 30.sp, color: color, fontFamily: regularFont);
loginLinkStyle(Color color) => TextStyle(fontSize: 30.sp, fontFamily: mediumFont, color: color);

//TAB STYLE
var tabSelectStyle = const TextStyle(fontSize: 14, fontFamily: mediumFont);
var tabUnSelectStyle = const TextStyle(fontSize: 12, fontFamily: mediumFont);

//DRAWER STYLE
var drawerMenuStyle = TextStyle(fontSize: 30.sp, color: Colors.black, fontFamily: regularFont);
var drawerUserNameStyle = TextStyle(fontSize: 32.sp, color: appBarTitleColor, fontFamily: semiBoldFont);
var drawerEmailStyle = TextStyle(fontSize: 24.sp, color: Colors.black, fontFamily: semiBoldFont);

var idStyle = TextStyle(fontSize: 24.sp, color: Colors.black, fontFamily: mediumFont);
var deliveryType = TextStyle(fontSize: 28.sp, color: Colors.deepOrange, fontFamily: mediumFont);
var menuNameStyle = TextStyle(fontSize: 28.sp, color: Colors.black, fontFamily: regularFont);
var orderTypeStyle = TextStyle(fontSize: 30.sp, color: Colors.grey, fontFamily: regularFont);
var menuPriceStyle = TextStyle(fontSize: 24.sp, color: Colors.grey, fontFamily: regularFont);
var dateTimeStyle = TextStyle(fontSize: 24.sp, color: Colors.blueGrey, fontFamily: regularFont);
var timeCalculationStyle = TextStyle(fontSize: 20.sp, color: Colors.grey, fontFamily: regularFont);
var quantitySymbolStyle = TextStyle(fontSize: 28.sp, color: Colors.grey, fontFamily: regularFont);
var quantityStyle = TextStyle(fontSize: 24.sp, color: Colors.grey, fontFamily: regularFont);
var paymentPaidStatusStyle = TextStyle(fontSize: 30.sp, color: Colors.green, fontFamily: mediumFont);
var paymentCollectStyle = TextStyle(fontSize: 24.sp, color: Colors.black, fontFamily: mediumFont);
var totalQuantityStyle = TextStyle(fontSize: 28.sp, color: Colors.grey, fontFamily: mediumFont);
var totalAmountStyle = TextStyle(fontSize: 30.sp, color: Colors.black, fontFamily: mediumFont);
var orderStatusLinkStyle = TextStyle(fontSize: 24.sp, color: Colors.blue, fontFamily: mediumFont);
var preparationTimeStyle = TextStyle(fontSize: 24.sp, color: Colors.grey, fontFamily: mediumFont);
var preparationTimeMinHourStyle = TextStyle(fontSize: 24.sp, color: Colors.grey, fontFamily: mediumFont);
var preparationTimeUnSelectStyle = TextStyle(fontSize: 30.sp, color: preparationTimeUnSelectColor, fontFamily: regularFont);
var preparationTimeSelectStyle = TextStyle(fontSize: 30.sp, color: preparationTimeSelectColor, fontFamily: mediumFont);

var orderUserNameStyle = TextStyle(fontSize: 28.sp, color: Colors.black, fontFamily: mediumFont);
var orderUserKMStyle = TextStyle(fontSize: 24.sp, color: Colors.grey, fontFamily: mediumFont);
var orderUserAddressStyle = TextStyle(fontSize: 20.sp, color: Colors.grey, fontFamily: quicksandMediumFont);
var orderReachTimeStyle = TextStyle(fontSize: 30.sp, color: Colors.black, fontFamily: quicksandRegularFont);
var orderReachTextStyle = TextStyle(fontSize: 24.sp, color: Colors.black, fontFamily: quicksandMediumFont);

var orderStatusStyle = TextStyle(fontSize: 24.sp, color: orderStatusColor, fontFamily: semiBoldFont);
var deliveryPersonStyle = TextStyle(fontSize: 24.sp, color: orderStatusColor, fontFamily: semiBoldFont);

var deliveryPersonNameStyle = TextStyle(fontSize: 28.sp, color: Colors.black, fontFamily: mediumFont);
var arrivingMinuteStyle = TextStyle(fontSize: 24.sp, color: Colors.grey, fontFamily: regularFont);
var otpLabelStyle = TextStyle(fontSize: 24.sp, color: Colors.blueGrey, fontFamily: regularFont);
var deliveryTypeSelectStyle = TextStyle(
    fontSize: 28.sp, color: appBarTitleColor, fontFamily: semiBoldFont);
var deliveryTypeUnSelectStyle = TextStyle(fontSize: 28.sp, color: Colors.black, fontFamily: semiBoldFont);
var deliveryTypeNameUnSelectStyle = TextStyle(fontSize: 24.sp, color: Colors.black, fontFamily: mediumFont);
var deliveryTypeNameSelectStyle = TextStyle(fontSize: 24.sp, color: appBarTitleColor, fontFamily: mediumFont);
var deliveryBottomPersonNameSelectStyle = TextStyle(fontSize: 28.sp, color: Colors.black, fontFamily: mediumFont);
var deliveryBottomPersonNameUnSelectStyle = TextStyle(fontSize: 28.sp, color: appBarTitleColor, fontFamily: mediumFont);

var pauseMenuTitleStyle = TextStyle(fontSize: 32.sp, color: pauseMenuTitleColor, fontFamily: mediumFont);
var switchLabelStyle = TextStyle(fontSize: 28.sp, color: switchLabelColor, fontFamily: regularFont);
var menuAvailableStyle = TextStyle(fontSize: 24.sp, color: menuAvailableColor, fontFamily: semiBoldFont);
var groupByParentNameStyle = TextStyle(fontSize: 30.sp, color: switchLabelColor, fontFamily: semiBoldFont);

pastOrderStatusStyle(Color color) => TextStyle(fontSize: 24.sp, color: color, fontFamily: regularFont);
var dropDownTextStyle = TextStyle(fontSize: 28.sp, color: Colors.black, fontFamily: regularFont);
var pastOrderRefundableStyle = TextStyle(fontSize: 30.sp, color: Colors.black, fontFamily: mediumFont);
var pastOrderRemarkStyle = TextStyle(fontSize: 28.sp, color: Colors.black, fontFamily: mediumFont);
var pastOrderRemarkCommentStyle = TextStyle(fontSize: 24.sp, color: Colors.black, fontFamily: regularFont);
var pastOrderNameStyle = TextStyle(fontSize: 30.sp, color: Colors.black, fontFamily: semiBoldFont);
var pastOrderEmailStyle = TextStyle(fontSize: 26.sp, color: Colors.black54, fontFamily: mediumFont);
var pastOrderAddressStyle = TextStyle(fontSize: 26.sp, color: Colors.black54, fontFamily: regularFont);

var turnOfOrderingMenuStyle = TextStyle(fontSize: 30.sp, color: switchLabelColor, fontFamily: regularFont);
var turnOfOrderingNameStyle = TextStyle(fontSize: 30.sp, color: switchLabelColor, fontFamily: mediumFont);

var bottomSheetPauseMenuTitleStyle = TextStyle(fontSize: 36.sp, color: Colors.black, fontFamily: mediumFont);
var bottomSheetPauseMenuDescriptionStyle = TextStyle(fontSize: 30.sp, color: Colors.black, fontFamily: regularFont);
var bottomSheetPauseMenuOrderOnOffTimerLabelStyle = TextStyle(fontSize: 30.sp, color: Colors.black, fontFamily: regularFont);

var kdsViewTitleStyle = TextStyle(fontSize: 28.sp, color: Colors.black, fontFamily: regularFont);
var kdsViewAmountStyle = TextStyle(fontSize: 28.sp, color: Colors.black, fontFamily: mediumFont);

var totalStyle = TextStyle(fontSize: 28.sp, color: Colors.black54, fontFamily: regularFont);
var totalCountStyle = TextStyle(fontSize: 32.sp, color: Colors.black54, fontFamily: mediumFont);

var titleReportStyle = TextStyle(fontSize: 36.sp, color: Colors.white, fontFamily: semiBoldFont);

var todayReportStyle = TextStyle(fontSize: 24.sp, color: Colors.white, fontFamily: regularFont);
var reportDateStyle = TextStyle(fontSize: 24.sp, color: Colors.white, fontFamily: mediumFont);
var reportLabelStyle = TextStyle(fontSize: 24.sp, color: Colors.white54, fontFamily: semiBoldFont);
var reportCounterStyle = TextStyle(fontSize: 36.sp, color: Colors.white, fontFamily: regularFont);
var assignYouStyle = TextStyle(fontSize: 30.sp, color: Colors.black, fontFamily: semiBoldFont);

var pastOrderDetailLabelStyle = TextStyle(fontSize: 28.sp, color: Colors.black45, fontFamily: semiBoldFont);

var birthDayCounterStyle = TextStyle(fontSize: 20.sp, color: Colors.white, fontFamily: semiBoldFont);
birthDayInformStyle(Color color) => TextStyle(fontSize: 28.sp, color: color, fontFamily: regularFont);

allReportLabelStyle(Color color) => TextStyle(fontSize: 36.sp, color: color, fontFamily: semiBoldFont);
allReportDescriptionStyle(Color color) => TextStyle(fontSize: 28.sp, color: color, fontFamily: mediumFont);
allReportCounterStyle(Color color) => TextStyle(fontSize: 36.sp, color: color, fontFamily: regularFont);

var supportTitleStyle = TextStyle(fontSize: 50.sp, color: appBarTitleColor, fontFamily: quicksandBoldFont);
var supportSubTitleStyle = TextStyle(fontSize: 30.sp, color: Colors.grey, fontFamily: mediumFont);
var supportSentMessageTitleStyle = TextStyle(fontSize: 36.sp, color: Colors.black, fontFamily: semiBoldFont);
var supportCallNowStyle = TextStyle(fontSize: 30.sp, color: Colors.white, fontFamily: mediumFont);

var reviewsNameStyle = TextStyle(fontSize: 28.sp, color: switchLabelColor, fontFamily: quicksandBoldFont);
var reviewsRattingCountStyle = TextStyle(fontSize: 22.sp, color: Colors.white, fontFamily: quicksandBoldFont);
var reviewsDescriptionStyle = TextStyle(fontSize: 28.sp, color: switchLabelColor, fontFamily: regularFont);

var walletSentToBank = TextStyle(fontSize: 30.sp, color: Colors.white, fontFamily: mediumFont);
var walletAddMoneyStyle = TextStyle(fontSize: 30.sp, color: Colors.deepOrange, fontFamily: mediumFont);
var walletAvailableBalance = TextStyle(fontSize: 30.sp, color: Colors.black, fontFamily: semiBoldFont);
var walletBalanceRsStyle = TextStyle(fontSize: 50.sp, color: Colors.black54, fontFamily: regularFont);
var walletTotalItems = TextStyle(fontSize: 24.sp, color: Colors.black, fontFamily: semiBoldFont);
var totalPayStyle = TextStyle(fontSize: 30.sp, color: Colors.deepOrange, fontFamily: regularFont);walletStatusStyle(Color color) => TextStyle(fontSize: 24.sp, color: color, fontFamily: semiBoldFont);

//decoration
var preparationTimeDecoration = BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(3.0)),
    border: Border.all(color: preparationTimeDecorationColor, width: 1));
