class CardInfoModel {
  String? cardNumber;
  String? expiryMonth;
  String? expiryYear;
  String? cvv;
  String? cardHolderName;
}

class NetBankingModel {
  String? bankKey;
  String? bankName;
  String? logoUrl;

  NetBankingModel({this.bankKey, this.bankName, this.logoUrl});
}

class WalletModel {
  String? walletName;
  String? logoUrl;

  WalletModel({this.walletName, this.logoUrl});

  factory WalletModel.fromMap(MapEntry<String, String> entry) {
    return WalletModel(walletName: entry.key, logoUrl: entry.value);
  }

  static Map<String, String> wallets = {
    'airtelmoney': 'assets/logo/airtelmoney.jpg',
    'amazonpay': 'assets/logo/amazonpay.jpg',
    'bajajpay': 'assets/logo/bajajpay.jpg',
    'freecharge': 'assets/logo/freecharge.jpg',
    'jiomoney': 'assets/logo/jiomoney.jpg',
    'mobikwik': 'assets/logo/mobikwik.jpg',
    'olamoney': 'assets/logo/olamoney.jpg',
    'phonepe': 'assets/logo/phonepe.jpg',
  };

  static List<WalletModel> createWalletList() {
    return wallets.entries.map((entry) => WalletModel.fromMap(entry)).toList();
  }
}
