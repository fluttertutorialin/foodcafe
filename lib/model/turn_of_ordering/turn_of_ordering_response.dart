class TurnOfOrderingResponse{
  List<TurnOfOrdering> turnOfOrderingList;

  TurnOfOrderingResponse({this.turnOfOrderingList});
}

class TurnOfOrdering{
  String userId, userName, profilePictureUrl, recipeName, dateTime, availableRecipe;

  TurnOfOrdering({this.userId, this.userName, this.profilePictureUrl, this.recipeName, this.dateTime, this.availableRecipe});
}