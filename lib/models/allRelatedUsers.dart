// To parse this JSON data, do
//
//     final allRelatedUser = allRelatedUserFromJson(jsonString);

import 'dart:convert';

AllRelatedUser allRelatedUserFromJson(String str) => AllRelatedUser.fromJson(json.decode(str));

String allRelatedUserToJson(AllRelatedUser data) => json.encode(data.toJson());

class AllRelatedUser {
    final Message? message;

    AllRelatedUser({
        this.message,
    });

    factory AllRelatedUser.fromJson(Map<String, dynamic> json) => AllRelatedUser(
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
    };
}

class Message {
    final List<Patient>? patient;

    Message({
        this.patient,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        patient: json["patient"] == null ? [] : List<Patient>.from(json["patient"]!.map((x) => Patient.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "patient": patient == null ? [] : List<dynamic>.from(patient!.map((x) => x.toJson())),
    };
}

class Patient {
    final String? uid;
    final String? username;
    final String? email;
    final String? name;
    final String? role;
    final String? hospital;
    final String? contact;
    final dynamic gender;
    final dynamic specialization;
    final String? address;
    final int? age;
    final dynamic maritalStatus;
    final dynamic income;
    final dynamic religion;
    final dynamic education;
    final dynamic occupation;
    final dynamic habitat;
    final dynamic durationOfIllness;
    final dynamic ageOfOnset;
    final dynamic handedness;
    final String? bloodGroup;
    final String? bloodPressure;
    final List<String>? relatedTo;
    final dynamic patientPastHistoryPsychiatricIllness;
    final dynamic patientPastHistoryMedicalIllness;
    final dynamic familyHistoryPsychiatricIllness;
    final dynamic familyHistoryMedicalIllness;
    final String? registrationId;
    final dynamic longitude;
    final dynamic latitude;

    Patient({
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
        this.longitude,
        this.latitude,
    });

    factory Patient.fromJson(Map<String, dynamic> json) => Patient(
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
        relatedTo: json["related_to"] == null ? [] : List<String>.from(json["related_to"]!.map((x) => x)),
        patientPastHistoryPsychiatricIllness: json["patient_past_history_psychiatric_illness"],
        patientPastHistoryMedicalIllness: json["patient_past_history_medical_illness"],
        familyHistoryPsychiatricIllness: json["family_history_psychiatric_illness"],
        familyHistoryMedicalIllness: json["family_history_medical_illness"],
        registrationId: json["registration_id"],
        longitude: json["longitude"],
        latitude: json["latitude"],
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
        "related_to": relatedTo == null ? [] : List<dynamic>.from(relatedTo!.map((x) => x)),
        "patient_past_history_psychiatric_illness": patientPastHistoryPsychiatricIllness,
        "patient_past_history_medical_illness": patientPastHistoryMedicalIllness,
        "family_history_psychiatric_illness": familyHistoryPsychiatricIllness,
        "family_history_medical_illness": familyHistoryMedicalIllness,
        "registration_id": registrationId,
        "longitude": longitude,
        "latitude": latitude,
    };
}