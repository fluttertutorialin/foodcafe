class FreeDeliveryPersonResponse {
  String selectFreeDeliveryPerson;

  List<FreeDeliveryPerson> freeDeliveryPersonList;

  FreeDeliveryPersonResponse(
      {this.selectFreeDeliveryPerson, this.freeDeliveryPersonList});
}

class FreeDeliveryPerson {
  String uniqueId, name;
  int mobile;
  String address;

  FreeDeliveryPerson({this.uniqueId, this.name, this.mobile, this.address});
}
