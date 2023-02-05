// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    Login({
        this.message,
        this.userId,
        this.token,
    });

    String? message;
    String? userId;
    String? token;

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        message: json["message"],
        userId: json["user_id"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "user_id": userId,
        "token": token,
    };
}
