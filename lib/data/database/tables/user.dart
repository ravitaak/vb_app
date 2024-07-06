import 'package:drift/drift.dart';

class TbUser extends Table {
  IntColumn get localId => integer().autoIncrement()();
  IntColumn get id => integer()();
  TextColumn get fullname => text()();
  TextColumn get phone => text()();
  TextColumn get shareLink => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();
  TextColumn get reference_code => text().nullable()();
}
