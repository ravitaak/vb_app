class VidyaBoxSlide {
  String? _thumbnail;
  String? _name;
  int? _id;
  int? _priority;

  VidyaBoxSlide({
    String? thumbnail,
    String? name,
    int? id,
    int? priority,
  }) {
    _thumbnail = thumbnail;
    _name = name;
    _id = id;
    _priority = priority;
  }

  VidyaBoxSlide.fromJson(dynamic json) {
    _id = json['id'];
    _thumbnail = json['thumbnail'];
    _name = json['name'];
    _priority = json['priority'];
  }

  VidyaBoxSlide copyWith({
    int? id,
    int? priority,
    String? thumbnail,
    String? name,
  }) =>
      VidyaBoxSlide(
        id: id ?? _id,
        priority: priority ?? _priority,
        thumbnail: thumbnail ?? _thumbnail,
        name: name ?? _name,
      );

  int? get id => _id;
  int? get priority => _priority;
  String? get thumbnail => _thumbnail;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['priority'] = _priority;
    map['thumbnail'] = _thumbnail;
    map['name'] = _name;
    return map;
  }
}