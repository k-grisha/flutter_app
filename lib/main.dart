import 'package:flutter/material.dart';
import 'package:flutter_app/views/chat-list-view.dart';
import 'package:flutter_app/views/chat-view.dart';
import 'package:flutter_app/views/map-view.dart';
import 'package:flutter_app/views/registration-view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {
      '/': (BuildContext context) => MapView(),
      '/chat-list': (BuildContext context) => ChatListView(),
      '/chat': (BuildContext context) => ChatView(),
      '/registration': (BuildContext context) => RegistrationView(),
    });
  }
}
