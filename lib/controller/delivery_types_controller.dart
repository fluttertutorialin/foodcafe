import 'package:foodcafe/model/delivey_types/delivery_type_response.dart';
import 'package:foodcafe/model/delivey_types/free_delivery_person.dart';
import 'package:foodcafe/resource/colors.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'package:foodcafe/utils/extensions.dart';

class DeliveryTypesController extends GetxController {
  var rxDeliveryTypes = Rx<DeliveryTypeResponse>();
  var rxPartyType = Rx<PartyTypeResponse>();
  var rxFreeDeliveryPerson = Rx<FreeDeliveryPersonResponse>();
  RxString rxSelectDeliveryType = ''.obs;
  RxString rxSelectPartyType = ''.obs;
  RxString rxSelectFreeDeliveryPerson = ''.obs;

  var _acceptedController = Get.put(AcceptedController());
  var _allFindController = Get.put(AllFindController());
  var _homeController = Get.put(HomeController());

  @override
  void onInit() {
    super.onInit();

    fetchDeliveryTypes();
  }

  void fetchDeliveryTypes() {
    var deliveryTypeResponse = DeliveryTypeResponse(
        selectWhichDeliveryType: '1',
        whichDeliveryTypeList: [
          WhichDeliveryType(uniqueId: '1', name: 'Food Cafe'),
          WhichDeliveryType(uniqueId: '2', name: 'Third Party')
        ]);
    rxSelectDeliveryType.value = deliveryTypeResponse.selectWhichDeliveryType;
    rxDeliveryTypes = deliveryTypeResponse.obs;

    fetchPartyType();
  }

  void selectDeliveryType({String orderUniqueId, String uniqueId}) {
    rxSelectFreeDeliveryPerson.value = '';
    rxSelectPartyType.value = '';
    rxSelectFreeDeliveryPerson.value = '';
    _acceptedController.deliveryPersonalDetailUnSelect(uniqueId: orderUniqueId);
    _allFindController.deliveryPersonalDetailUnSelect(uniqueId: orderUniqueId);

    rxSelectDeliveryType.value = uniqueId;
  }

  void selectPartyType({String orderUniqueId, String uniqueId}) {
    _acceptedController.deliveryPersonalDetailUnSelect(uniqueId: orderUniqueId);
    _allFindController.deliveryPersonalDetailUnSelect(uniqueId: orderUniqueId);
    if (rxSelectPartyType.value == uniqueId) {
      rxSelectFreeDeliveryPerson.value = '';
      rxSelectPartyType.value = '';
    } else {
      rxSelectPartyType.value = uniqueId;
    }
  }

  void selectFreeDeliveryPerson(
      {String orderUniqueId, String uniqueId, String name, int mobile}) {
    int currentPageIndex = _homeController.currentPageIndex.value;

    if (currentPageIndex == acceptedIndex) {
      _acceptedController.deliveryPersonalDetailUnSelect(uniqueId: orderUniqueId);
    }

    _allFindController.deliveryPersonalDetailUnSelect(uniqueId: orderUniqueId);

    if (uniqueId == rxSelectFreeDeliveryPerson.value) {
      rxSelectFreeDeliveryPerson.value = '';
    } else if (rxSelectPartyType.value.isNotEmpty) {
      rxSelectFreeDeliveryPerson.value = uniqueId;

      if (currentPageIndex == acceptedIndex) {
        _acceptedController.deliveryPersonalDetailSelect(
            uniqueId: orderUniqueId,
            deliveryPersonUniqueId: uniqueId,
            deliveryPersonName: name,
            deliveryPersonMobile: mobile,
            deliveryDateTime: 1607919790946705);
      }

      _allFindController.deliveryPersonalDetailSelect(
          uniqueId: orderUniqueId,
          deliveryPersonUniqueId: uniqueId,
          deliveryPersonName: name,
          deliveryPersonMobile: mobile,
          deliveryDateTime: 1607919790946705);
    } else {
      toast(
          title: 'Delivery person',
          message: selectRestaurantMessage,
          textColor: toastMessageOrderColor,
          backgroundColor: toastBackgroundOrderColor,
          flushBarPosition: toastOrderPosition);
    }
  }

  void fetchPartyType() {
    var partyTypeResponse = PartyTypeResponse(selectPartyType: '2', partyList: [
      PartyType(uniqueId: '1', name: 'Food Cafe'),
      PartyType(uniqueId: '2', name: 'Apna Restaurant'),
      PartyType(uniqueId: '3', name: 'Tinello'),
      PartyType(uniqueId: '4', name: 'Neelkanth Patang'),
      PartyType(uniqueId: '5', name: 'Rajwadu'),
      PartyType(uniqueId: '6', name: 'The Eatery'),
      PartyType(uniqueId: '7', name: '650 - The Global Kitchen'),
      PartyType(uniqueId: '8', name: 'The Green House'),
    ]);
    rxSelectPartyType.value = partyTypeResponse.selectPartyType;
    rxPartyType = partyTypeResponse.obs;

    fetchFreeDeliveryPerson();
  }

  void fetchFreeDeliveryPerson() {
    var freeDeliveryPersonResponse = FreeDeliveryPersonResponse(
        selectFreeDeliveryPerson: '0',
        freeDeliveryPersonList: [
          FreeDeliveryPerson(
              uniqueId: '1',
              name: 'Lakhani kamlesh',
              mobile: 9586331823,
              address: ''),
          FreeDeliveryPerson(
              uniqueId: '2',
              name: 'Lakhani Nayan',
              mobile: 7990971929,
              address: '')
        ]);

    rxSelectFreeDeliveryPerson.value =
        freeDeliveryPersonResponse.selectFreeDeliveryPerson;
    rxFreeDeliveryPerson = freeDeliveryPersonResponse.obs;
  }
}
