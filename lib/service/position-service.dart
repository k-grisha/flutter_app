import 'package:shared_preferences/shared_preferences.dart';

import 'preferences-service.dart';

class PositionService {
  final PreferencesService _preferences;

  PositionService(this._preferences);

  start() async {
    while (true) {
      String myUuid = await _preferences.getUuid();
      if (myUuid != null) {
        // todo allocate a position and send to the server
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
