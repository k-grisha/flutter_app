import 'package:flutter/material.dart';
import 'package:flutter_app/model/chat-message.dart';
import 'package:flutter_app/model/map-point.dart';
import 'package:flutter_app/service/chat-message-service.dart';
import 'package:flutter_app/service/datatime-util.dart';

class ChatView extends StatefulWidget {
  final ChatMessageService _chatMessageService;

  const ChatView(this._chatMessageService);

  @override
  State<ChatView> createState() => ChatWidgetState();
}

class ChatWidgetState extends State<ChatView> {
  final TextEditingController _eCtrl = new TextEditingController();
  MapPoint opponent;

  @override
  Widget build(BuildContext context) {
    opponent = ModalRoute.of(context).settings.arguments;
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Чат c ' + opponent.uuid),
          backgroundColor: Colors.orange,
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [getChatMessages(), getSendMessageFormWidget()],
          ),
        ));
  }

  Widget getChatMessages() {
    return FutureBuilder<List>(
        future: widget._chatMessageService.getAllMessagesFrom(opponent.uuid),
        initialData: List(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Expanded(
                child: Text("No Messages", style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1)));
          } else {
            return Flexible(
                child: new ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return _buildRow(context, snapshot.data[i]);
                    }));
          }
        });
  }

  Widget _buildRow(context, ChatMessage msg) {
    return Column(
      crossAxisAlignment: msg.sender != opponent.uuid ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
  }

  // Widget getChatMessages2() {
  //   return Flexible(
  //     child: ListView.builder(
  //       reverse: true,
  //       itemCount: widget._chatMessageService.getMessageCount(),
  //       itemBuilder: (context, index) {
  //         var msg = widget._chatMessageService.getMessagesFrom(_opponentUuid, index);
  //         return Column(
  //           crossAxisAlignment: msg.sender == _myUuid ? CrossAxisAlignment.end : CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Text(msg.message, style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1)),
  //             Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text(DateTimeUtil.getFormattedTime(msg.received),
  //                     style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.8)),
  //                 Icon(
  //                   Icons.done_all,
  //                   size: 17.0,
  //                   color: Colors.orange,
  //                 )
  //               ],
  //             ),
  //             Divider(),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

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
            widget._chatMessageService.sendAndSaveMessage(opponent.uuid, _eCtrl.text);
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
