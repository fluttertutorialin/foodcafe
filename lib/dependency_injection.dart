import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodcafe/controller/controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'shared/http_hepler.dart';
import 'shared/provider/firestore_provider.dart';
import 'shared/provider/local_auth_provider.dart';
import 'shared/repository/firestore_database_repository.dart';
import 'shared/repository/local_auth_repository.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut<FirebaseFirestore>(() => FirebaseFirestore.instanceFor(app: Firebase.app()), fenix: true);
    Get.lazyPut<FirebaseAuth>(() => FirebaseAuth.instance, fenix: true);

    //SESSION BINDING
    Get.lazyPut<GetStorage>(() => GetStorage(), fenix: true);

    //NETWORK CONNECTION BINDING
    Get.lazyPut<NetworkController>(() => NetworkController(), fenix: true);

    //DIO BINDING
    Get.lazyPut<HttpHelper>(() => HttpHelper(), fenix: true);

    Get.lazyPut<LocalAuthProvider>(() => LocalAuthProvider(Get.find()), fenix: true);
    Get.lazyPut<LocalAuthRepository>(() => LocalAuthRepository(), fenix: true);

    //FIRESTORE BINDING
    Get.lazyPut<FireStoreDatabaseProvider>(() => FireStoreDatabaseProvider(Get.find(), Get.find(), Get.find()), fenix: true);
    Get.lazyPut<FireStoreDatabaseRepository>(() => FireStoreDatabaseRepository(), fenix: true);

  }
}
