import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodcafe/resource/api.dart';
import 'package:get/get.dart';
import 'repository/local_auth_repository.dart';

class FirebaseService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  var _localAuthRepository = Get.find<LocalAuthRepository>();

  Future<void> initializeFirebase() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    String token = await FirebaseMessaging.instance.getToken();

    //String getAPNSToken = await FirebaseMessaging.instance.getToken();
    await saveTokenToDatabase(token);

    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var notification = message.notification;

      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  _channel.id, _channel.name, _channel.description,
                  icon: 'launch_background')));
    });
  }

  final _channel = AndroidNotificationChannel(
    'foodcafe', // id
    '956888614965', // title
    '', // description
    importance: Importance.high,
    playSound: true,
  );

  Future<void> saveTokenToDatabase(String token) async {
    _localAuthRepository.writeSession(SECURE_STORAGE_FIREBASE_TOKEN, token);
  }
}
