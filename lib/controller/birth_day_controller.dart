import 'package:get/get.dart';
import '../controller/controller.dart';
import '../model/birth_day/birth_day_response.dart';
import '../utils/state_status.dart';

class BirthDayController extends GetxController {
  static BirthDayController get to => Get.find();
  var stateStatus = Rx<StateStatus>(StateStatus.initial);
  var refreshStatus = Rx<RefreshStatus>(RefreshStatus.initial);

  var birthDayResponse = Rx<BirthDayResponse>(BirthDayResponse());

  @override
  onInit() {
    super.onInit();
    fetchBirthDay();
  }

  Future<void> fetchBirthDay({bool isRefresh = false}) async {
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.loading;
    }
    stateStatus.value = StateStatus.loading;

    var birthDayResponse = BirthDayResponse(birthDayList: [
      BirthDay(
          uniqueId: '1',
          name: 'Lakhani kamlesh',
          address: 'To. Ravani (Kuba)',
          birthDate: '20-12-1990',
          mobile: '9586331823',
          profilePictureUrl: '',
          year: 29,
          isSentMessage: false),
      BirthDay(
          uniqueId: '2',
          name: 'Lakhani nayan',
          address: 'To. Ravani (Kuba)',
          birthDate: '20-12-1990',
          mobile: '9586331823',
          profilePictureUrl: '',
          year: 29,
          isSentMessage: false)
    ]);

    await Future.delayed(const Duration(seconds: 2));
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.success;
      refreshStatus.value = RefreshStatus.initial;
    }

    stateStatus.value = StateStatus.success;

    this.birthDayResponse.value = birthDayResponse;
  }

  void birthDayWish({BirthDay birthDay}) {
    birthDay.birthDayWishName = HomeController.to.secureStorageUserNameRx.value;
    birthDay.isSentMessage.value = true;
  }
}
