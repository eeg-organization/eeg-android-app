// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    Login({
        this.message,
        this.user,
        this.token,
    });

    String? message;
    User? user;
    String? token;

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        message: json["message"],
        user: User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "user": user!.toJson(),
        "token": token,
    };
}

class User {
    User({
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
        this.maritalStatus,
        this.income,
        this.religion,
        this.education,
        this.occupation,
        this.habitat,
        this.durationOfIllness,
        this.ageOfOnset,
        this.handedness,
        this.bloodGroup,
        this.bloodPressure,
        this.relatedTo,
        this.patientPastHistoryPsychiatricIllness,
        this.patientPastHistoryMedicalIllness,
        this.familyHistoryPsychiatricIllness,
        this.familyHistoryMedicalIllness,
        this.registrationId,
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
    dynamic maritalStatus;
    dynamic income;
    dynamic religion;
    dynamic education;
    dynamic occupation;
    dynamic habitat;
    dynamic durationOfIllness;
    dynamic ageOfOnset;
    dynamic handedness;
    dynamic bloodGroup;
    dynamic bloodPressure;
    List<dynamic>? relatedTo;
    dynamic patientPastHistoryPsychiatricIllness;
    dynamic patientPastHistoryMedicalIllness;
    dynamic familyHistoryPsychiatricIllness;
    dynamic familyHistoryMedicalIllness;
    dynamic registrationId;

    factory User.fromJson(Map<String, dynamic> json) => User(
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
        maritalStatus: json["marital_status"],
        income: json["income"],
        religion: json["religion"],
        education: json["education"],
        occupation: json["occupation"],
        habitat: json["habitat"],
        durationOfIllness: json["duration_of_illness"],
        ageOfOnset: json["age_of_onset"],
        handedness: json["handedness"],
        bloodGroup: json["blood_group"],
        bloodPressure: json["blood_pressure"],
        relatedTo: List<dynamic>.from(json["related_to"].map((x) => x)),
        patientPastHistoryPsychiatricIllness: json["patient_past_history_psychiatric_illness"],
        patientPastHistoryMedicalIllness: json["patient_past_history_medical_illness"],
        familyHistoryPsychiatricIllness: json["family_history_psychiatric_illness"],
        familyHistoryMedicalIllness: json["family_history_medical_illness"],
        registrationId: json["registration_id"],
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
        "marital_status": maritalStatus,
        "income": income,
        "religion": religion,
        "education": education,
        "occupation": occupation,
        "habitat": habitat,
        "duration_of_illness": durationOfIllness,
        "age_of_onset": ageOfOnset,
        "handedness": handedness,
        "blood_group": bloodGroup,
        "blood_pressure": bloodPressure,
        "related_to": List<dynamic>.from(relatedTo!.map((x) => x)),
        "patient_past_history_psychiatric_illness": patientPastHistoryPsychiatricIllness,
        "patient_past_history_medical_illness": patientPastHistoryMedicalIllness,
        "family_history_psychiatric_illness": familyHistoryPsychiatricIllness,
        "family_history_medical_illness": familyHistoryMedicalIllness,
        "registration_id": registrationId,
    };
}
