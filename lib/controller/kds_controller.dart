import 'package:foodcafe/model/kdsview/KDSView.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';

class KDSViewController extends GetxController {
  static KDSViewController get to => Get.find();

  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);
  var refreshStatus = Rx<RefreshStatus>(RefreshStatus.INITIAL);

  var rxKDSViewList = RxList<KDSView>([]);

  @override
  onInit() {
    super.onInit();
    fetchKDSView();
  }

  Future<void> fetchKDSView({bool isRefresh = false}) async {
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.LOADING;
    }

    stateStatus.value = StateStatus.LOADING;

    var kdsViewResponse = KDSViewResponse(kdsViewList: [
      KDSView(
          id: '001',
          menuName: 'Chicken biryaani',
          stockCounter: 12,
          isPause: false)
    ]);

    await Future.delayed(Duration(seconds: 2));

    if (isRefresh) {
      refreshStatus.value = RefreshStatus.SUCCESS;
      refreshStatus.value = RefreshStatus.INITIAL;
    }

    stateStatus.value = StateStatus.SUCCESS;

    rxKDSViewList.assignAll(kdsViewResponse.kdsViewList.obs);
  }
}
