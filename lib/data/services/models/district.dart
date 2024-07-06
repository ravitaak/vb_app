class District {
  int? _id;
  String? _name;

  int? get id => _id;
  String? get name => _name;

  District({int? id, String? name}) {
    _id = id;
    _name = name;
  }

  District.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }
}
