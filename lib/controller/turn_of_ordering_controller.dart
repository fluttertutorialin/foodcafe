import 'package:get/get.dart';
import '../model/turn_of_ordering/turn_of_ordering_response.dart';
import '../utils/state_status.dart';

class TurnOfOrderingController extends GetxController {
  static TurnOfOrderingController get to => Get.find();
  var stateStatus = Rx<StateStatus>(StateStatus.initial);
  var refreshStatus = Rx<RefreshStatus>(RefreshStatus.initial);

  var turnOfOrderingResponse = Rx<TurnOfOrderingResponse>(TurnOfOrderingResponse());

  @override
  onInit() {
    super.onInit();
    fetchTurnOfOrdering();
  }


  Future<void> fetchTurnOfOrdering({bool isRefresh = false}) async {
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.loading;
    }
    stateStatus.value = StateStatus.loading;

    var turnOfOrderingResponse =  TurnOfOrderingResponse(turnOfOrderingList: [
      TurnOfOrdering(userId: '1', userName: 'Lakhani Kamlesh', recipeName: 'Chicken biryani', dateTime: '11-7-2020 - 1:15 PM', availableRecipe: '20-12-2020 - 1:15 PM'),
      TurnOfOrdering(userId: '2', userName: 'Lakhani Kamlesh', recipeName: 'Chicken biryani', dateTime: '11-8-2020 - 1:15 PM', availableRecipe: '20-12-2020 - 1:15 PM'),
    ]);

    await Future.delayed(const Duration(seconds: 2));
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.success;
      refreshStatus.value = RefreshStatus.initial;
    }

    stateStatus.value = StateStatus.success;

    this.turnOfOrderingResponse.value = turnOfOrderingResponse;
  }
}