class WalletResponse{
  double creditBalance;

  List<Wallet> walletList;
  WalletResponse({this.creditBalance, this.walletList});
}

class Wallet{
  String uniqueId, orderStatus, dateTime;
  int totalItems;
  double amount;

  Wallet({this.uniqueId, this.orderStatus, this.amount, this.dateTime, this.totalItems});
}