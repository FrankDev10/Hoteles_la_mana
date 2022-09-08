import 'dart:convert';

import 'package:hoteladmin/src/models/rol.dart';





User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {

  String id;
  String name;
  String lastname;
  String email;
  String phone;
  String cedula;
  String password;
  String sessionToken;
  String notificationToken;
  String image;
  List<Rol> roles = [];

  User({
    this.id,
    this.name,
    this.lastname,
    this.email,
    this.phone,
    this.cedula,
    this.password,
    this.sessionToken,
    this.notificationToken,
    this.image,
    this.roles
  });


  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] is int ? json['id'].toString() : json["id"],
    name: json["name"],
    lastname: json["lastname"],
    email: json["email"],
    phone: json["phone"],
    cedula: json["cedula"] is int ? json['cedula'].toString() : json["cedula"],
    password: json["password"],
    sessionToken: json["session_token"],
    notificationToken: json["notification_token"],
    image: json["image"],
    roles: json["roles"] == null ? [] : List<Rol>.from(json['roles'].map((model) => Rol.fromJson(model))) ?? [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "lastname": lastname,
    "email": email,
    "phone": phone,
    "cedula": cedula,
    "password": password,
    "session_token": sessionToken,
    "notification_token": notificationToken,
    "image": image,
    "roles": roles,
  };
}
