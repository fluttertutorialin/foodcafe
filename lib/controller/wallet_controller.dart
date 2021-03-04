import 'package:foodcafe/model/wallet/wallet_response.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  static WalletController get to => Get.find();
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);
  var refreshStatus = Rx<RefreshStatus>(RefreshStatus.INITIAL);
  var rxWalletList = RxList<Wallet>([]);

  @override
  onInit() {
    super.onInit();
    fetchWallet();
  }

  Future<void> fetchWallet({bool isRefresh = false}) async {
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.LOADING;
    }
    stateStatus.value = StateStatus.LOADING;

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

    await Future.delayed(Duration(seconds: 2));
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.SUCCESS;
      refreshStatus.value = RefreshStatus.INITIAL;
    }

    stateStatus.value = StateStatus.SUCCESS;

    this.rxWalletList.assignAll(walletResponse.walletList);
  }
}
