import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'page.dart';

class MarkerIconsPage extends GoogleMapExampleAppPage {
  MarkerIconsPage() : super(const Icon(Icons.image), 'Marker icons');

  @override
  Widget build(BuildContext context) {
    return const MarkerIconsBody();
  }
}

class MarkerIconsBody extends StatefulWidget {
  const MarkerIconsBody();

  @override
  State<StatefulWidget> createState() => MarkerIconsBodyState();
}

const LatLng _kMapCenter = LatLng(52.4478, -3.5402);

class MarkerIconsBodyState extends State<MarkerIconsBody> {
  GoogleMapController controller;
  BitmapDescriptor _markerIcon;

  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: 350.0,
            height: 300.0,
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: _kMapCenter,
                zoom: 7.0,
              ),
              markers: _createMarker(),
              onMapCreated: _onMapCreated,
            ),
          ),
        )
      ],
    );
  }

  Set<Marker> _createMarker() {
    // TODO(iskakaushik): Remove this when collection literals makes it to stable.
    // https://github.com/flutter/flutter/issues/28312
    // ignore: prefer_collection_literals
    return <Marker>[
      Marker(
        markerId: MarkerId("marker_1"),
        position: LatLng(52.4478, -3.9402),
        icon: _markerIcon,
      ),
      Marker(
        markerId: MarkerId("marker_2"),
        position: LatLng(51.4478, -2.8402),
        icon: _markerIcon,
      ),
      Marker(
        markerId: MarkerId("marker_3"),
        position: LatLng(51.1478, -2.7402),
        icon: _markerIcon,
      ),
      Marker(
        markerId: MarkerId("marker_4"),
        position: LatLng(51.2478, -2.6402),
        icon: _markerIcon,
      ),
      Marker(
        markerId: MarkerId("marker_5"),
        position: LatLng(51.3478, -2.4402),
        icon: _markerIcon,
      ),
      Marker(
        markerId: MarkerId("marker_6"),
        position: LatLng(51.4778, -2.3402),
        icon: _markerIcon,
      ),
      Marker(
        markerId: MarkerId("marker_6"),
        position: LatLng(51.62478, -2.1402),
        icon: _markerIcon,
      ),
      Marker(
        markerId: MarkerId("marker_6"),
        position: LatLng(51.31478, -2.1502),
        icon: _markerIcon,
      ),
      Marker(
        markerId: MarkerId("marker_6"),
        position: LatLng(51.24478, -2.2502),
        icon: _markerIcon,
      ),
      Marker(
        markerId: MarkerId("marker_6"),
        position: LatLng(51.15478, -2.1702),
        icon: _markerIcon,
      ),

      Marker(
        markerId: MarkerId("marker_6"),
        position: LatLng(51.18478, -2.132),
        icon: _markerIcon,
      ),
      Marker(
        markerId: MarkerId("marker_6"),
        position: LatLng(51.27478, -2.2302),
        icon: _markerIcon,
      ),
      Marker(
        markerId: MarkerId("marker_6"),
        position: LatLng(51.18478, -2.2802),
        icon: _markerIcon,
      ),
      Marker(
        markerId: MarkerId("marker_6"),
        position: LatLng(51.25478, -2.1502),
        icon: _markerIcon,
      ),
    ].toSet();
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration = createLocalImageConfiguration(context, size: Size.square(48));
      BitmapDescriptor.fromAssetImage(imageConfiguration, 'assets/red_square.png').then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
    });
  }
}
