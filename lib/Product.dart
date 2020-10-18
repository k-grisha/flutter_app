class Product {
  final String id;
  final int lat;
  final int lon;

  Product(this.id, this.lat, this.lon);
  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      json['id'],
      json['lat'],
      json['lon'],
    );
  }
}