import 'dart:convert';
import 'dart:math';

import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'dto/item-dto.dart';
import 'place.dart';

class MarkerService {
  final List<ClusterItem<Place>> _items = [];
  var logger = Logger();

  Random _rnd = new Random();

  MarkerService() {
    doUpdate();
  }

  void doUpdate() async {
    while (true) {
      try {
        await new Future.delayed(const Duration(milliseconds: 3000));
        var response = await http.get("http://192.168.31.154:8010/api/v1/point");
        if (response.statusCode == 200) {
          var parsed = json.decode(response.body).cast<Map<String, dynamic>>();
          List<ItemDto> dtos = parsed.map<ItemDto>((json) => ItemDto.fromMap(json)).toList();
          var newItems = dtos
              .map((item) => ClusterItem(LatLng(item.lat / 1000000, item.lon / 1000000), item: Place(name: item.id)))
              .toList();
          _items.clear();
          _items.addAll(newItems);
        } else {
          logger.w('Unable to fetch points from the REST API. code: ${response.statusCode}');
        }
      } catch (e) {
        logger.e(e);
      }
    }
  }

  List<ClusterItem<Place>> getItems() {
    return new List<ClusterItem<Place>>.from(_items);
  }
}
