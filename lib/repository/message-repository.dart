import 'package:flutter/widgets.dart';
import 'package:flutter_app/model/chat-message.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MessageRepository {
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
          "CREATE TABLE messages(id INTEGER PRIMARY KEY, sender CHARACTER(36), recipient CHARACTER(36), message TEXT, received TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> save(ChatMessage message) async {
    final Database db = await database;
    await db.insert(
      'messages',
      message.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }
}
