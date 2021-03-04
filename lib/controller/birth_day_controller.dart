import 'package:foodcafe/controller/controller.dart';
import 'package:foodcafe/model/birth_day/birth_day_response.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';

class BirthDayController extends GetxController {
  static BirthDayController get to => Get.find();
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);
  var refreshStatus = Rx<RefreshStatus>(RefreshStatus.INITIAL);

  var birthDayResponse = Rx<BirthDayResponse>();

  @override
  onInit() {
    super.onInit();
    fetchBirthDay();
  }

  Future<void> fetchBirthDay({bool isRefresh = false}) async {
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.LOADING;
    }
    stateStatus.value = StateStatus.LOADING;

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

    await Future.delayed(Duration(seconds: 2));
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.SUCCESS;
      refreshStatus.value = RefreshStatus.INITIAL;
    }

    stateStatus.value = StateStatus.SUCCESS;

    this.birthDayResponse.value = birthDayResponse;
  }

  void birthDayWish({BirthDay birthDay}) {
    birthDay.birthDayWishName = HomeController.to.secureStorageUserName.value;
    birthDay.isSentMessage.value = true;
  }
}
