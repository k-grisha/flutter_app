class ChatMessage {
  int id;
  String sender;
  String recipient;
  String message;
  DateTime received;

  ChatMessage(this.id, this.sender, this.recipient, this.message, [DateTime received]) {
    this.received = received ?? DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': sender,
      'recipient': recipient,
      'message': message,
      'received': received.toIso8601String(),
    };
  }
}
