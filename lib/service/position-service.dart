import 'package:shared_preferences/shared_preferences.dart';

import 'common.dart';

class PositionService {
  start() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    while (true) {
      String myUuid = prefs.getString(Common.CONFIG_MY_UUID);
      if (myUuid != null) {
        print("Send position");
      } else {
        print("position not send, cause not registered");
      }

      // else if (ModalRoute.of(context).settings.name != "/registration'") {
      //   print (ModalRoute.of(context).settings.name );
      //   // Navigator.pushNamed(context, '/registration');
      // }
      await new Future.delayed(const Duration(milliseconds: 3000));
    }
  }
}
