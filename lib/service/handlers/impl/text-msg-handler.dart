import 'package:flutter_app/dto/message-dto.dart';
import 'package:flutter_app/model/chat-message.dart';
import 'package:flutter_app/repository/message-repository.dart';

import '../handlers-registry.dart';

class TextMsgHandler implements MsgHandler {
  final MessageRepository _messageRepository;

  TextMsgHandler(this._messageRepository);

  @override
  handleMsg(MessageDto messageDto) {
    var textMessage = new TextMessage(messageDto.id, messageDto.sender, messageDto.recipient, messageDto.body);
    _messageRepository.save(textMessage);
  }
}
