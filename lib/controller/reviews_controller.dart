import 'package:get/get.dart';
import '../model/reviews/reviews_response.dart';
import '../utils/state_status.dart';

class ReviewsController extends GetxController {
  static ReviewsController get to => Get.find();
  var stateStatus = Rx<StateStatus>(StateStatus.initial);
  var refreshStatus = Rx<RefreshStatus>(RefreshStatus.initial);

  var reviewsResponse = Rx<ReviewsResponse>(ReviewsResponse());

  @override
  onInit() {
    super.onInit();
    fetchReviews();
  }


  Future<void> fetchReviews({bool isRefresh = false}) async {
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.loading;
    }
    stateStatus.value = StateStatus.loading;

    var reviewsResponse =  ReviewsResponse(reviewsList: [
      Reviews(uniqueId: '1', name: 'Lakhani Kamlesh', description: 'Description', dateTime: '11-7-2020 - 1:15 PM', ratting: 4.0),
    ]);

    await Future.delayed(const Duration(seconds: 2));
    if (isRefresh) {
      refreshStatus.value = RefreshStatus.success;
      refreshStatus.value = RefreshStatus.initial;
    }

    stateStatus.value = StateStatus.success;

    this.reviewsResponse.value = reviewsResponse;
  }
}