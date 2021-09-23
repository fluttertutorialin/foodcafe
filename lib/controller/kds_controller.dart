import 'package:get/get.dart';
import '../model/kdsview/kds_view.dart';
import '../utils/state_status.dart';

class KDSViewController extends GetxController {
  static KDSViewController get to => Get.find();

  var stateStatus = Rx<StateStatus>(StateStatus.initial);
  var refreshStatus = Rx<RefreshStatus>(RefreshStatus.initial);

  var rxKDSViewList = RxList<KDSView>([]);

  @override
  onInit() {
    super.onInit();
    fetchKDSView();
  }

  Future<void> fetchKDSView({bool isRefresh = false}) async {
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.loading;
    }

    stateStatus.value = StateStatus.loading;

    var kdsViewResponse = KDSViewResponse(kdsViewList: [
      KDSView(
          id: '001',
          menuName: 'Chicken biryaani',
          stockCounter: 12,
          isPause: false)
    ]);

    await Future.delayed(const Duration(seconds: 2));

    if (isRefresh) {
      refreshStatus.value = RefreshStatus.success;
      refreshStatus.value = RefreshStatus.initial;
    }

    stateStatus.value = StateStatus.success;

    rxKDSViewList.assignAll(kdsViewResponse.kdsViewList.obs);
  }
}
