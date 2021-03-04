import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:foodcafe/dependency_injection.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app_module.dart';
import 'resource/colors.dart';
import 'resource/routes.dart';
import 'shared/firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white));

  var appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  print(appDocPath);

  await GetStorage.init();

  DependencyInjection.init();
  await Firebase.initializeApp();

  var _firebaseService = FirebaseService();
  _firebaseService.initializeFirebase();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  //FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ScreenUtilInit(
      designSize: const Size(750, 812),
      allowFontScaling: false,
      builder: () => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          enableLog: true,
          theme: ThemeData(
              /*colorScheme: ColorScheme.light(
            primary: const Color(0xff263c7a),
            secondary: const Color(0xfffca311),
            onSecondary: Colors.black,
            onPrimary: Colors.white,
            primaryVariant: const Color(0xff00174d),
            secondaryVariant: const Color(0xffc37400)),*/
              scaffoldBackgroundColor: backgroundColor,
              brightness: Brightness.light,
              accentColor: accentColor,
              primaryColor: primaryColor,
              primarySwatch: primarySwatchColor),
          initialRoute: firstLaunchRoute,
          getPages: AppPages.pages));
}
