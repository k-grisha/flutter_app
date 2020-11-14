import 'package:flutter_app/model/chat-message.dart';
import 'package:flutter_app/repository/message-repository.dart';

class ChatMessageService {
  final List<ChatMessage> _messages = [
    ChatMessage(1, "b", "a", "hallo", DateTime.now().subtract(Duration(minutes: 12))),
    ChatMessage(2, "b", "a", "How are you?", DateTime.now().subtract(Duration(minutes: 7))),
    ChatMessage(3, "a", "b", "hi", DateTime.now().subtract(Duration(minutes: 2))),
    ChatMessage(4, "a", "b", "I fine"),
    ChatMessage(5, "a", "b", "I fine1"),
    ChatMessage(6, "b", "a", "I fine669"),
  ];
  MessageRepository _messageRepository;

  ChatMessageService() {
    _messageRepository = new MessageRepository();
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
}
