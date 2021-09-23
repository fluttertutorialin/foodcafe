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
        page: () => const OnBoardingPage(),
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
        name: reportRoute, page: () => const ReportPage(), binding: ReportBinding()),
    GetPage(name: accountsRoute, page: () => const AccountsPage()),
    GetPage(
        name: supportRoute,
        page: () => SupportPage(),
        binding: SupportBinding()),
    GetPage(
        name: reviewsRoute,
        page: () => ReviewsPage(),
        binding: ReviewsBinding()),
    GetPage(
        name: walletRoute, page: () => const WalletPage(), binding: WalletBinding()),
    GetPage(
        name: notificationRoute,
        page: () => const NotificationPage(),
        binding: NotificationBinding()),
    GetPage(name: homeRoute, page: () => const HomePage(), binding: HomeBinding()),
    GetPage(
        name: pastOrderRoute,
        page: () => PastOrderPage(),
        binding: PastOrderBinding()),
    GetPage(
        name: pastOrderDetailRoute,
        page: () => const PastOrderDetailPage(),
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
