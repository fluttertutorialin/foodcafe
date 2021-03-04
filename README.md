# foodcafe application

0) Path set java: Path - still bin
   flutter path Mac: export PATH="$PATH:/Users/mac/Documents/flutter/bin"

1) flutter pub pub run flutter_automation --android-sign
2) CN="Kamlesh Lakhani", OU=1, O=jdkgroup, L=Ahmedabad, S=Gujarat, C=91

3) keytool -list -v -keystore C:/Users/Kamlesh/AndroidStudioProjects/food_cafe\keys/keystore.jks -alias aliasName -storepass password -keypass password

4) SH1 KEY
   Debug
   12:7B:3B:C3:C6:B7:45:24:0C:4E:36:AE:2E:D4:40:47:C8:A3:03:E6

   MAC
   D6:B3:2C:C7:FD:70:60:B4:35:99:4A:BD:2D:B5:76:60:01:65:4D:65

   Release
   68:D1:6B:62:50:AA:E3:16:6E:5E:D7:77:0C:AD:5D:94:8C:AA:13:B0

6) Application detail:
   package name: com.jdkgroup.food_cafe

7) CMD Command MAC:
   Get flutter version: /Library/Software/flutter/bin/flutter --version

8) release apk run
   flutter run --release

9) Create model class
   1) part 'login_response.g.dart'; //Model class file name write
   2) @JsonSerializable()
   3) @JsonKey(name: 'title', defaultValue: '') //add the default value

   Terminal command
   4) flutter pub run build_runner build

10) API CALL
    login_controller.dart check the function callLogin(), api call and pass the parameter body.

11) GetX
     Instantiate your class using Get.put() to make it available for all "child" routes there.
     var _homeController = Get.put(HomeController());

12) Change package name
    1) 1 rename package
       - Terminal command
         pub global activate rename
         pub global run rename --bundleId com.food.appname

       - pubspec.yaml change
         pubspec.yaml: First line add name: foodcafe
         For example: com.food.appname
         name: appname

    2) 2 way rename package
       --------------------
    1) Create new project
       COPY FILES: assets, lib, pubspec.yaml.
       - pubspec.yaml: First line not add name: foodcafe
    2) SH1 generate get the debug and release key put firebase.
    3) Firebase add the project.
    4) android > app > build.gradle : Add the code
       dependencies {
           implementation platform('com.google.firebase:firebase-bom:26.2.0')

           implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
           implementation 'com.android.support:multidex:1.0.3'
           implementation 'com.google.firebase:firebase-crashlytics'
           implementation 'com.google.firebase:firebase-analytics'
       }
       apply plugin: 'com.google.gms.google-services'
       apply plugin: 'com.google.firebase.crashlytics'
       com.google.gms.googleservices.GoogleServicesPlugin
   5) android > build.gradle : Add the code
      dependencies {
          classpath 'com.android.tools.build:gradle:4.1.0'
          classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
          classpath 'com.google.gms:google-services:4.3.4'
          classpath 'com.google.firebase:firebase-crashlytics-gradle:2.4.1'
      }
   6) change launcher/application icon:
      1) add icon assets > images:
         - Icon name must be food_cafe.png. Size 192 * 192.
      2) Terminal command
      flutter pub get
      flutter pub run flutter_launcher_icons:main
   7) Change splash screen name lib > resource > value
      current name: const String appName = 'Food Cafe';
   8) Release apk create
      - Terminal command: flutter build apk --release

LOGIC PART
1) Preparation Time
   if value % 10 == 0 value selected display else un-select press the button + or -.
   Plus: Increment 5
   Minus: Decrement 5

   function of preparation:
   1) preparationTimeSelect()
   2) preparationTimePlus()
   3) preparationTimeMinus
   4) _preparationTimeSelectUnSelect() //value % 10 == 0 select else unSelect

2) Biker boy / Delivery boy information
   class name: DeliveryPersonInformation

3) class name
   Syntax
   ------
   Reactive syntax GetX

   var search = Rx<String>('');
   var search = Rx<String>('');
   var rxReadyList = RxList<OrderMainList>([]);

4) Common
   ------
   1) Extensions
   - DynamicUtil: toast
     ContextExtensions: showProgress, hideProgress
     ImageSource: ImagePickerCameraGallery
     int: dateTimeyyyyMMddhhmma
     ValiationExtensions: pastOrderColor, mobileCalling, validateEmail, validatePassword, validateMobile, validUserName, validateAddress,
                          validateMessage, validatePinCode, validateCurrentPassword, validateNewPassword, validationEqual
     - Widget: inputField, circleProgressIndicator, emptyWidget, listView, listViewBuilder, emptySearchWidget, socialIcon, roundCircleButton, customFloatForm

   - extension method use:
     import 'package:foodcafe/utils/extensions.dart';

     stateless class: functionName();
     stateful class: widget.functionName();

   2) Pull refresh (Pending, accepted, ready, dispatched, All Find, Past Order, New Order, KDS View, Birthday Wishes, Turn of Ordering, Reviews)

   3) LazyPut getx
     class DependencyInjection {
       static void init() {
         Get.lazyPut<FirebaseFirestore>(() => FirebaseFirestore.instance, fenix: false);
         Get.lazyPut<FirebaseAuth>(() => FirebaseAuth.instance, fenix: false);
         Get.lazyPut<GetStorage>(() => GetStorage(), fenix: true);

         //DIO
         Get.lazyPut<HttpHelper>(() => HttpHelper(), fenix: false);

         //SECURE STORAGE
         Get.lazyPut<LocalAuthProvider>(() => LocalAuthProvider(Get.find()), fenix: true);
         Get.lazyPut<LocalAuthRepository>(() => LocalAuthRepository(), fenix: true);

         //FIRESTORE
         Get.lazyPut<FireStoreDatabaseProvider>(() => FireStoreDatabaseProvider(Get.find(), Get.find(), Get.find()), fenix: true);
         Get.lazyPut<FireStoreDatabaseRepository>(() => FireStoreDatabaseRepository(), fenix: true);
       }
     }

5) Bottom navigation bar (home_page.dart)
   ---------------------
   class name and function name:
   - _bottomNavigationBar()
   Notification 2 ways:
   - notification set bottom navigation bar, function name _notification()
     1) Change the notification counter every 1 minute. (Bottom tab counter - notification_min_controller.dart)
     2) Firebase using NotificationFirebaseController (notification_firebase_controller.dart)
   - All find (all_find_page.dart) and search common 4 tab.

   Tab 1) Pending (pending_page.dart)
          - Order confirm (ACCEPT).
          - Functionality: order reject, order accept, extra order item, information icon click, preparation timer select, customer details (name, address, kilo meter).
   Tab 2) Accepted (accepted_page.dart)
          - Food ready (FOOD READY).
          - Functionality: Order reject, order food ready, delivery person select.
   Tab 3) Ready (ready_page.dart)
          - Dispatch order (DISPATCH).
          - Functionality: order reject, order dispatch, delivery person details, customer details.
   Tab 4) Dispatched (dispatched_page.dart)
          - Get the order customer (SETTLE ORDER).
          - Functionality: order reject, order settle order, delivery person details, customer details.

6) Drawer Menu
   -----------
   drawer class name: drawer_menu.dart

   1) Pause Menu (pause_menu_page.dart)
      - Turn of order likes online offline order, any recipe on off
   2) Past Order (past_order_page.dart)
      - past order show the history current day.
   3) New order (new_order_page.dart, display only new pending data.)
      - New order display list same as pending tab.
   4) KDS View (kds_view_page.dart)
      - Stock display and start the order.
   5) Birthday wishes (birth_day_page.dart)
      - Birthday boy wishes call or message.
   6) Accounts (accounts_page.dart)
   7) Logout exit dialog name: dialog_exit.dart
   8) Notification (notification_page.dart)
   9) Profile edit (profile_edit_page.dart)

7) Accounts
   1) Turn of ordering (turn_of_ordering_page.dart)
      - Pause menu order turn of show details.
   2) Report (report_page.dart)
      - current and total order show likes pending, accepted, ready, dispatched.
   3) Wallet (wallet_page.dart)
      - Available balance, sent to bank, add money.
   4) Reviews (reviews_page.dart)
      - Users reviews list display.
   5) Change password (change_password_page.dart)
   6) Support (support_page.dart)
      - Query & feedbacks, call.
   7) Share App

NOTE
json.decode(): Builds Dart objects from a string containing JSON data.
json.encode(): Serializes a Dart object into a JSON string.