import 'package:flutter/material.dart';
import 'package:flutter_app/views/chat-list.dart';
import 'package:flutter_app/views/cluster-map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {
      '/': (BuildContext context) => ClusterMap(),
      '/chat-list': (BuildContext context) => ChatList(),
    });
  }
}
