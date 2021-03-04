import 'package:foodcafe/model/turn_of_ordering/turn_of_ordering_response.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';

class TurnOfOrderingController extends GetxController {
  static TurnOfOrderingController get to => Get.find();
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);
  var refreshStatus = Rx<RefreshStatus>(RefreshStatus.INITIAL);

  var turnOfOrderingResponse = Rx<TurnOfOrderingResponse>();

  @override
  onInit() {
    super.onInit();
    fetchTurnOfOrdering();
  }


  Future<void> fetchTurnOfOrdering({bool isRefresh = false}) async {
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.LOADING;
    }
    stateStatus.value = StateStatus.LOADING;

    var turnOfOrderingResponse =  TurnOfOrderingResponse(turnOfOrderingList: [
      TurnOfOrdering(userId: '1', userName: 'Lakhani Kamlesh', recipeName: 'Chicken biryani', dateTime: '11-7-2020 - 1:15 PM', availableRecipe: '20-12-2020 - 1:15 PM'),
      TurnOfOrdering(userId: '2', userName: 'Lakhani Kamlesh', recipeName: 'Chicken biryani', dateTime: '11-8-2020 - 1:15 PM', availableRecipe: '20-12-2020 - 1:15 PM'),
    ]);

    await Future.delayed(Duration(seconds: 2));
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.SUCCESS;
      refreshStatus.value = RefreshStatus.INITIAL;
    }

    stateStatus.value = StateStatus.SUCCESS;

    this.turnOfOrderingResponse.value = turnOfOrderingResponse;
  }
}