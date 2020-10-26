import 'package:flutter/material.dart';

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
  final items = [
    'latest (new)',
    'Cow',
    'Camel',
    'Sheep',
    'Goat',
    'Camel',
    'Sheep',
    'Goat',
    'Camel',
    'Sheep',
    'Goat',
    'Goat',
    'Goat',
    'oooldest',
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Чат c Vasia'),
          backgroundColor: Colors.orange,
        ),
        body: Column(
          children: [getChatMessages(), getSendMessageFormWidget()],
        )

      // Align(alignment: Alignment.bottomCenter, child: Column(children: [getSendMessageFormWidget()])),
    );
  }

  Widget getChatMessages() {
    return Flexible(
        child: ListView.builder(
          reverse: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(items[index]),
                ),
                Divider(), //                           <-- Divider
              ],
            );
          },
        ));
  }

  Widget getSendMessageFormWidget() {
    return TextFormField(
      decoration: InputDecoration(hintText: 'Enter a message'),
    );
  }
}
