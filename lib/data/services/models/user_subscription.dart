class UserSubscription {
  int? _id;
  bool? _paymentStatus;
  int? _amount;
  String? _createdAt;
  User? _user;
  Sub? _sub;

  int? get id => _id;
  bool? get paymentStatus => _paymentStatus;
  int? get amount => _amount;
  String? get createdAt => _createdAt;
  User? get user => _user;
  Sub? get sub => _sub;

  UserSubscription(
      {int? id,
      bool? paymentStatus,
      int? amount,
      String? createdAt,
      User? user,
      Sub? sub}) {
    _id = id;
    _paymentStatus = paymentStatus;
    _amount = amount;
    _createdAt = createdAt;
    _user = user;
    _sub = sub;
  }

  UserSubscription.fromJson(dynamic json) {
    _id = json["id"];
    _paymentStatus = json["paymentStatus"];
    _amount = json["amount"]?.toInt();
    _createdAt = json["createdAt"];
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
    _sub = json["sub"] != null ? Sub.fromJson(json["sub"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["paymentStatus"] = _paymentStatus;
    map["amount"] = _amount;
    map["createdAt"] = _createdAt;
    if (_user != null) {
      map["user"] = _user?.toJson();
    }
    if (_sub != null) {
      map["sub"] = _sub?.toJson();
    }
    return map;
  }
}

class Sub {
  int? _id;
  String? _name;
  int? _duration;

  int? get id => _id;
  String? get name => _name;
  int? get duration => _duration;

  Sub({int? id, String? name, int? duration}) {
    _id = id;
    _name = name;
    _duration = duration;
  }

  Sub.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _duration = json["duration"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["duration"] = _duration;
    return map;
  }
}

class User {
  int? _id;
  String? _fullname;

  int? get id => _id;
  String? get fullname => _fullname;

  User({int? id, String? fullname}) {
    _id = id;
    _fullname = fullname;
  }

  User.fromJson(dynamic json) {
    _id = json["id"];
    _fullname = json["fullname"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["fullname"] = _fullname;
    return map;
  }
}
