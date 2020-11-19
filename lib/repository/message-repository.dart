import 'package:flutter/widgets.dart';
import 'package:flutter_app/model/chat-message.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MessageRepository {
  static const String _TABLE_MESSAGES = "messages";
  Future<Database> database;

  MessageRepository() {
    database = initDbConnection();
  }

  Future<Database> initDbConnection() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), 'messages_database4.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE " +
              _TABLE_MESSAGES +
              "(id INTEGER PRIMARY KEY, sender CHARACTER(36), recipient CHARACTER(36), message TEXT, received TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> save(ChatMessage message) async {
    final Database db = await database;
    await db.insert(
      _TABLE_MESSAGES,
      message.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<void> saveAll(List<ChatMessage> messages) async {
    final Database db = await database;
    var batch = db.batch();
    messages.forEach((msg) {
      batch.insert(_TABLE_MESSAGES, msg.toMap());
    });
    await batch.commit(noResult: true);
  }

  Future<int> getMaxMessageId(String uuid) async {
    final Database db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery("SELECT MAX(id) FROM " + _TABLE_MESSAGES + " WHERE recipient='" + uuid + "'"));
  }
}
