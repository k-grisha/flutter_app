import 'dart:async';

import 'package:flutter_app/client/chat-clietn.dart';
import 'package:flutter_app/dto/message-dto-response.dart';
import 'package:flutter_app/dto/message-dto.dart';
import 'package:flutter_app/model/chat-message.dart';
import 'package:flutter_app/repository/message-repository.dart';
import 'package:logger/logger.dart';

import 'preferences-service.dart';

class ChatMessageService {
  final MessageRepository _messageRepository;
  final ChatClient _chatClient;
  final PreferencesService _preferences;
  var logger = Logger();
  final List<Function> _messageListeners = new List();

  ChatMessageService(this._messageRepository, this._chatClient, this._preferences) {}

  addListener(Function listener) {
    _messageListeners.add(listener);
  }

  removeListeners() {
    _messageListeners.clear();
  }

  sendAndSaveMessage(String recipient, String message) async {
    String uuid = await _preferences.getUuid();
    MessageDtoResponse response = await _chatClient.sendMessage(uuid, MessageDto(uuid, recipient, message));
    if (response.errorCode != 0) {
      logger.w(response.message);
    } else {
      _messageRepository.save(ChatMessage(
          response.body.id, response.body.sender, response.body.recipient, response.body.message, DateTime.now()));
      updateListeners();
    }
  }

  Future<List<ChatMessage>> getAllMessagesFrom(String sender) async {
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

      updateListeners();

      _messageRepository.saveAll(messages);
    }
  }

  updateListeners() {
    for (final listener in _messageListeners) {
      listener();
    }
  }
}
