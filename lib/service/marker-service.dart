import 'dart:convert';
import 'dart:math';

import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../dto/point-dto.dart';
import '../model/map-point.dart';
import '../place.dart';

class MarkerService {
  final List<ClusterItem<MapPoint>> _items = [];

  // final Set<Marker> _markers = new HashSet<Marker>();
  // final Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  var logger = Logger();

  Random _rnd = new Random();

  MarkerService() {
    // _markers.add(Marker(markerId: MarkerId("berlin 1"), position: LatLng(52.534692, 13.395905)));
    // _markers.add(Marker(markerId: MarkerId("berlin 2"), position: LatLng(52.499308, 13.422632)));
    // _markers.add(Marker(markerId: MarkerId("berlin 3"), position: LatLng(52.513327, 13.377792)));
    // _items
    doUpdate();
  }

  void doUpdate() async {
    while (true) {
      try {
        await new Future.delayed(const Duration(milliseconds: 3000));
        var response = await http.get("http://192.168.31.154:8010/api/v1/point");
        if (response.statusCode == 200) {
          var parsed = json.decode(response.body).cast<Map<String, dynamic>>();
          List<PointDto> dtos = parsed.map<PointDto>((json) => PointDto.fromMap(json)).toList();
          var newItems = dtos
              .map((dto) => ClusterItem(LatLng(dto.lat / 1000000, dto.lon / 1000000), item: MapPoint(dto.id, dto.name)))
              .toList();
          _items.clear();
          _items.addAll(newItems);
          // Set<Marker> markers = dtos
          //     .map((dto) => Marker(markerId: MarkerId(dto.id), position: LatLng(dto.lat / 1000000, dto.lon / 1000000)))
          //     .toSet();
          // _markers.addAll(markers);
        } else {
          logger.w('Unable to fetch points from the Point Service. code: ${response.statusCode}');
        }
      } catch (e) {
        logger.w("Point Service is unreachable ", e);
      }
    }
  }

  // Set<Marker> getMarkers() {
  //   return new HashSet<Marker>.from(_markers);
  // }

  List<ClusterItem<MapPoint>> getItems() {
    return new List<ClusterItem<MapPoint>>.from(_items);
  }
}
