class RazorpayOrder {
  RazorpayOrder({
    String? id,
    String? entity,
    int? amount,
    int? amountPaid,
    int? amountDue,
    String? currency,
    dynamic receipt,
    String? offerId,
    List<String>? offers,
    String? status,
    int? attempts,
    List<dynamic>? notes,
    int? createdAt,
  }) {
    _id = id;
    _entity = entity;
    _amount = amount;
    _amountPaid = amountPaid;
    _amountDue = amountDue;
    _currency = currency;
    _receipt = receipt;
    _offerId = offerId;
    _offers = offers;
    _status = status;
    _attempts = attempts;
    _notes = notes;
    _createdAt = createdAt;
  }

  RazorpayOrder.fromJson(dynamic json) {
    _id = json['id'];
    _entity = json['entity'];
    _amount = json['amount'];
    _amountPaid = json['amount_paid'];
    _amountDue = json['amount_due'];
    _currency = json['currency'];
    _receipt = json['receipt'];
    _offerId = json['offer_id'];
    _offers = json['offers'] != null ? json['offers'].cast<String>() : [];
    _status = json['status'];
    _attempts = json['attempts'];
    if (json['notes'] != null) {
      _notes = [];
      json['notes'].forEach((v) {
        _notes?.add(v);
      });
    }
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _entity;
  int? _amount;
  int? _amountPaid;
  int? _amountDue;
  String? _currency;
  dynamic _receipt;
  String? _offerId;
  List<String>? _offers;
  String? _status;
  int? _attempts;
  List<dynamic>? _notes;
  int? _createdAt;
  RazorpayOrder copyWith({
    String? id,
    String? entity,
    int? amount,
    int? amountPaid,
    int? amountDue,
    String? currency,
    dynamic receipt,
    String? offerId,
    List<String>? offers,
    String? status,
    int? attempts,
    List<dynamic>? notes,
    int? createdAt,
  }) =>
      RazorpayOrder(
        id: id ?? _id,
        entity: entity ?? _entity,
        amount: amount ?? _amount,
        amountPaid: amountPaid ?? _amountPaid,
        amountDue: amountDue ?? _amountDue,
        currency: currency ?? _currency,
        receipt: receipt ?? _receipt,
        offerId: offerId ?? _offerId,
        offers: offers ?? _offers,
        status: status ?? _status,
        attempts: attempts ?? _attempts,
        notes: notes ?? _notes,
        createdAt: createdAt ?? _createdAt,
      );
  String? get id => _id;
  String? get entity => _entity;
  int? get amount => _amount;
  int? get amountPaid => _amountPaid;
  int? get amountDue => _amountDue;
  String? get currency => _currency;
  dynamic get receipt => _receipt;
  String? get offerId => _offerId;
  List<String>? get offers => _offers;
  String? get status => _status;
  int? get attempts => _attempts;
  List<dynamic>? get notes => _notes;
  int? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['entity'] = _entity;
    map['amount'] = _amount;
    map['amount_paid'] = _amountPaid;
    map['amount_due'] = _amountDue;
    map['currency'] = _currency;
    map['receipt'] = _receipt;
    map['offer_id'] = _offerId;
    map['offers'] = _offers;
    map['status'] = _status;
    map['attempts'] = _attempts;
    if (_notes != null) {
      map['notes'] = _notes?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    return map;
  }
}
