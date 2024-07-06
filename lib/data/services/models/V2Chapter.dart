class V2Chapter {
  V2Chapter({
    int? id,
    String? name,
    String? hinglishName,
    dynamic description,
    String? pdfUrl,
    bool? paid,
    List<Lectures>? lectures,
    List<ReadAlouds>? readAlouds,
  }) {
    _id = id;
    _name = name;
    _hinglishName = hinglishName;
    _description = description;
    _paid = paid;
    _pdfUrl = pdfUrl;
    _lectures = lectures;
    _readAlouds = readAlouds;
  }

  V2Chapter.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _hinglishName = json['hinglish_name'];
    _description = json['description'];
    _paid = json['paid'];
    _pdfUrl = json["pdfUrl"];
    if (json['lectures'] != null) {
      _lectures = [];
      json['lectures'].forEach((v) {
        _lectures?.add(Lectures.fromJson(v));
      });
    }
    if (json['read_alouds'] != null) {
      _readAlouds = [];
      json['read_alouds'].forEach((v) {
        _readAlouds?.add(ReadAlouds.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  String? _hinglishName;
  dynamic _description;
  bool? _paid;
  List<Lectures>? _lectures;
  List<ReadAlouds>? _readAlouds;
  String? _pdfUrl;
  V2Chapter copyWith({
    int? id,
    String? name,
    String? hinglishName,
    dynamic description,
    bool? paid,
    String? pdfUrl,
    List<Lectures>? lectures,
    List<ReadAlouds>? readAlouds,
  }) =>
      V2Chapter(
          id: id ?? _id,
          name: name ?? _name,
          hinglishName: hinglishName ?? _hinglishName,
          description: description ?? _description,
          paid: paid ?? _paid,
          lectures: lectures ?? _lectures,
          readAlouds: readAlouds ?? _readAlouds,
          pdfUrl: pdfUrl ?? _pdfUrl);
  int? get id => _id;
  String? get name => _name;
  String? get hinglishName => _hinglishName;
  dynamic get description => _description;
  bool? get paid => _paid;
  List<Lectures>? get lectures => _lectures;
  List<ReadAlouds>? get readAlouds => _readAlouds;
  String? get pdfUrl => _pdfUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['hinglish_name'] = _hinglishName;
    map['description'] = _description;
    map['paid'] = _paid;
    map["pdfUrl"] = _pdfUrl;
    if (_lectures != null) {
      map['lectures'] = _lectures?.map((v) => v.toJson()).toList();
    }
    if (_readAlouds != null) {
      map['read_alouds'] = _readAlouds?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ReadAlouds {
  ReadAlouds({
    int? id,
    String? name,
    String? url,
    int? length,
  }) {
    _id = id;
    _name = name;
    _url = url;
    _length = length;
  }

  ReadAlouds.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _url = json['url'];
    _length = json['length'];
  }
  int? _id;
  String? _name;
  String? _url;
  int? _length;
  ReadAlouds copyWith({
    int? id,
    String? name,
    String? url,
    int? length,
  }) =>
      ReadAlouds(
        id: id ?? _id,
        name: name ?? _name,
        url: url ?? _url,
        length: length ?? _length,
      );
  int? get id => _id;
  String? get name => _name;
  String? get url => _url;
  int? get length => _length;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['url'] = _url;
    map['length'] = _length;
    return map;
  }
}

class Lectures {
  Lectures({
    int? id,
    String? name,
    String? url,
    dynamic description,
    int? length,
    String? pdfUrl,
    Author? author,
  }) {
    _id = id;
    _name = name;
    _url = url;
    _description = description;
    _length = length;
    _pdfUrl = pdfUrl;
    _author = author;
  }

  Lectures.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _url = json['url'];
    _description = json['description'];
    _length = json['length'];
    _pdfUrl = json['pdfUrl'];
    _author = json['author'] != null ? Author.fromJson(json['author']) : null;
  }
  int? _id;
  String? _name;
  String? _url;
  dynamic _description;
  int? _length;
  String? _pdfUrl;
  Author? _author;
  Lectures copyWith({
    int? id,
    String? name,
    String? url,
    dynamic description,
    int? length,
    String? pdfUrl,
    Author? author,
  }) =>
      Lectures(
        id: id ?? _id,
        name: name ?? _name,
        url: url ?? _url,
        description: description ?? _description,
        length: length ?? _length,
        pdfUrl: pdfUrl ?? _pdfUrl,
        author: author ?? _author,
      );
  int? get id => _id;
  String? get name => _name;
  String? get url => _url;
  dynamic get description => _description;
  int? get length => _length;
  String? get pdfUrl => _pdfUrl;
  Author? get author => _author;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['url'] = _url;
    map['description'] = _description;
    map['length'] = _length ?? 300;
    map['pdfUrl'] = _pdfUrl;
    if (_author != null) {
      map['author'] = _author?.toJson();
    }
    return map;
  }
}

class Author {
  Author({
    int? id,
    String? fullname,
  }) {
    _id = id;
    _fullname = fullname;
  }

  Author.fromJson(dynamic json) {
    _id = json['id'];
    _fullname = json['fullname'];
  }
  int? _id;
  String? _fullname;
  Author copyWith({
    int? id,
    String? fullname,
  }) =>
      Author(
        id: id ?? _id,
        fullname: fullname ?? _fullname,
      );
  int? get id => _id;
  String? get fullname => _fullname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['fullname'] = _fullname;
    return map;
  }
}
