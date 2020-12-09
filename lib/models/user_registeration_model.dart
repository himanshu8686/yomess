import 'package:flutter/material.dart';

// To parse this JSON data, do
//
//     final userRegisterationModel = userRegisterationModelFromJson(jsonString);

import 'dart:convert';

UserRegisterationModel userRegisterationModelFromJson(String str) =>
    UserRegisterationModel.fromJson(json.decode(str));

String userRegisterationModelToJson(UserRegisterationModel data) =>
    json.encode(data.toJson());

class UserRegisterationModel {
  UserRegisterationModel({
    this.response,
    this.message,
    this.data,
  });

  final bool response;
  final String message;
  final Data data;

  factory UserRegisterationModel.fromJson(Map<String, dynamic> json) =>
      UserRegisterationModel(
        response: json["response"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.emailVerifiedAt,
    this.countryCode,
    this.mobile,
    this.deviceToken,
    this.deviceType,
    this.facebookId,
    this.googleId,
    this.image,
    this.document,
    this.createdAt,
    this.updatedAt,
    this.token,
    this.tokenType,
  });

  final int id;
  final String name;
  final dynamic firstName;
  final dynamic lastName;
  final dynamic email;
  final dynamic emailVerifiedAt;
  final String countryCode;
  final String mobile;
  final String deviceToken;
  final String deviceType;
  final dynamic facebookId;
  final dynamic googleId;
  final dynamic image;
  final dynamic document;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String token;
  final String tokenType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        countryCode: json["country_code"],
        mobile: json["mobile"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        facebookId: json["facebook_id"],
        googleId: json["google_id"],
        image: json["image"],
        document: json["document"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        token: json["token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "country_code": countryCode,
        "mobile": mobile,
        "device_token": deviceToken,
        "device_type": deviceType,
        "facebook_id": facebookId,
        "google_id": googleId,
        "image": image,
        "document": document,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "token": token,
        "token_type": tokenType,
      };
}
