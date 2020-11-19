import 'package:flutter_app/dto/point-dto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

import '../client/map-client.dart';
import 'preferences-service.dart';

class PositionService {
  final PreferencesService _preferences;
  final MapClient _mapClient;
  var logger = Logger();

  PositionService(this._preferences, this._mapClient);

  updateMyPoint() async {
    String myUuid = await _preferences.getUuid();
    if (myUuid != null) {
      try {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        await _mapClient.updatePosition(
            myUuid, PointDto(null, (position.latitude * 1000000).toInt(), (position.longitude * 1000000).toInt()));
      } catch (e) {
        logger.w("Unable to update position ", e);
      }
    }
  }
}
