import 'package:flutter/material.dart';
import 'package:flutter_app/service/chat-message-service.dart';
import 'package:flutter_app/service/datatime-util.dart';

class ChatView extends StatefulWidget {
  @override
  State<ChatView> createState() => ChatWidgetState();
}

class ChatWidgetState extends State<ChatView> {
  final String _myUuid = "a";
  final String _opponentUuid = "a";

  final ChatMessageService _chatMessageService = ChatMessageService();
  final TextEditingController _eCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Чат c Vasia'),
          backgroundColor: Colors.orange,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [getChatMessages(), getSendMessageFormWidget()],
          ),
        ));
  }

  Widget getChatMessages() {
    return Flexible(
      child: ListView.builder(
        reverse: true,
        itemCount: _chatMessageService.getMessageCount(),
        itemBuilder: (context, index) {
          var msg = _chatMessageService.getMessagesFrom(_opponentUuid, index);
          return Column(
            crossAxisAlignment: msg.fromUuid == _myUuid ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Text(msg.message, style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(DateTimeUtil.getFormattedTime(msg.received),
                      style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.8)),
                  Icon(
                    Icons.done_all,
                    size: 17.0,
                    color: Colors.orange,
                  )
                ],
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }

  Widget getSendMessageFormWidget() {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      textInputAction: TextInputAction.newline,
      controller: _eCtrl,
      decoration: InputDecoration(
        hintText: 'Enter a message',
        suffixIcon: IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            _chatMessageService.addMessage(_eCtrl.text);
            _eCtrl.clear();
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _eCtrl.dispose();
    super.dispose();
  }

}
