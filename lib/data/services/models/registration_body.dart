class RegistrationBody {
  String? _fullname;
  String? _phone;
  State? _state;
  District? _district;
  int? _age;
  Class? _class;
  School? _school;
  int? _accountType;
  String? _reference_code;
  int? _reference_code_id;
  String? _lang;
  String? _flavor;

  String? get fullname => _fullname;
  String? get phone => _phone;
  State? get state => _state;
  District? get district => _district;
  int? get age => _age;
  Class? get kClass => _class;
  School? get school => _school;
  int? get accountType => _accountType;
  String? get reference_code => _reference_code;
  int? get reference_code_id => _reference_code_id;
  String? get lang => _lang;
  String? get flavor => _flavor;

  setFlavor(String name) {
    _flavor = name;
  }

  setName(String name) {
    _fullname = name;
  }

  setLang(String lang) {
    _lang = lang;
  }

  setPhone(String phone) {
    _phone = phone;
  }

  setDistrict(District? district) {
    _district = _district;
  }

  setState(State state) {
    _state = state;
  }

  setClass(Class kClass) {
    _class = kClass;
  }

  setSchool(School school) {
    _school = _school;
  }

  setAge(int age) {
    _age = age;
  }

  setReferenceCode(String code) {
    _reference_code = code;
  }

  resetDistrict() {
    return RegistrationBody(
      district: null,
      state: this.state,
      school: this.school,
      phone: this.phone,
      kClass: this.kClass,
      fullname: this.fullname,
      age: this.age,
      accountType: this.accountType,
    );
  }

  RegistrationBody copyWith(
      {String? fullname,
      String? phone,
      State? state,
      District? district,
      int? age,
      Class? kClass,
      School? school,
      int? accountType,
      String? reference_code,
      int? reference_code_id,
      String? lang,
      String? flavor}) {
    return RegistrationBody(
        district: district ?? this.district,
        state: state ?? this.state,
        age: age ?? this.age,
        fullname: fullname ?? this.fullname,
        kClass: kClass ?? this.kClass,
        phone: phone ?? this.phone,
        school: school ?? this.school,
        accountType: accountType ?? this.accountType,
        reference_code: reference_code ?? this.reference_code,
        reference_code_id: reference_code_id ?? this.reference_code_id,
        lang: lang ?? _lang,
        flavor: flavor ?? this.flavor);
  }

  RegistrationBody(
      {String? fullname,
      String? phone,
      State? state,
      District? district,
      int? age,
      Class? kClass,
      School? school,
      int? accountType,
      String? reference_code,
      int? reference_code_id,
      String? lang,
      String? flavor}) {
    _fullname = fullname;
    _phone = phone;
    _state = state;
    _district = district;
    _age = age;
    _class = kClass;
    _school = school;
    _accountType = accountType;
    _reference_code = reference_code;
    _reference_code_id = reference_code_id;
    _lang = lang;
    _flavor = flavor;
  }

  RegistrationBody.fromJson(dynamic json) {
    _fullname = json["fullname"];
    _accountType = json["accountType"];
    _reference_code = json["reference_code"];
    _phone = json["phone"];
    _state = json["state"] != null ? State.fromJson(json["state"]) : null;
    _district =
        json["district"] != null ? District.fromJson(json["district"]) : null;
    _age = json["age"];
    _class = json["class"] != null ? Class.fromJson(json["class"]) : null;
    _school = json["school"] != null ? School.fromJson(json["school"]) : null;
    _reference_code_id = json["reference_code_id"];
    _lang = json["lang"];
    _flavor = json["flavor"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["fullname"] = _fullname;
    map["phone"] = _phone;
    map["accountType"] = _accountType;
    map["reference_code"] = _reference_code;
    map["reference_code_id"] = _reference_code_id;
    map["lang"] = _lang;
    map["flavor"] = _flavor;
    if (_state != null) {
      map["state"] = _state?.toJson();
    }
    if (_district != null) {
      map["district"] = _district?.toJson();
    }
    map["age"] = _age;
    if (_class != null) {
      map["class"] = _class?.toJson();
    }
    if (_school != null) {
      map["school"] = _school?.toJson();
    }
    return map;
  }
}

class School {
  int? _id;
  String? _name;

  int? get id => _id;
  String? get name => _name;

  School({int? id, String? name}) {
    _id = id;
    _name = name;
  }

  School.fromJson(dynamic json) {
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

class Class {
  int? _id;
  String? _name;

  int? get id => _id;
  String? get name => _name;

  Class({int? id, String? name}) {
    _id = id;
    _name = name;
  }

  Class.fromJson(dynamic json) {
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

class State {
  int? _id;
  String? _name;

  int? get id => _id;
  String? get name => _name;

  State({int? id, String? name}) {
    _id = id;
    _name = name;
  }

  State.fromJson(dynamic json) {
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
