import 'package:flutter/material.dart';
import 'package:flutter_app/model/chat-message.dart';
import 'package:flutter_app/service/chat-message-service.dart';
import 'package:flutter_app/service/datatime-util.dart';

class ChatView extends StatefulWidget {
  final ChatMessageService _chatMessageService;

  const ChatView(this._chatMessageService);

  @override
  State<ChatView> createState() => ChatWidgetState();
}

class ChatWidgetState extends State<ChatView> {
  final String _myUuid = "501959ac-69fb-4a3b-ba81-3e47d207e019";
  String senderUuid = "8b4865d5-c480-4732-885f-958680b16d1a";

  final TextEditingController _eCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Чат c Vasia'),
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
        future: widget._chatMessageService.getAllMessages(senderUuid),
        initialData: List(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Flexible(
                child: new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return _buildRow(context, snapshot.data[i]);
                    }));
          }
        });
  }

  Widget _buildRow(context, ChatMessage msg) {
    return Column(
      crossAxisAlignment: msg.sender == _myUuid ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
            widget._chatMessageService.addMessage(_eCtrl.text);
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
