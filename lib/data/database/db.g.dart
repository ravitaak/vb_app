// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $TbUserTable extends TbUser with TableInfo<$TbUserTable, TbUserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TbUserTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta =
      const VerificationMeta('localId');
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
      'local_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _fullnameMeta =
      const VerificationMeta('fullname');
  @override
  late final GeneratedColumn<String> fullname = GeneratedColumn<String>(
      'fullname', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shareLinkMeta =
      const VerificationMeta('shareLink');
  @override
  late final GeneratedColumn<String> shareLink = GeneratedColumn<String>(
      'share_link', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDate);
  static const VerificationMeta _reference_codeMeta =
      const VerificationMeta('reference_code');
  @override
  late final GeneratedColumn<String> reference_code = GeneratedColumn<String>(
      'reference_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [localId, id, fullname, phone, shareLink, createdAt, reference_code];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_user';
  @override
  VerificationContext validateIntegrity(Insertable<TbUserData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(_localIdMeta,
          localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('fullname')) {
      context.handle(_fullnameMeta,
          fullname.isAcceptableOrUnknown(data['fullname']!, _fullnameMeta));
    } else if (isInserting) {
      context.missing(_fullnameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('share_link')) {
      context.handle(_shareLinkMeta,
          shareLink.isAcceptableOrUnknown(data['share_link']!, _shareLinkMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('reference_code')) {
      context.handle(
          _reference_codeMeta,
          reference_code.isAcceptableOrUnknown(
              data['reference_code']!, _reference_codeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  TbUserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TbUserData(
      localId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}local_id'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      fullname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fullname'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      shareLink: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}share_link']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      reference_code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference_code']),
    );
  }

  @override
  $TbUserTable createAlias(String alias) {
    return $TbUserTable(attachedDatabase, alias);
  }
}

class TbUserData extends DataClass implements Insertable<TbUserData> {
  final int localId;
  final int id;
  final String fullname;
  final String phone;
  final String? shareLink;
  final DateTime createdAt;
  final String? reference_code;
  const TbUserData(
      {required this.localId,
      required this.id,
      required this.fullname,
      required this.phone,
      this.shareLink,
      required this.createdAt,
      this.reference_code});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    map['id'] = Variable<int>(id);
    map['fullname'] = Variable<String>(fullname);
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || shareLink != null) {
      map['share_link'] = Variable<String>(shareLink);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || reference_code != null) {
      map['reference_code'] = Variable<String>(reference_code);
    }
    return map;
  }

  TbUserCompanion toCompanion(bool nullToAbsent) {
    return TbUserCompanion(
      localId: Value(localId),
      id: Value(id),
      fullname: Value(fullname),
      phone: Value(phone),
      shareLink: shareLink == null && nullToAbsent
          ? const Value.absent()
          : Value(shareLink),
      createdAt: Value(createdAt),
      reference_code: reference_code == null && nullToAbsent
          ? const Value.absent()
          : Value(reference_code),
    );
  }

  factory TbUserData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TbUserData(
      localId: serializer.fromJson<int>(json['localId']),
      id: serializer.fromJson<int>(json['id']),
      fullname: serializer.fromJson<String>(json['fullname']),
      phone: serializer.fromJson<String>(json['phone']),
      shareLink: serializer.fromJson<String?>(json['shareLink']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      reference_code: serializer.fromJson<String?>(json['reference_code']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'id': serializer.toJson<int>(id),
      'fullname': serializer.toJson<String>(fullname),
      'phone': serializer.toJson<String>(phone),
      'shareLink': serializer.toJson<String?>(shareLink),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'reference_code': serializer.toJson<String?>(reference_code),
    };
  }

  TbUserData copyWith(
          {int? localId,
          int? id,
          String? fullname,
          String? phone,
          Value<String?> shareLink = const Value.absent(),
          DateTime? createdAt,
          Value<String?> reference_code = const Value.absent()}) =>
      TbUserData(
        localId: localId ?? this.localId,
        id: id ?? this.id,
        fullname: fullname ?? this.fullname,
        phone: phone ?? this.phone,
        shareLink: shareLink.present ? shareLink.value : this.shareLink,
        createdAt: createdAt ?? this.createdAt,
        reference_code:
            reference_code.present ? reference_code.value : this.reference_code,
      );
  @override
  String toString() {
    return (StringBuffer('TbUserData(')
          ..write('localId: $localId, ')
          ..write('id: $id, ')
          ..write('fullname: $fullname, ')
          ..write('phone: $phone, ')
          ..write('shareLink: $shareLink, ')
          ..write('createdAt: $createdAt, ')
          ..write('reference_code: $reference_code')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      localId, id, fullname, phone, shareLink, createdAt, reference_code);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TbUserData &&
          other.localId == this.localId &&
          other.id == this.id &&
          other.fullname == this.fullname &&
          other.phone == this.phone &&
          other.shareLink == this.shareLink &&
          other.createdAt == this.createdAt &&
          other.reference_code == this.reference_code);
}

class TbUserCompanion extends UpdateCompanion<TbUserData> {
  final Value<int> localId;
  final Value<int> id;
  final Value<String> fullname;
  final Value<String> phone;
  final Value<String?> shareLink;
  final Value<DateTime> createdAt;
  final Value<String?> reference_code;
  const TbUserCompanion({
    this.localId = const Value.absent(),
    this.id = const Value.absent(),
    this.fullname = const Value.absent(),
    this.phone = const Value.absent(),
    this.shareLink = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.reference_code = const Value.absent(),
  });
  TbUserCompanion.insert({
    this.localId = const Value.absent(),
    required int id,
    required String fullname,
    required String phone,
    this.shareLink = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.reference_code = const Value.absent(),
  })  : id = Value(id),
        fullname = Value(fullname),
        phone = Value(phone);
  static Insertable<TbUserData> custom({
    Expression<int>? localId,
    Expression<int>? id,
    Expression<String>? fullname,
    Expression<String>? phone,
    Expression<String>? shareLink,
    Expression<DateTime>? createdAt,
    Expression<String>? reference_code,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (id != null) 'id': id,
      if (fullname != null) 'fullname': fullname,
      if (phone != null) 'phone': phone,
      if (shareLink != null) 'share_link': shareLink,
      if (createdAt != null) 'created_at': createdAt,
      if (reference_code != null) 'reference_code': reference_code,
    });
  }

  TbUserCompanion copyWith(
      {Value<int>? localId,
      Value<int>? id,
      Value<String>? fullname,
      Value<String>? phone,
      Value<String?>? shareLink,
      Value<DateTime>? createdAt,
      Value<String?>? reference_code}) {
    return TbUserCompanion(
      localId: localId ?? this.localId,
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      phone: phone ?? this.phone,
      shareLink: shareLink ?? this.shareLink,
      createdAt: createdAt ?? this.createdAt,
      reference_code: reference_code ?? this.reference_code,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fullname.present) {
      map['fullname'] = Variable<String>(fullname.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (shareLink.present) {
      map['share_link'] = Variable<String>(shareLink.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (reference_code.present) {
      map['reference_code'] = Variable<String>(reference_code.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TbUserCompanion(')
          ..write('localId: $localId, ')
          ..write('id: $id, ')
          ..write('fullname: $fullname, ')
          ..write('phone: $phone, ')
          ..write('shareLink: $shareLink, ')
          ..write('createdAt: $createdAt, ')
          ..write('reference_code: $reference_code')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $TbUserTable tbUser = $TbUserTable(this);
  late final UserDao userDao = UserDao(this as Database);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tbUser];
}
