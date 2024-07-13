class VidyaBoxSlide {
  String? _thumbnail;
  String? _name;
  int? _id;

  VidyaBoxSlide({
    String? thumbnail,
    String? name,
    int? id,
  }) {
    _thumbnail = thumbnail;
    _name = name;
    _id = id;
  }

  VidyaBoxSlide.fromJson(dynamic json) {
    _id = json['id'];
    _thumbnail = json['thumbnail'];
    _name = json['name'];
  }

  VidyaBoxSlide copyWith({
    int? id,
    String? thumbnail,
    String? name,
  }) =>
      VidyaBoxSlide(
        id: id ?? _id,
        thumbnail: thumbnail ?? _thumbnail,
        name: name ?? _name,
      );

  int? get id => _id;
  String? get thumbnail => _thumbnail;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['thumbnail'] = _thumbnail;
    map['name'] = _name;
    return map;
  }
}