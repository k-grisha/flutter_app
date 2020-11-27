class ChatMessage {
  int id;
  String sender;
  String recipient;
  String message;
  DateTime received;

  ChatMessage(this.id, this.sender, this.recipient, this.message, [DateTime received]) {
    this.received = received ?? DateTime.now();
  }
}
