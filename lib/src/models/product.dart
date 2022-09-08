import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {

  String id;
  String name;
  String description;
  String image1;

  String urlapp;
  String urlmap;
  String descripcion2;
  String telefono;
  int quantity;
  List<Product> toList = [];

  Product({
    this.id,
    this.name,
    this.description,
    this.image1,

    this.urlapp,
    this.urlmap,
    this.descripcion2,
    this.telefono,
    this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"] is int ? json["id"].toString() : json["id"],
    name: json["name"],
    description: json["description"],
    image1: json["image1"],

    urlapp: json['urlapp'],
    urlmap: json['urlmap'],
    descripcion2: json['descripcion2'],
    telefono: json["telefono"],
    quantity: json["quantity"],
  );

  Product.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      Product product = Product.fromJson(item);
      toList.add(product);
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image1": image1,

    "urlapp": urlapp,
    "urlmap": urlmap,
    "descripcion2": descripcion2,
    "telefono": telefono,
    "quantity": quantity,
  };

  static bool isInteger(num value) => value is int || value == value.roundToDouble();
}
