class ItemDto {
  final String id;
  final int lat;
  final int lon;

  ItemDto(this.id, this.lat, this.lon);

  // int getLat(){
  //   return lat;
  // }
  //
  // int getLon(){
  //   return lon;
  // }

  factory ItemDto.fromMap(Map<String, dynamic> json) {
    return ItemDto(
      json['id'],
      json['lat'],
      json['lon'],
    );
  }
}
