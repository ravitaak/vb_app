class TrialData {
  int? _id;
  String? _createdAt;

  int? get id => _id;
  String? get createdAt => _createdAt;

  TrialData({int? id, String? createdAt, int? trialDays}) {
    _id = id;
    _createdAt = createdAt;
  }

  TrialData.fromJson(dynamic json) {
    _id = json["id"];
    _createdAt = json["createdAt"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["createdAt"] = _createdAt;
    return map;
  }
}
