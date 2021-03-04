class DeliveryTypeResponse {
  List<WhichDeliveryType> whichDeliveryTypeList;

  String selectWhichDeliveryType;

  DeliveryTypeResponse(
      {this.whichDeliveryTypeList, this.selectWhichDeliveryType});
}

class WhichDeliveryType {
  String uniqueId, name;

  WhichDeliveryType({this.uniqueId, this.name});
}

class PartyTypeResponse {
  String selectPartyType;
  List<PartyType> partyList;

  PartyTypeResponse({this.selectPartyType, this.partyList});
}

class PartyType {
  String uniqueId, name;

  PartyType({this.uniqueId, this.name});
}
