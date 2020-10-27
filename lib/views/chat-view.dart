import 'package:flutter/material.dart';
import 'package:flutter_app/service/chat-message-service.dart';

// class ChatView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Чат c Vasia'),
//           backgroundColor: Colors.orange,
//         ),
//         body: ChatWidget());
//   }
// }

class ChatView extends StatefulWidget {
  @override
  State<ChatView> createState() => ChatWidgetState();
}

class ChatWidgetState extends State<ChatView> {
  ChatMessageService _chatMessageService = ChatMessageService();
  final TextEditingController eCtrl = new TextEditingController();

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
          var msg = _chatMessageService.getMessagesFrom("b", index);
          return Column(
            children: <Widget>[
              ListTile(
                title: Text(msg.message),
              ),
              Divider(), //                           <-- Divider
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
      controller: eCtrl,
      decoration: InputDecoration(
        hintText: 'Enter a message',
        suffixIcon: IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            _chatMessageService.addMessage(eCtrl.text);
            eCtrl.clear();
            setState(() {});
          },
        ),
      ),
    );
  }
}
