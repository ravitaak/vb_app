import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:vb_app/data/database/daos/user/user.dart';
import 'package:vb_app/data/database/tables/user.dart';

part 'db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'SunoKitaab.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [
  TbUser,
], daos: [
  UserDao
])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
