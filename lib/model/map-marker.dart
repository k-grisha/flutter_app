import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart' show immutable, required;

class MapMarker extends Marker {
  final bool isCluster;
  final String uuid;

  // MapMarker({this.isCluster = true, this.uuid});

  const MapMarker(
      {@required markerId,
      icon = BitmapDescriptor.defaultMarker,
      infoWindow = InfoWindow.noText,
      position = const LatLng(0.0, 0.0),
      onTap,
      this.isCluster = true,
      this.uuid})
      : super(markerId:markerId, icon: icon, infoWindow:infoWindow, position:position, onTap:onTap);
}
