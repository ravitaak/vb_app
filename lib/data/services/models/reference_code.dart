class ReferenceCode {
  ReferenceCode({
    int? id,
    String? code,
    String? usageEndPeriod,
    bool? showCoupons,
    bool? premiumFeature,
    List<Discounts>? discounts,
    School? school,
  }) {
    _id = id;
    _code = code;
    _usageEndPeriod = usageEndPeriod;
    _showCoupons = showCoupons;
    _discounts = discounts;
    _school = school;
    _premiumFeature = premiumFeature;
  }

  ReferenceCode.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'];
    _usageEndPeriod = json['usage_end_period'];
    _showCoupons = json['show_coupons'];
    _premiumFeature = json["premium_features"];
    if (json['discounts'] != null) {
      _discounts = [];
      json['discounts'].forEach((v) {
        _discounts?.add(Discounts.fromJson(v));
      });
    }
    _school = json['school'] != null ? School.fromJson(json['school']) : null;
  }
  int? _id;
  String? _code;
  String? _usageEndPeriod;
  bool? _showCoupons;
  List<Discounts>? _discounts;
  School? _school;
  bool? _premiumFeature;
  ReferenceCode copyWith({
    int? id,
    String? code,
    String? usageEndPeriod,
    bool? showCoupons,
    List<Discounts>? discounts,
    School? school,
    bool? premiumFeature,
  }) =>
      ReferenceCode(
          id: id ?? _id,
          code: code ?? _code,
          usageEndPeriod: usageEndPeriod ?? _usageEndPeriod,
          showCoupons: showCoupons ?? _showCoupons,
          discounts: discounts ?? _discounts,
          school: school ?? _school,
          premiumFeature: premiumFeature ?? _premiumFeature);
  int? get id => _id;
  String? get code => _code;
  String? get usageEndPeriod => _usageEndPeriod;
  bool? get showCoupons => _showCoupons;
  List<Discounts>? get discounts => _discounts;
  School? get school => _school;
  bool? get premiumFeature => _premiumFeature;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['code'] = _code;
    map['usage_end_period'] = _usageEndPeriod;
    map['show_coupons'] = _showCoupons;
    map["premium_features"] = _premiumFeature;
    if (_discounts != null) {
      map['discounts'] = _discounts?.map((v) => v.toJson()).toList();
    }
    if (_school != null) {
      map['school'] = _school?.toJson();
    }
    return map;
  }
}

class School {
  School({
    int? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  School.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;
  School copyWith({
    int? id,
    String? name,
  }) =>
      School(
        id: id ?? _id,
        name: name ?? _name,
      );
  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}

class Discounts {
  Discounts({
    int? id,
    int? discountAmount,
    Subscription? subscription,
  }) {
    _id = id;
    _discountAmount = discountAmount;
    _subscription = subscription;
  }

  Discounts.fromJson(dynamic json) {
    _id = json['id'];
    _discountAmount = json['discount_amount'];
    _subscription = json['subscription'] != null
        ? Subscription.fromJson(json['subscription'])
        : null;
  }
  int? _id;
  int? _discountAmount;
  Subscription? _subscription;
  Discounts copyWith({
    int? id,
    int? discountAmount,
    Subscription? subscription,
  }) =>
      Discounts(
        id: id ?? _id,
        discountAmount: discountAmount ?? _discountAmount,
        subscription: subscription ?? _subscription,
      );
  int? get id => _id;
  int? get discountAmount => _discountAmount;
  Subscription? get subscription => _subscription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['discount_amount'] = _discountAmount;
    if (_subscription != null) {
      map['subscription'] = _subscription?.toJson();
    }
    return map;
  }
}

class Subscription {
  Subscription({
    int? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  Subscription.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;
  Subscription copyWith({
    int? id,
    String? name,
  }) =>
      Subscription(
        id: id ?? _id,
        name: name ?? _name,
      );
  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}
