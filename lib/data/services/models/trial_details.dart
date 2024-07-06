class TrialDetails {
  TrialDetails({
    Consumption? consumption,
    User? user,
  }) {
    _consumption = consumption;
    _user = user;
  }

  TrialDetails.fromJson(dynamic json) {
    _consumption = json['consumption'] != null
        ? Consumption.fromJson(json['consumption'])
        : null;
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  Consumption? _consumption;
  User? _user;
  TrialDetails copyWith({
    Consumption? consumption,
    User? user,
  }) =>
      TrialDetails(
        consumption: consumption ?? _consumption,
        user: user ?? _user,
      );
  Consumption? get consumption => _consumption;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_consumption != null) {
      map['consumption'] = _consumption?.toJson();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class User {
  User({
    int? id,
    String? createdAt,
  }) {
    _id = id;
    _createdAt = createdAt;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _createdAt = json['createdAt'];
  }
  int? _id;
  String? _createdAt;
  User copyWith({
    int? id,
    String? createdAt,
  }) =>
      User(
        id: id ?? _id,
        createdAt: createdAt ?? _createdAt,
      );
  int? get id => _id;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['createdAt'] = _createdAt;
    return map;
  }
}

class Consumption {
  Consumption({
    int? id,
    String? date,
    int? consumption,
  }) {
    _id = id;
    _date = date;
    _consumption = consumption;
  }

  Consumption.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _consumption = json['consumption'];
  }
  int? _id;
  String? _date;
  int? _consumption;
  Consumption copyWith({
    int? id,
    String? date,
    int? consumption,
  }) =>
      Consumption(
        id: id ?? _id,
        date: date ?? _date,
        consumption: consumption ?? _consumption,
      );
  int? get id => _id;
  String? get date => _date;
  int? get consumption => _consumption;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['consumption'] = _consumption;
    return map;
  }
}
