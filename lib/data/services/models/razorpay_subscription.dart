import 'dart:developer';

class RazorpaySubscription {
  RazorpaySubscription({
    String? id,
    String? entity,
    String? planId,
    String? status,
    dynamic currentStart,
    dynamic currentEnd,
    dynamic endedAt,
    int? quantity,
    List<dynamic>? notes,
    int? chargeAt,
    int? startAt,
    int? endAt,
    int? authAttempts,
    int? totalCount,
    int? paidCount,
    bool? customerNotify,
    int? createdAt,
    dynamic expireBy,
    String? shortUrl,
    bool? hasScheduledChanges,
    dynamic changeScheduledAt,
    String? source,
    int? remainingCount,
  }) {
    _id = id;
    _entity = entity;
    _planId = planId;
    _status = status;
    _currentStart = currentStart;
    _currentEnd = currentEnd;
    _endedAt = endedAt;
    _quantity = quantity;
    _notes = notes;
    _chargeAt = chargeAt;
    _startAt = startAt;
    _endAt = endAt;
    _authAttempts = authAttempts;
    _totalCount = totalCount;
    _paidCount = paidCount;
    _customerNotify = customerNotify;
    _createdAt = createdAt;
    _expireBy = expireBy;
    _shortUrl = shortUrl;
    _hasScheduledChanges = hasScheduledChanges;
    _changeScheduledAt = changeScheduledAt;
    _source = source;
    _remainingCount = remainingCount;
  }

  RazorpaySubscription.fromJson(dynamic json) {
    log(json.toString(), name: "fromJson");
    _id = json['id'];
    _entity = json['entity'];
    _planId = json['plan_id'];
    _status = json['status'];
    _currentStart = json['current_start'];
    _currentEnd = json['current_end'];
    _endedAt = json['ended_at'];
    _quantity = json['quantity'];
    if (json['notes'] != null) {
      _notes = [];
      json['notes'].forEach((v) {
        _notes?.add(v);
      });
    }
    _chargeAt = json['charge_at'];
    _startAt = json['start_at'];
    _endAt = json['end_at'];
    _authAttempts = json['auth_attempts'];
    _totalCount = json['total_count'];
    _paidCount = json['paid_count'];
    _customerNotify = json['customer_notify'];
    _createdAt = json['created_at'];
    _expireBy = json['expire_by'];
    _shortUrl = json['short_url'];
    _hasScheduledChanges = json['has_scheduled_changes'];
    _changeScheduledAt = json['change_scheduled_at'];
    _source = json['source'];
    _remainingCount = json['remaining_count'];
  }
  String? _id;
  String? _entity;
  String? _planId;
  String? _status;
  dynamic _currentStart;
  dynamic _currentEnd;
  dynamic _endedAt;
  int? _quantity;
  List<dynamic>? _notes;
  int? _chargeAt;
  int? _startAt;
  int? _endAt;
  int? _authAttempts;
  int? _totalCount;
  int? _paidCount;
  bool? _customerNotify;
  int? _createdAt;
  dynamic _expireBy;
  String? _shortUrl;
  bool? _hasScheduledChanges;
  dynamic _changeScheduledAt;
  String? _source;
  int? _remainingCount;
  RazorpaySubscription copyWith({
    String? id,
    String? entity,
    String? planId,
    String? status,
    dynamic currentStart,
    dynamic currentEnd,
    dynamic endedAt,
    int? quantity,
    List<dynamic>? notes,
    int? chargeAt,
    int? startAt,
    int? endAt,
    int? authAttempts,
    int? totalCount,
    int? paidCount,
    bool? customerNotify,
    int? createdAt,
    dynamic expireBy,
    String? shortUrl,
    bool? hasScheduledChanges,
    dynamic changeScheduledAt,
    String? source,
    int? remainingCount,
  }) =>
      RazorpaySubscription(
        id: id ?? _id,
        entity: entity ?? _entity,
        planId: planId ?? _planId,
        status: status ?? _status,
        currentStart: currentStart ?? _currentStart,
        currentEnd: currentEnd ?? _currentEnd,
        endedAt: endedAt ?? _endedAt,
        quantity: quantity ?? _quantity,
        notes: notes ?? _notes,
        chargeAt: chargeAt ?? _chargeAt,
        startAt: startAt ?? _startAt,
        endAt: endAt ?? _endAt,
        authAttempts: authAttempts ?? _authAttempts,
        totalCount: totalCount ?? _totalCount,
        paidCount: paidCount ?? _paidCount,
        customerNotify: customerNotify ?? _customerNotify,
        createdAt: createdAt ?? _createdAt,
        expireBy: expireBy ?? _expireBy,
        shortUrl: shortUrl ?? _shortUrl,
        hasScheduledChanges: hasScheduledChanges ?? _hasScheduledChanges,
        changeScheduledAt: changeScheduledAt ?? _changeScheduledAt,
        source: source ?? _source,
        remainingCount: remainingCount ?? _remainingCount,
      );
  String? get id => _id;
  String? get entity => _entity;
  String? get planId => _planId;
  String? get status => _status;
  dynamic get currentStart => _currentStart;
  dynamic get currentEnd => _currentEnd;
  dynamic get endedAt => _endedAt;
  int? get quantity => _quantity;
  List<dynamic>? get notes => _notes;
  int? get chargeAt => _chargeAt;
  int? get startAt => _startAt;
  int? get endAt => _endAt;
  int? get authAttempts => _authAttempts;
  int? get totalCount => _totalCount;
  int? get paidCount => _paidCount;
  bool? get customerNotify => _customerNotify;
  int? get createdAt => _createdAt;
  dynamic get expireBy => _expireBy;
  String? get shortUrl => _shortUrl;
  bool? get hasScheduledChanges => _hasScheduledChanges;
  dynamic get changeScheduledAt => _changeScheduledAt;
  String? get source => _source;
  int? get remainingCount => _remainingCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['entity'] = _entity;
    map['plan_id'] = _planId;
    map['status'] = _status;
    map['current_start'] = _currentStart;
    map['current_end'] = _currentEnd;
    map['ended_at'] = _endedAt;
    map['quantity'] = _quantity;
    if (_notes != null) {
      map['notes'] = _notes?.map((v) => v.toJson()).toList();
    }
    map['charge_at'] = _chargeAt;
    map['start_at'] = _startAt;
    map['end_at'] = _endAt;
    map['auth_attempts'] = _authAttempts;
    map['total_count'] = _totalCount;
    map['paid_count'] = _paidCount;
    map['customer_notify'] = _customerNotify;
    map['created_at'] = _createdAt;
    map['expire_by'] = _expireBy;
    map['short_url'] = _shortUrl;
    map['has_scheduled_changes'] = _hasScheduledChanges;
    map['change_scheduled_at'] = _changeScheduledAt;
    map['source'] = _source;
    map['remaining_count'] = _remainingCount;
    return map;
  }
}
