class ChatItem {
  String name;
  String lastMessage;
  DateTime lastMessageTime;
  int unread;

  ChatItem(this.name, this.lastMessage, this.lastMessageTime, [this.unread = 0]);
}
