import 'package:get/get.dart';
import 'binding/binding.dart';
import 'resource/routes.dart';
import 'ui/page/page.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: firstLaunchRoute,
        page: () => SplashPage(),
        binding: SplashBinding()),
    GetPage(
        name: onBoardingRoute,
        page: () => OnBoardingPage(),
        binding: OnBoardingBinding()),
    GetPage(name: loginRoute, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(
        name: signUpRoute, page: () => SignUpPage(), binding: SignUpBinding()),
    GetPage(
        name: forgotPasswordRoute,
        page: () => ForgotPasswordPage(),
        binding: ForgotPasswordBinding()),
    GetPage(
        name: changePasswordRoute,
        page: () => ChangePasswordPage(),
        binding: ChangePasswordBinding()),
    GetPage(
        name: profileEditRoute,
        page: () => ProfileEditPage(),
        binding: ProfileEditBinding()),
    GetPage(
        name: reportRoute, page: () => ReportPage(), binding: ReportBinding()),
    GetPage(name: accountsRoute, page: () => AccountsPage()),
    GetPage(
        name: supportRoute,
        page: () => SupportPage(),
        binding: SupportBinding()),
    GetPage(
        name: reviewsRoute,
        page: () => ReviewsPage(),
        binding: ReviewsBinding()),
    GetPage(
        name: walletRoute, page: () => WalletPage(), binding: WalletBinding()),
    GetPage(
        name: notificationRoute,
        page: () => NotificationPage(),
        binding: NotificationBinding()),
    GetPage(name: homeRoute, page: () => HomePage(), binding: HomeBinding()),
    GetPage(
        name: pastOrderRoute,
        page: () => PastOrderPage(),
        binding: PastOrderBinding()),
    GetPage(
        name: pastOrderDetailRoute,
        page: () => PastOrderDetailPage(),
        binding: PastOrderDetailBinging()),
    GetPage(
        name: newOrderRoute,
        page: () => NewOrderPage(),
        binding: NewOrderBinding()),
    GetPage(
        name: allFindRoute,
        page: () => AllFindPage(),
        binding: AllFindBinding()),
    GetPage(
        name: turnOfOrderingRoute,
        page: () => TurnOfOrderingPage(),
        binding: TurnOfOrderingBinding()),
    GetPage(
        name: birthDayRoute,
        page: () => BirthDayPage(),
        binding: BirthDayBinding())
  ];
}
