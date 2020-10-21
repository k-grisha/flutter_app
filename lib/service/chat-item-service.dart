import 'dart:collection';

import 'package:flutter_app/model/chat-item.dart';
import 'package:intl/intl.dart';

class ChatItemService {
  final Set<ChatItem> _items = HashSet.of([
    ChatItem("Iwan", "Hello! what is you name?", DateTime.now().subtract(Duration(minutes: 1))),
    ChatItem("Гриша", "Приветк! Как дела?", DateTime.now().subtract(Duration(minutes: 2))),
    ChatItem("Степан", "Хочу написать тебе большое сообщение. ", DateTime.now().subtract(Duration(minutes: 3))),
    ChatItem("Stepa", "Сообщение от степы", DateTime.now().subtract(Duration(minutes: 4))),
    ChatItem("Иванова-Сидр-Петровна", "Хай!", DateTime.now().subtract(Duration(minutes: 5))),
    ChatItem("Grisha", "Hello! what is you name?", DateTime.now().subtract(Duration(minutes: 6))),
    ChatItem("Гриша", "Приветк! Как дела?", DateTime.now().subtract(Duration(minutes: 7)), 8),
    ChatItem("Степан", "Хочу написать тебе большое сообщение. ", DateTime.now().subtract(Duration(minutes: 8))),
    ChatItem("Stepa", "Сообщение от степы", DateTime.now().subtract(Duration(minutes: 9))),
    ChatItem("Иванова-Сидр-Петровна", "Хай!", DateTime.now().subtract(Duration(minutes: 10))),
    ChatItem("Grisha2", "Hello! what is you name?", DateTime.now().subtract(Duration(minutes: 11))),
    ChatItem("Иванова-Сидр-Петровна", "Хай!", DateTime.now().subtract(Duration(days: 1)), 5),
    ChatItem("Гриша", "Приветк! Как дела?", DateTime.now().subtract(Duration(days: 13))),
    ChatItem("Grisha3", "Hello! what is you name?", DateTime.now().subtract(Duration(days: 50))),
    ChatItem("Степан", "Хочу написать тебе большое сообщение. ", DateTime.now().subtract(Duration(days: 150))),
    ChatItem("Иванова-Сидр-Петровна4", "Хай!", DateTime.now().subtract(Duration(days: 160)), 2),
  ]);

  List<ChatItem> getAllItems() {
    var result = new List<ChatItem>.of(_items);
    result.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
    return result;
  }

  int getSize() {
    return _items.length;
  }

  String getFormatted(DateTime dateTime) {
    var now = DateTime.now();
    if (now.difference(dateTime).inDays < 1 || now.day == dateTime.day) {
      return DateFormat.Hm().format(dateTime);
    }
    return new DateFormat('d MMM').format(dateTime);
  }
//
// static String _defaultLocale = 'en_US';
//
// static String get defaultLocale {
//   var zoneLocale = Zone.current[#Intl.locale] as String;
//   return zoneLocale == null ? _defaultLocale : zoneLocale;
// }
}
