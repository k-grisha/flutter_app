import 'package:flutter/material.dart';
import 'package:flutter_app/views/map-view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapWidget(),
    );
  }
}
