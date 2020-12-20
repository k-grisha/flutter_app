import 'package:flutter_app/model/chat-user.dart';
import 'package:sqflite/sqflite.dart';

import 'db-helper.dart';

class UserRepository {
  static const String _TABLE_USER = "user";
  static const String _COLUMN_UUID = "uuid";
  static const String _COLUMN_NAME = "name";
  Future<Database> database;

  UserRepository() {
    database = DbHelper.initDbConnection();
  }

  // Future<Database> initDbConnection() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   return openDatabase(
  //     join(await getDatabasesPath(), 'messages_database4.db'),
  //     onCreate: (db, version) {
  //       return db.execute(
  //         'CREATE TABLE $_TABLE_USER ($_COLUMN_UUID CHARACTER(36) PRIMARY KEY, $_COLUMN_NAME CHARACTER(50))',
  //       );
  //     },
  //     version: 1,
  //   );
  // }

  Future<void> save(ChatUser user) async {
    final Database db = await database;
    await db.insert(
      _TABLE_USER,
      toMap(user),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<ChatUser> getUser(String uuid) async {
    final Database db = await database;
    List<Map> maps = await db.query(_TABLE_USER, where: _COLUMN_UUID + '=?', whereArgs: [uuid], limit: 1);
    return maps.isEmpty ? null : maps.map((m) => fromMap(m)).first;
  }

  ChatUser fromMap(Map<String, dynamic> map) {
    return ChatUser(map[_COLUMN_UUID], map[_COLUMN_NAME]);
  }

  Map<String, dynamic> toMap(ChatUser user) {
    return {
      _COLUMN_UUID: user.uuid,
      _COLUMN_NAME: user.name,
    };
  }
}
