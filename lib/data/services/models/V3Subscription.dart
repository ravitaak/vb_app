import 'package:vb_app/data/services/models/Coupon.dart';

class V3Subscription {
  V3Subscription({
    List<Subscription>? subscription,
    List<Coupon>? coupons,
  }) {
    _subscription = subscription;
    _coupons = coupons;
  }

  V3Subscription.fromJson(dynamic json) {
    if (json['subscription'] != null) {
      _subscription = [];
      json['subscription'].forEach((v) {
        _subscription?.add(Subscription.fromJson(v));
      });
    }
    if (json['coupons'] != null) {
      _coupons = [];
      json['coupons'].forEach((v) {
        _coupons?.add(Coupon.fromJson(v));
      });
    }
  }
  List<Subscription>? _subscription;
  List<Coupon>? _coupons;
  V3Subscription copyWith({
    List<Subscription>? subscription,
    List<Coupon>? coupons,
  }) =>
      V3Subscription(
        subscription: subscription ?? _subscription,
        coupons: coupons ?? _coupons,
      );
  List<Subscription>? get subscription => _subscription;
  List<Coupon>? get coupons => _coupons;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_subscription != null) {
      map['subscription'] = _subscription?.map((v) => v.toJson()).toList();
    }
    if (_coupons != null) {
      map['coupons'] = _coupons?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Subscription {
  Subscription({
    int? id,
    String? name,
    String? price_text,
    bool? swap_title_and_duration,
    String? prefix,
    bool? prefix_inline,
    String? suffix,
    bool? suffix_inline,
    bool? showCouponsPage,
    bool? showGatewaysPage,
    bool? vbAvailable,
    bool? recurring,
    bool? trial,
    String? description,
    String? htmlDescription,
    String? disclaimerDynamicWidget,
    String? disclaimerHtml,
    String? gradient,
    int? price,
    int? cuttedOutPrice,
    int? iosPrice,
    int? class6,
    int? class7,
    int? class8,
    int? class9,
    int? class10,
    int? class11,
    int? class12,
    String? createdAt,
    int? duration,
    List<dynamic>? coupon,
    int? position,
    String? videoLink,
    String? offerTagline,
    bool? showInCart,
    bool? popular,
    bool? android,
    bool? ios,
    List<Gateway>? gateway,
    int? recommendedGateway,
    String? addons,
    int? sub_start_at,
    int? total_count,
  }) {
    _id = id;
    _name = name;
    _price_text = price_text;
    _swap_title_and_duration = swap_title_and_duration;
    _prefix = prefix;
    _prefix_inline = prefix_inline;
    _suffix = suffix;
    _suffix_inline = suffix_inline;
    _showCouponsPage = showCouponsPage;
    _showGatewaysPage = showGatewaysPage;
    _vbAvailable = vbAvailable;
    _recurring = recurring;
    _trial = trial;
    _description = description;
    _htmlDescription = htmlDescription;
    _disclaimerDynamicWidget = disclaimerDynamicWidget;
    _disclaimerHtml = disclaimerHtml;
    _gradient = gradient;
    _price = price;
    _cuttedOutPrice = cuttedOutPrice;
    _iosPrice = iosPrice;
    _class6 = class6;
    _class7 = class7;
    _class8 = class8;
    _class9 = class9;
    _class10 = class10;
    _class11 = class11;
    _class12 = class12;
    _createdAt = createdAt;
    _duration = duration;
    _coupon = coupon;
    _position = position;
    _videoLink = videoLink;
    _offerTagline = offerTagline;
    _showInCart = showInCart;
    _popular = popular;
    _android = android;
    _ios = ios;
    _gateway = gateway;
    _recommendedGateway = recommendedGateway;
    _addons = addons;
    _sub_start_at = sub_start_at;
    _total_count = total_count;
  }

  Subscription.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _price_text = json["price_text"];
    _prefix = json["prefix"];
    _swap_title_and_duration = json["swap_title_and_duration"];
    _prefix_inline = json["prefix_inline"];
    _suffix = json["suffix"];
    _suffix_inline = json["suffix_inline"];
    _showCouponsPage = json['show_coupons_page'];
    _showGatewaysPage = json['show_gateways_page'];
    _vbAvailable = json['vb_available'];
    _recurring = json['recurring'];
    _trial = json['trial'];
    _description = json['description'];
    _htmlDescription = json['html_description'];
    _disclaimerDynamicWidget = json['disclaimer_dynamic_widget'];
    _disclaimerHtml = json['disclaimer_html'];
    _gradient = json['gradient'];
    _price = json['price'];
    _cuttedOutPrice = json['cutted_out_price'];
    _iosPrice = json['ios_price'];
    _class6 = json['class6'];
    _class7 = json['class7'];
    _class8 = json['class8'];
    _class9 = json['class9'];
    _class10 = json['class10'];
    _class11 = json['class11'];
    _class12 = json['class12'];
    _createdAt = json['createdAt'];
    _duration = json['duration'];
    _sub_start_at = json["sub_start_at"];
    _total_count = json["total_count"];
    _addons = json["addons"];
    if (json['coupon'] != null) {
      _coupon = [];
      json['coupon'].forEach((v) {
        _coupon?.add(v);
      });
    }
    _position = json['position'];
    _videoLink = json['video_link'];
    _offerTagline = json['offer_tagline'];
    _showInCart = json['show_in_cart'];
    _popular = json['popular'];
    _android = json['android'];
    _ios = json['ios'];
    if (json['gateway'] != null) {
      _gateway = [];
      json['gateway'].forEach((v) {
        _gateway?.add(Gateway.fromJson(v));
      });
    }
    _recommendedGateway = json['recommended_gateway'];
  }
  int? _id;
  String? _name;
  String? _price_text;
  String? _suffix;
  bool? _swap_title_and_duration;
  bool? _suffix_inline;
  String? _prefix;
  bool? _prefix_inline;
  bool? _showCouponsPage;
  bool? _showGatewaysPage;
  bool? _vbAvailable;
  bool? _recurring;
  bool? _trial;
  String? _description;
  String? _htmlDescription;
  String? _disclaimerDynamicWidget;
  String? _disclaimerHtml;
  String? _gradient;
  String? _addons;
  int? _sub_start_at;
  int? _price;
  int? _cuttedOutPrice;
  int? _iosPrice;
  int? _class6;
  int? _class7;
  int? _class8;
  int? _class9;
  int? _class10;
  int? _class11;
  int? _class12;
  String? _createdAt;
  int? _duration;
  List<dynamic>? _coupon;
  int? _position;
  String? _videoLink;
  String? _offerTagline;
  bool? _showInCart;
  bool? _popular;
  bool? _android;
  bool? _ios;
  List<Gateway>? _gateway;
  int? _recommendedGateway;
  int? _total_count;
  Subscription copyWith(
          {int? id,
          String? name,
          String? price_text,
          String? prefix,
          bool? swap_title_and_duration,
          bool? prefix_inline,
          String? suffix,
          bool? suffix_inline,
          bool? showCouponsPage,
          bool? showGatewaysPage,
          bool? vbAvailable,
          bool? recurring,
          bool? trial,
          String? description,
          String? htmlDescription,
          String? disclaimerDynamicWidget,
          String? disclaimerHtml,
          String? gradient,
          int? price,
          int? cuttedOutPrice,
          int? iosPrice,
          int? class6,
          int? class7,
          int? class8,
          int? class9,
          int? class10,
          int? class11,
          int? class12,
          String? createdAt,
          int? duration,
          List<dynamic>? coupon,
          int? position,
          String? videoLink,
          String? offerTagline,
          bool? showInCart,
          bool? popular,
          bool? android,
          bool? ios,
          List<Gateway>? gateway,
          int? recommendedGateway,
          int? sub_start_at,
          int? total_count,
          String? addons}) =>
      Subscription(
          id: id ?? _id,
          name: name ?? _name,
          price_text: price_text ?? _price_text,
          showCouponsPage: showCouponsPage ?? _showCouponsPage,
          showGatewaysPage: showGatewaysPage ?? _showGatewaysPage,
          vbAvailable: vbAvailable ?? _vbAvailable,
          recurring: recurring ?? _recurring,
          trial: trial ?? _trial,
          description: description ?? _description,
          htmlDescription: htmlDescription ?? _htmlDescription,
          disclaimerDynamicWidget: disclaimerDynamicWidget ?? _disclaimerDynamicWidget,
          disclaimerHtml: disclaimerHtml ?? _disclaimerHtml,
          gradient: gradient ?? _gradient,
          price: price ?? _price,
          cuttedOutPrice: cuttedOutPrice ?? _cuttedOutPrice,
          iosPrice: iosPrice ?? _iosPrice,
          class6: class6 ?? _class6,
          class7: class7 ?? _class7,
          class8: class8 ?? _class8,
          class9: class9 ?? _class9,
          class10: class10 ?? _class10,
          class11: class11 ?? _class11,
          class12: class12 ?? _class12,
          createdAt: createdAt ?? _createdAt,
          duration: duration ?? _duration,
          coupon: coupon ?? _coupon,
          position: position ?? _position,
          videoLink: videoLink ?? _videoLink,
          offerTagline: offerTagline ?? _offerTagline,
          showInCart: showInCart ?? _showInCart,
          popular: popular ?? _popular,
          android: android ?? _android,
          ios: ios ?? _ios,
          gateway: gateway ?? _gateway,
          recommendedGateway: recommendedGateway ?? _recommendedGateway,
          addons: addons ?? _addons,
          sub_start_at: sub_start_at ?? _sub_start_at,
          prefix: prefix ?? _prefix,
          suffix: suffix ?? _suffix,
          prefix_inline: prefix_inline ?? _prefix_inline,
          suffix_inline: suffix_inline ?? _suffix_inline,
          total_count: total_count ?? _total_count,
          swap_title_and_duration: swap_title_and_duration ?? _swap_title_and_duration);
  int? get id => _id;
  String? get name => _name;
  String? get price_text => _price_text;
  String? get prefix => _prefix;
  String? get suffix => _suffix;
  bool? get suffix_inline => _suffix_inline;
  bool? get prefix_inline => _prefix_inline;
  bool? get showCouponsPage => _showCouponsPage;
  bool? get showGatewaysPage => _showGatewaysPage;
  bool? get vbAvailable => _vbAvailable;
  bool? get recurring => _recurring;
  bool? get trial => _trial;
  String? get description => _description;
  String? get htmlDescription => _htmlDescription;
  String? get disclaimerDynamicWidget => _disclaimerDynamicWidget;
  String? get disclaimerHtml => _disclaimerHtml;
  String? get gradient => _gradient;
  int? get price => _price;
  int? get cuttedOutPrice => _cuttedOutPrice;
  int? get iosPrice => _iosPrice;
  int? get class6 => _class6;
  int? get class7 => _class7;
  int? get class8 => _class8;
  int? get class9 => _class9;
  int? get class10 => _class10;
  int? get class11 => _class11;
  int? get class12 => _class12;
  String? get createdAt => _createdAt;
  int? get duration => _duration;
  List<dynamic>? get coupon => _coupon;
  int? get position => _position;
  String? get videoLink => _videoLink;
  String? get offerTagline => _offerTagline;
  bool? get showInCart => _showInCart;
  bool? get popular => _popular;
  bool? get android => _android;
  bool? get ios => _ios;
  List<Gateway>? get gateway => _gateway;
  int? get recommendedGateway => _recommendedGateway;
  int? get sub_start_at => _sub_start_at;
  String? get addons => _addons;
  int? get total_count => _total_count;
  bool? get swap_title_and_duration => _swap_title_and_duration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['price_text'] = _price_text;
    map['prefix'] = _prefix;
    map['prefix_inline'] = _prefix_inline;
    map['suffix'] = _suffix;
    map['suffix_inline'] = _suffix_inline;
    map['show_coupons_page'] = _showCouponsPage;
    map['show_gateways_page'] = _showGatewaysPage;
    map['vb_available'] = _vbAvailable;
    map['recurring'] = _recurring;
    map['trial'] = _trial;
    map['description'] = _description;
    map['html_description'] = _htmlDescription;
    map['disclaimer_dynamic_widget'] = _disclaimerDynamicWidget;
    map['disclaimer_html'] = _disclaimerHtml;
    map['gradient'] = _gradient;
    map['price'] = _price;
    map['cutted_out_price'] = _cuttedOutPrice;
    map['ios_price'] = _iosPrice;
    map['class6'] = _class6;
    map['class7'] = _class7;
    map['class8'] = _class8;
    map['class9'] = _class9;
    map['class10'] = _class10;
    map['class11'] = _class11;
    map['class12'] = _class12;
    map['createdAt'] = _createdAt;
    map['duration'] = _duration;
    map["addons"] = _addons;
    map["swap_title_and_duration"] = _swap_title_and_duration;
    map["sub_start_at"] = _sub_start_at;
    if (_coupon != null) {
      map['coupon'] = _coupon?.map((v) => v.toJson()).toList();
    }
    map['position'] = _position;
    map['video_link'] = _videoLink;
    map['offer_tagline'] = _offerTagline;
    map['show_in_cart'] = _showInCart;
    map['popular'] = _popular;
    map['android'] = _android;
    map['ios'] = _ios;
    if (_gateway != null) {
      map['gateway'] = _gateway?.map((v) => v.toJson()).toList();
    }
    map['recommended_gateway'] = _recommendedGateway;
    map["total_count"] = _total_count;
    return map;
  }

  setPrice(int p) {
    _price = p;
  }
}

class Gateway {
  Gateway({
    String? name,
    int? id,
    String? description,
  }) {
    _name = name;
    _id = id;
    _description = description;
  }

  Gateway.fromJson(dynamic json) {
    _name = json['name'];
    _id = json['id'];
    _description = json['description'];
  }
  String? _name;
  int? _id;
  String? _description;
  Gateway copyWith({
    String? name,
    int? id,
    String? description,
  }) =>
      Gateway(
        name: name ?? _name,
        id: id ?? _id,
        description: description ?? _description,
      );
  String? get name => _name;
  int? get id => _id;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['id'] = _id;
    map['description'] = _description;
    return map;
  }
}
