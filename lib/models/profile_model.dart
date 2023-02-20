// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
    Profile({
        this.uid,
        this.username,
        this.email,
        this.name,
        this.role,
        this.hospital,
        this.contact,
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
    dynamic specialization;
    String? address;
    int? age;
    String? bloodGroup;
    String? bloodPressure;
    List<String>? relatedTo;

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        uid: json["uid"],
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
        "specialization": specialization,
        "address": address,
        "age": age,
        "blood_group": bloodGroup,
        "blood_pressure": bloodPressure,
        "related_to": relatedTo == null ? [] : List<dynamic>.from(relatedTo!.map((x) => x)),
    };
}
