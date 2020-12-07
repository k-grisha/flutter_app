import 'package:flutter/widgets.dart';
import 'package:flutter_app/model/chat-message.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MessageRepository {
  static const String _TABLE_MESSAGES = "messages";
  static const String _COLUMN_ID = "id";
  static const String _COLUMN_SENDER = "sender";
  static const String _COLUMN_RECIPIENT = "recipient";
  static const String _COLUMN_MESSAGE = "message";
  static const String _COLUMN_RECEIVED = "received";
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
          'CREATE TABLE $_TABLE_MESSAGES ($_COLUMN_ID INTEGER PRIMARY KEY, $_COLUMN_SENDER CHARACTER(36), $_COLUMN_RECIPIENT CHARACTER(36), $_COLUMN_MESSAGE TEXT, $_COLUMN_RECEIVED TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> save(ChatMessage message) async {
    final Database db = await database;
    await db.insert(
      _TABLE_MESSAGES,
      toMap(message),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<void> saveAll(List<ChatMessage> messages) async {
    final Database db = await database;
    var batch = db.batch();
    messages.forEach((msg) {
      batch.insert(_TABLE_MESSAGES, toMap(msg));
    });
    await batch.commit(noResult: true);
  }

  Future<int> getMaxMessageId(String uuid) async {
    final Database db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery("SELECT MAX(id) FROM " + _TABLE_MESSAGES + " WHERE recipient='" + uuid + "'"));
  }

  Future<List<ChatMessage>> getAll(String recipient, String sender) async {
    final Database db = await database;
    List<Map> maps = await db.query(_TABLE_MESSAGES,
        columns: [_COLUMN_ID, _COLUMN_SENDER, _COLUMN_RECIPIENT, _COLUMN_MESSAGE, _COLUMN_RECEIVED],
        where: 'recipient = ? AND sender = ?',
        whereArgs: [recipient, sender],
        orderBy: _COLUMN_ID + ' DESC'
    );
    var res = maps.isEmpty ? [] : maps.map((m) => fromMap(m)).toList();
    return res;
  }

  ChatMessage fromMap(Map<String, dynamic> map) {
    return ChatMessage(map[_COLUMN_ID], map[_COLUMN_SENDER], map[_COLUMN_RECIPIENT], map[_COLUMN_MESSAGE],
        DateTime.parse(map[_COLUMN_RECEIVED]));
  }

  Map<String, dynamic> toMap(ChatMessage chatMessage) {
    return {
      _COLUMN_ID: chatMessage.id,
      _COLUMN_SENDER: chatMessage.sender,
      _COLUMN_RECIPIENT: chatMessage.recipient,
      _COLUMN_MESSAGE: chatMessage.message,
      _COLUMN_RECEIVED: chatMessage.received.toIso8601String(),
    };
  }
}
