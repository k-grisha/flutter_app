import 'package:flutter_app/dto/message-dto.dart';
import 'package:logger/logger.dart';

import '../handlers-registry.dart';

class UnknownMsgHandler implements MsgHandler {
  final _logger = Logger();

  @override
  handleMsg(MessageDto msgDto) {
    _logger.e("Unknown message received type: " +
        msgDto.type.toString() +
        ", from " +
        msgDto.sender +
        ", to " +
        msgDto.recipient +
        ", body:\n " +
        msgDto.body);
  }
}
