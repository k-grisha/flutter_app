import 'package:flutter/material.dart';
import 'package:flutter_app/service/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("  ---  RegistrationView --- " + ModalRoute.of(context).settings.name);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => _popIfRegistered(context),
          ),
          title: Text('Регистрация'),
          backgroundColor: Colors.orange,
        ),
        body: TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          textInputAction: TextInputAction.newline,
          // controller: eCtrl,
          decoration: InputDecoration(
            hintText: 'Enter a message',
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                _onLoading(context);
                // var response = await http.get("http://192.168.31.152:8010/api/v1/point");
              },
            ),
          ),
        ));
  }

  void _popIfRegistered(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myUuid = prefs.getString(Common.CONFIG_MY_UUID);
    if (myUuid != null) {
      Navigator.of(context).pop();
    }
  }

  void _onLoading(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("Loading"),
            ],
          ),
        );
      },
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(Common.CONFIG_MY_UUID, "112233");
    await new Future.delayed(const Duration(milliseconds: 3000));
    Navigator.pop(context); //pop dialog
    Navigator.pop(context); //pop dialog
    // new Future.delayed(new Duration(seconds: 10), () {
    //   Navigator.pop(context); //pop dialog
    //   // _login();
    // });
  }
}