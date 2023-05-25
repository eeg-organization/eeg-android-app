// To parse this JSON data, do
//
//     final brainScoreModel = brainScoreModelFromJson(jsonString);

import 'dart:convert';

List<BrainScoreModel> brainScoreModelFromJson(String str) => List<BrainScoreModel>.from(json.decode(str).map((x) => BrainScoreModel.fromJson(x)));

String brainScoreModelToJson(List<BrainScoreModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BrainScoreModel {
    final String? uid;
    final DateTime? createdAt;
    final String? timestamp;
    final String? deviceId;
    final String? score;
    final String? user;

    BrainScoreModel({
        this.uid,
        this.createdAt,
        this.timestamp,
        this.deviceId,
        this.score,
        this.user,
    });

    factory BrainScoreModel.fromJson(Map<String, dynamic> json) => BrainScoreModel(
        uid: json["uid"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        timestamp: json["timestamp"],
        deviceId: json["device_id"],
        score: json["score"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "created_at": createdAt?.toIso8601String(),
        "timestamp": timestamp,
        "device_id": deviceId,
        "score": score,
        "user": user,
    };
}

