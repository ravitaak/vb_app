class Coupon {
  Coupon(
      {int? id,
      String? code,
      int? discountAmount,
      dynamic discountPercent,
      bool? isPeriodic,
      bool? isPrimary,
      String? startDate,
      String? endDate,
      bool? hidden,
      List<ApplicableOn>? applicableOn,
      String? description}) {
    _id = id;
    _code = code;
    _discountAmount = discountAmount;
    _discountPercent = discountPercent;
    _isPeriodic = isPeriodic;
    _isPrimary = isPrimary;
    _startDate = startDate;
    _endDate = endDate;
    _hidden = hidden;
    _applicableOn = applicableOn;
    _description = description;
  }

  Coupon.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'];
    _discountAmount = json['discount_amount'];
    _discountPercent = json['discount_percent'];
    _isPeriodic = json['is_periodic'];
    _isPrimary = json['is_primary'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _hidden = json['hidden'];
    _description = json["description"];
    if (json['applicable_on'] != null) {
      _applicableOn = [];
      json['applicable_on'].forEach((v) {
        _applicableOn?.add(ApplicableOn.fromJson(v));
      });
    }
  }
  int? _id;
  String? _code;
  int? _discountAmount;
  dynamic _discountPercent;
  bool? _isPeriodic;
  bool? _isPrimary;
  String? _startDate;
  String? _endDate;
  bool? _hidden;
  List<ApplicableOn>? _applicableOn;
  String? _description;
  Coupon copyWith(
          {int? id,
          String? code,
          int? discountAmount,
          dynamic discountPercent,
          bool? isPeriodic,
          bool? isPrimary,
          String? startDate,
          String? endDate,
          bool? hidden,
          List<ApplicableOn>? applicableOn,
          String? description}) =>
      Coupon(
          id: id ?? _id,
          code: code ?? _code,
          discountAmount: discountAmount ?? _discountAmount,
          discountPercent: discountPercent ?? _discountPercent,
          isPeriodic: isPeriodic ?? _isPeriodic,
          isPrimary: isPrimary ?? _isPrimary,
          startDate: startDate ?? _startDate,
          endDate: endDate ?? _endDate,
          hidden: hidden ?? _hidden,
          applicableOn: applicableOn ?? _applicableOn,
          description: description ?? _description);
  int? get id => _id;
  String? get code => _code;
  int? get discountAmount => _discountAmount;
  dynamic get discountPercent => _discountPercent;
  bool? get isPeriodic => _isPeriodic;
  bool? get isPrimary => _isPrimary;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  bool? get hidden => _hidden;
  List<ApplicableOn>? get applicableOn => _applicableOn;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['code'] = _code;
    map['discount_amount'] = _discountAmount;
    map['discount_percent'] = _discountPercent;
    map['is_periodic'] = _isPeriodic;
    map['is_primary'] = _isPrimary;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['hidden'] = _hidden;
    map["description"] = _description;
    if (_applicableOn != null) {
      map['applicable_on'] = _applicableOn?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ApplicableOn {
  ApplicableOn({
    int? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  ApplicableOn.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;
  ApplicableOn copyWith({
    int? id,
    String? name,
  }) =>
      ApplicableOn(
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
