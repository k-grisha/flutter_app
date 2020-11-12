import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/service/common.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../client/chat-clietn.dart';
import '../dto/user-dto.dart';

class SettingsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsViewState();
}

class SettingsViewState extends State with WidgetsBindingObserver {
  var logger = Logger();

  // static final RegExp nameRegExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
  static final RegExp nameRegExp = RegExp(r'^[a-zA-Z](([\._\-][a-zA-Z0-9])|[a-zA-Z0-9])*[a-z0-9]$');
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eCtrl = new TextEditingController();
  final ChatClient mapClient = ChatClient(Dio());

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => _popIfRegistered(context),
          ),
          title: Text('Настройки'),
          backgroundColor: Colors.orange,
        ),
        body: Container(
            padding: EdgeInsets.all(10.0),
            child: new Form(
                key: _formKey,
                child: Column(children: [
                  new Text(
                    'Имя пользователя:',
                    style: TextStyle(fontSize: 10.0),
                  ),
                  new TextFormField(
                      controller: _eCtrl,
                      validator: (value) {
                        return _isNameValid(value);
                      }),
                  new SizedBox(height: 10.0),
                  new RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _registerNewUser(context);
                      }
                    },
                    child: Text('Проверить'),
                    color: Colors.blue,
                    textColor: Colors.white,
                  )
                ]))));
  }

  void _registerNewUser(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    var createdUser = await mapClient.createUser(new UserDto(_eCtrl.text));
    
    if (createdUser.errorCode != 0) {
      logger.w(createdUser.message);
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Common.CONFIG_MY_UUID, createdUser.body.uuid);
    // await new Future.delayed(const Duration(milliseconds: 3000));
    Navigator.pop(context); //pop dialog
    Navigator.pop(context);
  }

  @override
  // fixme: it doesn't work
  Future<bool> didPopRoute() async {
    super.didPopRoute();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myUuid = prefs.getString(Common.CONFIG_MY_UUID);
    if (myUuid != null) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _eCtrl.dispose();
    super.dispose();
  }

  String _isNameValid(String name) {
    if (name.isEmpty || name.length > 50 || name.length < 3) {
      return "Пожалуйста введите имя, от 3 до 50 символа";
    }
    name = name.trim();
    if (name.length < 3 || !nameRegExp.hasMatch(name)) {
      return "Пожалуйста введите корректное имя";
    }
    return null;
  }

  void _popIfRegistered(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myUuid = prefs.getString(Common.CONFIG_MY_UUID);
    if (myUuid != null) {
      Navigator.of(context).pop();
    }
  }
}
