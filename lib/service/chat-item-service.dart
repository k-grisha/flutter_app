import 'dart:collection';

import 'package:flutter_app/model/chat-item.dart';
import 'package:flutter_app/repository/user-repository.dart';
import 'package:intl/intl.dart';

import 'preferences-service.dart';

class ChatItemService {
  final UserRepository _userRepository;
  final PreferencesService _preferences;

  ChatItemService(this._userRepository, this._preferences);

  Future<List<ChatItem>> getAllItems() async {
    String uuid = await _preferences.getUuid();
    var result = await _userRepository.getChatList(uuid);
    result.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
    return result;
  }

  // Future<int> getSize() async {
  //   String uuid = await _preferences.getUuid();
  //   return (await _userRepository.getChatList(uuid)).length;
  // }

}
