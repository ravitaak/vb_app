import 'package:drift/drift.dart';
import 'package:vb_app/data/database/db.dart';
import 'package:vb_app/data/database/tables/user.dart';

part 'user.g.dart';

@DriftAccessor(tables: [TbUser])
class UserDao extends DatabaseAccessor<Database> with _$UserDaoMixin {
  UserDao(Database db) : super(db);

  Future<int> addUser(TbUserCompanion user) {
    return into(tbUser).insert(user);
  }

  Future<int> removeUser() {
    return delete(tbUser).go();
  }

  Future<TbUserData?> getUser() {
    return select(tbUser).getSingle();
  }

  Future<bool> updateUser(TbUserData entity) async {
    return await update(tbUser).replace(entity);
  }
}
