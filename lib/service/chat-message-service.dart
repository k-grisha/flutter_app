import 'package:flutter_app/model/chat-message.dart';

class ChatMessageService {
  final List<ChatMessage> _messages = [
    ChatMessage("b", "a", "hallo", DateTime.now().subtract(Duration(minutes: 12))),
    ChatMessage("b", "a", "How are you?", DateTime.now().subtract(Duration(minutes: 7))),
    ChatMessage("a", "b", "hi", DateTime.now().subtract(Duration(minutes: 2))),
    ChatMessage("a", "b", "I fine"),
    // ChatMessage("a", "b", "I fine1"),
    // ChatMessage("a", "b", "I fine2"),
    // ChatMessage("a", "b", "I fine3"),
    // ChatMessage("a", "b", "I fine4"),
    // ChatMessage("a", "b", "I fine5"),
    // ChatMessage("a", "b", "I fine6"),
  ];

  ChatMessageService() {
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
    _messages.add(ChatMessage("a", "b", message));
    _messages.sort((a, b) => b.received.compareTo(a.received));
  }
}
