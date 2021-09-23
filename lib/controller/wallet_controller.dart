import 'package:get/get.dart';
import '../model/wallet/wallet_response.dart';
import '../utils/state_status.dart';

class WalletController extends GetxController {
  static WalletController get to => Get.find();
  var stateStatus = Rx<StateStatus>(StateStatus.initial);
  var refreshStatus = Rx<RefreshStatus>(RefreshStatus.initial);
  var rxWalletList = RxList<Wallet>([]);

  @override
  onInit() {
    super.onInit();
    fetchWallet();
  }

  Future<void> fetchWallet({bool isRefresh = false}) async {
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.loading;
    }
    stateStatus.value = StateStatus.loading;

    var walletResponse = WalletResponse(creditBalance: 100, walletList: [
      Wallet(
          uniqueId: 'FC02021',
          totalItems: 3,
          orderStatus: 'COMPLETED',
          amount: 100,
          dateTime: '20-12-2020 - 1:15 PM'),
      Wallet(
          uniqueId: 'FC02021',
          totalItems: 0,
          orderStatus: 'SENT TO BANK',
          amount: 500,
          dateTime: '20-12-2020 - 1:15 PM'),
    ]);

    await Future.delayed(const Duration(seconds: 2));
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.success;
      refreshStatus.value = RefreshStatus.initial;
    }

    stateStatus.value = StateStatus.success;

    rxWalletList.assignAll(walletResponse.walletList);
  }
}
