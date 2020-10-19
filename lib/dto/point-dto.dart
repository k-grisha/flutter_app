class PointDto {
  final String id;
  final int lat;
  final int lon;
  final String name;

  PointDto(this.id, this.lat, this.lon, this.name);

  // int getLat(){
  //   return lat;
  // }
  //
  // int getLon(){
  //   return lon;
  // }

  factory PointDto.fromMap(Map<String, dynamic> json) {
    return PointDto(
      json['uuid'],
      json['lat'],
      json['lon'],
      json['name'],
    );
  }
}
