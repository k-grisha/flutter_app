import 'package:flutter/material.dart';
import 'package:flutter_app/service/chat-item-service.dart';

class ChatListView extends StatelessWidget {
  final ChatItemService chatItemService = new ChatItemService();

  @override
  Widget build(BuildContext context) {
    var chatItems = chatItemService.getAllItems();
    return Scaffold(
      appBar: AppBar(
        title: Text('Чаты'),
        backgroundColor: Colors.orange,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: chatItemService.getSize(),
        itemBuilder: (BuildContext context, int index) {
          var chatItem = chatItems[index];
          return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/chat');
              },
              child: Container(
                  height: 50,
                  // color: Colors.white,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text(chatItem.name,
                                  style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left)),
                          Expanded(
                              child: Text(chatItem.lastMessage,
                                  textAlign: TextAlign.left,
                                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.9)))
                        ],
                      ),
                      Expanded(
                          child: Text(chatItemService.getFormattedDateTime(chatItem.lastMessageTime),
                              style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.8),
                              textAlign: TextAlign.right))
                    ],
                  )
                  // child: Center(child: Text(chatItem.name)),
                  ));
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
