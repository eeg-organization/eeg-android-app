// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.data,
    });

    List<Data>? data;

    factory User.fromJson(Map<String, dynamic> json) => User(
        data: json[" data "] == null ? [] : List<Data>.from(json[" data "]!.map((x) => Data.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        " data ": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Data {
    Data({
        this.uid,
        this.username,
        this.email,
        this.name,
        this.role,
        this.hospital,
        this.contact,
        this.gender,
        this.specialization,
        this.address,
        this.age,
        this.bloodGroup,
        this.bloodPressure,
        this.relatedTo,
    });

    String? uid;
    String? username;
    String? email;
    String? name;
    String? role;
    dynamic hospital;
    String? contact;
    dynamic gender;
    dynamic specialization;
    String? address;
    int? age;
    String? bloodGroup;
    String? bloodPressure;
    List<String>? relatedTo;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        uid: json["uid"],
        username: json["username"],
        email: json["email"],
        name: json["name"],
        role: json["role"],
        hospital: json["hospital"],
        contact: json["contact"],
        gender: json["gender"],
        specialization: json["specialization"],
        address: json["address"],
        age: json["age"],
        bloodGroup: json["blood_group"],
        bloodPressure: json["blood_pressure"],
        relatedTo: json["related_to"] == null ? [] : List<String>.from(json["related_to"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "email": email,
        "name": name,
        "role": role,
        "hospital": hospital,
        "contact": contact,
        "gender": gender,
        "specialization": specialization,
        "address": address,
        "age": age,
        "blood_group": bloodGroup,
        "blood_pressure": bloodPressure,
        "related_to": relatedTo == null ? [] : List<dynamic>.from(relatedTo!.map((x) => x)),
    };
}
