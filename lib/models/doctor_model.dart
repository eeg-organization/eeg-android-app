// To parse this JSON data, do
//
//     final doctorData = doctorDataFromJson(jsonString);

import 'dart:convert';

DoctorData doctorDataFromJson(String str) => DoctorData.fromJson(json.decode(str));

String doctorDataToJson(DoctorData data) => json.encode(data.toJson());

class DoctorData {
    DoctorData({
        this.data,
    });

    Data? data;

    factory DoctorData.fromJson(Map<String, dynamic> json) => DoctorData(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    Data({
        this.doctorInfo,
        this.patientInfo,
    });

    DoctorInfo? doctorInfo;
    List<PatientInfo>? patientInfo;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        doctorInfo: json["doctor_info"] == null ? null : DoctorInfo.fromJson(json["doctor_info"]),
        patientInfo: json["patient_info"] == null ? [] : List<PatientInfo>.from(json["patient_info"]!.map((x) => PatientInfo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "doctor_info": doctorInfo?.toJson(),
        "patient_info": patientInfo == null ? [] : List<dynamic>.from(patientInfo!.map((x) => x.toJson())),
    };
}

class DoctorInfo {
    DoctorInfo({
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
    dynamic contact;
    dynamic gender;
    dynamic specialization;
    dynamic address;
    int? age;
    dynamic bloodGroup;
    dynamic bloodPressure;
    List<String>? relatedTo;

    factory DoctorInfo.fromJson(Map<String, dynamic> json) => DoctorInfo(
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

class PatientInfo {
    PatientInfo({
        this.patient,
        this.relative,
    });

    DoctorInfo? patient;
    List<DoctorInfo>? relative;

    factory PatientInfo.fromJson(Map<String, dynamic> json) => PatientInfo(
        patient: json["patient"] == null ? null : DoctorInfo.fromJson(json["patient"]),
        relative: json["relative"] == null ? [] : List<DoctorInfo>.from(json["relative"]!.map((x) => DoctorInfo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "patient": patient?.toJson(),
        "relative": relative == null ? [] : List<dynamic>.from(relative!.map((x) => x.toJson())),
    };
}
