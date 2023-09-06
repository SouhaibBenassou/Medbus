// To parse this JSON data, do
//
//     final tUser = tUserFromJson(jsonString);

import 'dart:convert';

TUser tUserFromJson(String str) => TUser.fromJson(json.decode(str));

String tUserToJson(TUser data) => json.encode(data.toJson());

class TUser {
  String? uid;
  String? username;
  String? email;
  String? phone;
  String? status;
  int? type = 0;
  String? date;
  String? image;
  String? gender;

  TUser({
    this.uid,
    this.username,
    this.email,
    this.phone,
    this.date,
    this.status,
    this.type,
    this.image,
    this.gender,
  });

  factory TUser.fromJson(Map<String, dynamic> json) => TUser(
        uid: json["uid"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        type: json['type'],
        status: json['status'],
        date: json["date"],
        image: json['image'],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "email": email,
        "phone": phone,
        "type": type,
        "status": status,
        "date": date,
        "image": image,
        "gender": gender,
      };
}
