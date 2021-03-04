import 'package:foodcafe/model/reviews/reviews_response.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';

class ReviewsController extends GetxController {
  static ReviewsController get to => Get.find();
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);
  var refreshStatus = Rx<RefreshStatus>(RefreshStatus.INITIAL);

  var reviewsResponse = Rx<ReviewsResponse>();

  @override
  onInit() {
    super.onInit();
    fetchReviews();
  }


  Future<void> fetchReviews({bool isRefresh = false}) async {
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.LOADING;
    }
    stateStatus.value = StateStatus.LOADING;

    var reviewsResponse =  ReviewsResponse(reviewsList: [
      Reviews(uniqueId: '1', name: 'Lakhani Kamlesh', description: 'Description', dateTime: '11-7-2020 - 1:15 PM', ratting: 4.0),
    ]);

    await Future.delayed(Duration(seconds: 2));
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.SUCCESS;
      refreshStatus.value = RefreshStatus.INITIAL;
    }

    stateStatus.value = StateStatus.SUCCESS;

    this.reviewsResponse.value = reviewsResponse;
  }
}