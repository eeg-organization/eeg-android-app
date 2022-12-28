// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.message,
        required this.user,
    });

    final String message;
    final User user;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "user": user.toJson(),
    };
}

class User {
    User({
        required this.username,
        required this.email,
        this.name,
        this.role,
        this.hospital,
        this.contact,
        this.specialization,
        this.address,
        this.age,
        this.bloodGroup,
        this.bloodPressure,
    });

    final String username;
    final String email;
    String? name;
    String? role;
    String? hospital;
    String? contact;
    String? specialization;
    String? address;
    String? age;
    String? bloodGroup;
    String? bloodPressure;

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
        name: json["name"],
        role: json["role"],
        hospital: json["hospital"],
        contact: json["contact"],
        specialization: json["specialization"],
        address: json["address"],
        age: json["age"],
        bloodGroup: json["blood_group"],
        bloodPressure: json["blood_pressure"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "name": name,
        "role": role,
        "hospital": hospital,
        "contact": contact,
        "specialization": specialization,
        "address": address,
        "age": age,
        "blood_group": bloodGroup,
        "blood_pressure": bloodPressure,
    };
}
