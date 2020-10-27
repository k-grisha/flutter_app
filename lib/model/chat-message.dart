class ChatMessage {
  String fromUuid;
  String toUuid;
  String message;
  DateTime received;

  ChatMessage(this.fromUuid, this.toUuid, this.message, [DateTime received]) {
    this.received = received ?? DateTime.now();
  }
}
