class KDSViewResponse {
  List<KDSView> kdsViewList;

  KDSViewResponse({this.kdsViewList});
}

class KDSView {
  String id, menuName;
  double stockCounter;
  bool isPause;

  KDSView({this.id, this.menuName, this.stockCounter, this.isPause = false});
}
