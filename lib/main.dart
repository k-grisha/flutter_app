import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/views/chat-list-view.dart';
import 'package:flutter_app/views/chat-view.dart';
import 'package:flutter_app/views/map-view.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

import 'client/chat-clietn.dart';
import 'client/map-client.dart';
import 'environment.dart';
import 'repository/message-repository.dart';
import 'service/chat-item-service.dart';
import 'service/chat-message-service.dart';
import 'service/marker-service.dart';
import 'views/settings-view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var injector = ModuleContainer().initialise(Injector(), Environment.DEV);
    return MaterialApp(initialRoute: '/', routes: {
      '/': (BuildContext context) => MapWidget(injector.get<MarkerService>()),
      '/chat-list': (BuildContext context) => ChatListView(injector.get<ChatItemService>()),
      '/chat': (BuildContext context) => ChatView(injector.get<ChatMessageService>()),
      '/registration': (BuildContext context) => SettingsView(injector.get<ChatClient>()),
    });
  }
}

class ModuleContainer {
  Injector initialise(Injector injector, Environment env) {
    injector.map<EnvSettings>((i) => env.settings, isSingleton: true);
    injector.map<ChatClient>((i) => ChatClient(Dio()), isSingleton: true);
    injector.map<MapClient>((i) => MapClient(Dio()), isSingleton: true);
    injector.map<MarkerService>((i) => MarkerService(i.get<MapClient>()), isSingleton: true);
    injector.map<ChatItemService>((i) => ChatItemService(), isSingleton: true);
    injector.map<MessageRepository>((i) => MessageRepository(), isSingleton: true);
    injector.map<ChatMessageService>((i) => ChatMessageService(i.get<MessageRepository>()), isSingleton: true);

    // injector.map<Logger>((i) => Logger(), isSingleton: true);
    // injector.map<String>((i) => "https://api.com/", key: "apiUrl");
    // injector.map<SomeService>((i) => SomeService(i.get<Logger>(), i.get<String>(key: "apiUrl")));
    //
    // // note that you can configure mapping in a fluent programming style too
    // injector.map<SomeType>((injector) => SomeType("0"))
    //   ..map<SomeType>((injector) => SomeType("1"), key: "One")
    //   ..map<SomeType>((injector) => SomeType("2"), key: "Two");
    //
    // injector.mapWithParams<SomeOtherType>((i, p) => SomeOtherType(p["id"]));

    return injector;
  }
}
