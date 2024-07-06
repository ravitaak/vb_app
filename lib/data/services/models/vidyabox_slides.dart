class VidyaBoxSlide {
  String? _thumbnail;
  String? _name;
  int? _id;
  String? _description;

  VidyaBoxSlide({
    String? thumbnail,
    String? name,
    int? id,
    String? description,
  }) {
    _thumbnail = thumbnail;
    _name = name;
    _id = id;
    _description = description;
  }

  VidyaBoxSlide.fromJson(dynamic json) {
    _id = json['id'];
    _thumbnail = json['thumbnail'];
    _name = json['name'];
    _description = json['description'];
  }

  VidyaBoxSlide copyWith({
    int? id,
    String? thumbnail,
    String? name,
    String? description,
  }) =>
      VidyaBoxSlide(
        id: id ?? _id,
        thumbnail: thumbnail ?? _thumbnail,
        name: name ?? _name,
        description: description ?? _description,
      );

  int? get id => _id;
  String? get thumbnail => _thumbnail;
  String? get name => _name;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['thumbnail'] = _thumbnail;
    map['name'] = _name;
    map['description'] = _description;
    return map;
  }
}
