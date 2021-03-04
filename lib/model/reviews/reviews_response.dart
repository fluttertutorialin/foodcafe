class ReviewsResponse{
  List<Reviews> reviewsList;

  ReviewsResponse({this.reviewsList});
}

class Reviews{
  String uniqueId, name, profilePictureUrl, description, dateTime;
  double ratting;
  double totalRatting;

  Reviews({this.uniqueId, this.name, this.profilePictureUrl, this.description, this.dateTime, this.ratting, this.totalRatting});
}