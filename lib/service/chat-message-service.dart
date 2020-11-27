import 'package:flutter_app/client/chat-clietn.dart';
import 'package:flutter_app/model/chat-message.dart';
import 'package:flutter_app/repository/message-repository.dart';
import 'package:logger/logger.dart';

import 'preferences-service.dart';

class ChatMessageService {
  final List<ChatMessage> _messages = [
    ChatMessage(1, "b", "a", "hallo", DateTime.now().subtract(Duration(minutes: 12))),
    ChatMessage(2, "b", "a", "How are you?", DateTime.now().subtract(Duration(minutes: 7))),
    ChatMessage(3, "a", "b", "hi", DateTime.now().subtract(Duration(minutes: 2))),
    ChatMessage(4, "a", "b", "I fine"),
    ChatMessage(5, "a", "b", "I fine1"),
    ChatMessage(6, "b", "a", "I fine669"),
  ];
  final MessageRepository _messageRepository;
  final ChatClient _chatClient;
  final PreferencesService _preferences;
  var logger = Logger();

  ChatMessageService(this._messageRepository, this._chatClient, this._preferences) {
    // _messageRepository.save(ChatMessage(999, "a", "b", "msg"));
    _messages.sort((a, b) => b.received.compareTo(a.received));
  }

  ChatMessage getMessagesFrom(String from, int i) {
    if (i + 1 >= _messages.length) {
      print("Try to fetch more message");
    }
    return _messages[i];
  }

  int getMessageCount() {
    return _messages.length;
  }

  addMessage(String message) {
    _messages.add(ChatMessage(99, "a", "b", message));
    _messages.sort((a, b) => b.received.compareTo(a.received));
  }

  Future<List<ChatMessage>> getAllMessages(String sender) async {
    String uuid = await _preferences.getUuid();
    if (uuid == null) {
      return null;
    }
    var res = await _messageRepository.getAll(uuid, sender);

    return res;
  }

  runMessageUpdater() async {
    while (true) {
      String uuid = await _preferences.getUuid();
      if (uuid == null) {
        await new Future.delayed(const Duration(milliseconds: 3000));
        continue;
      }
      int lastId = await _messageRepository.getMaxMessageId(uuid);
      var messageDtoResponse = await _chatClient.getMessage(uuid, lastId == null ? 0 : lastId);

      if (messageDtoResponse.errorCode != 0) {
        logger.w(messageDtoResponse.message);
        return;
      }

      var messages =
          messageDtoResponse.body.map((dto) => ChatMessage(dto.id, dto.sender, dto.recipient, dto.message)).toList();
      print("RECIEVE MESSAGESSS " + messages.length.toString());
      _messageRepository.saveAll(messages);
    }
  }
}
