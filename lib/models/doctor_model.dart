// To parse this JSON data, do
//
//     final doctorData = doctorDataFromJson(json String?);

import 'package:meta/meta.dart';
import 'dart:convert';

DoctorData doctorDataFromJson(String? str) =>
    DoctorData.fromJson(json.decode(str!));

String? doctorDataToJson(DoctorData data) => json.encode(data.toJson());

class DoctorData {
  DoctorData({
    required this.patientInfo,
  });

  final List<PatientInfo> patientInfo;

  factory DoctorData.fromJson(Map<String?, dynamic> json) => DoctorData(
        patientInfo: List<PatientInfo>.from(
            json["patient_info"].map((x) => PatientInfo.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "patient_info": List<dynamic>.from(patientInfo.map((x) => x.toJson())),
      };
}

class PatientInfo {
  PatientInfo({
    required this.patientPersonalInfo,
    required this.relativeInfo,
    required this.quizInfo,
  });

  final Info patientPersonalInfo;
  final List<Info> relativeInfo;
  final List<QuizInfo> quizInfo;

  factory PatientInfo.fromJson(Map<String?, dynamic> json) => PatientInfo(
        patientPersonalInfo: Info.fromJson(json["patient_personal_info"]),
        relativeInfo:
            List<Info>.from(json["relative_info"].map((x) => Info.fromJson(x))),
        quizInfo: List<QuizInfo>.from(
            json["quiz_info"].map((x) => QuizInfo.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "patient_personal_info": patientPersonalInfo.toJson(),
        "relative_info":
            List<dynamic>.from(relativeInfo.map((x) => x.toJson())),
        "quiz_info": List<dynamic>.from(quizInfo.map((x) => x.toJson())),
      };
}

class Info {
  Info({
    required this.uid,
    required this.username,
    required this.email,
    required this.name,
    required this.role,
    required this.hospital,
    required this.contact,
    required this.specialization,
    required this.address,
    required this.age,
    required this.bloodGroup,
    required this.bloodPressure,
    required this.relatedTo,
  });

  final String? uid;
  final String? username;
  final String? email;
  final String? name;
  final String? role;
  final dynamic hospital;
  final dynamic contact;
  final dynamic specialization;
  final dynamic address;
  final dynamic age;
  final dynamic bloodGroup;
  final dynamic bloodPressure;
  final List<String?> relatedTo;

  factory Info.fromJson(Map<String?, dynamic> json) => Info(
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
        relatedTo: List<String?>.from(json["related_to"].map((x) => x)),
      );

  Map<String?, dynamic> toJson() => {
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
        "related_to": List<dynamic>.from(relatedTo.map((x) => x)),
      };
}

class QuizInfo {
  QuizInfo({
    required this.uid,
    required this.createdAt,
    required this.data,
    required this.options,
    required this.score,
    required this.user,
    required this.questionare,
  });

  final String? uid;
  final DateTime createdAt;
  final Data data;
  final Options options;
  final int? score;
  final String? user;
  final String? questionare;

  factory QuizInfo.fromJson(Map<String?, dynamic> json) => QuizInfo(
        uid: json["uid"],
        createdAt: DateTime.parse(json["created_at"]),
        data: Data.fromJson(json["data"]),
        options: Options.fromJson(json["options"]),
        score: json["score"],
        user: json["user"],
        questionare: json["questionare"],
      );

  Map<String?, dynamic> toJson() => {
        "uid": uid,
        "created_at": createdAt.toIso8601String(),
        "data": data.toJson(),
        "options": options.toJson(),
        "score": score,
        "user": user,
        "questionare": questionare,
      };
}

class Data {
  Data({
    required this.questions,
    required this.questionare,
  });

  final List<QuestionElement> questions;
  final Questionare questionare;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
        questions: List<QuestionElement>.from(
            json["questions"].map((x) => QuestionElement.fromJson(x))),
        questionare: Questionare.fromJson(json["questionare"]),
      );

  Map<String?, dynamic> toJson() => {
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "questionare": questionare.toJson(),
      };
}

class Questionare {
  Questionare({
    required this.uid,
    required this.type,
  });

  final String? uid;
  final String? type;

  factory Questionare.fromJson(Map<String?, dynamic> json) => Questionare(
        uid: json["uid"],
        type: json["type"],
      );

  Map<String?, dynamic> toJson() => {
        "uid": uid,
        "type": type,
      };
}

class QuestionElement {
  QuestionElement({
    required this.options,
    required this.question,
  });

  final List<Option> options;
  final QuestionQuestion question;

  factory QuestionElement.fromJson(Map<String?, dynamic> json) =>
      QuestionElement(
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        question: QuestionQuestion.fromJson(json["question"]),
      );

  Map<String?, dynamic> toJson() => {
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "question": question.toJson(),
      };
}

class Option {
  Option({
    required this.uid,
    required this.option,
    required this.question,
    required this.optionId,
  });

  final String? uid;
  final String? option;
  final String? question;
  final int? optionId;

  factory Option.fromJson(Map<String?, dynamic> json) => Option(
        uid: json["uid"],
        option: json["option"],
        question: json["question"],
        optionId: json["option_id"],
      );

  Map<String?, dynamic> toJson() => {
        "uid": uid,
        "option": option,
        "question": question,
        "option_id": optionId,
      };
}

class QuestionQuestion {
  QuestionQuestion({
    required this.uid,
    required this.question,
    required this.description,
    required this.questionare,
  });

  final String? uid;
  final String? question;
  final String? description;
  final String? questionare;

  factory QuestionQuestion.fromJson(Map<String?, dynamic> json) =>
      QuestionQuestion(
        uid: json["uid"],
        question: json["question"],
        description: json["description"],
        questionare: json["questionare"],
      );

  Map<String?, dynamic> toJson() => {
        "uid": uid,
        "question": question,
        "description": description,
        "questionare": questionare,
      };
}

class Options {
  Options({
    required this.q1,
    required this.q2,
    required this.q3,
    required this.q4,
    required this.q5,
    required this.insight,
    required this.suicide,
    required this.agitation,
    required this.retardation,
    required this.weightLoss,
    required this.depressedMood,
    required this.hypochondriasis,
    required this.genitalSymptoms,
    required this.anxietyPsychic,
    required this.anxietySomatic,
    required this.feelingsOfGuilt,
    required this.insomniaMiddle,
    required this.insomniaDelayed,
    required this.insomniaInitial,
    required this.workAndInterests,
    required this.somaticSymptomsGeneral,
    required this.somaticSymptomsGastrointestinal,
  });

  final String? q1;
  final String? q2;
  final String? q3;
  final String? q4;
  final String? q5;
  final int? insight;
  final int? suicide;
  final int? agitation;
  final int? retardation;
  final int? weightLoss;
  final int? depressedMood;
  final int? hypochondriasis;
  final int? genitalSymptoms;
  final int? anxietyPsychic;
  final int? anxietySomatic;
  final int? feelingsOfGuilt;
  final int? insomniaMiddle;
  final int? insomniaDelayed;
  final int? insomniaInitial;
  final int? workAndInterests;
  final int? somaticSymptomsGeneral;
  final int? somaticSymptomsGastrointestinal;

  factory Options.fromJson(Map<String?, dynamic> json) => Options(
        q1: json["Q1"],
        q2: json["Q2"],
        q3: json["Q3"],
        q4: json["Q4"],
        q5: json["Q5"],
        insight: json["INSIGHT"],
        suicide: json["SUICIDE"],
        agitation: json["AGITATION"],
        retardation: json["RETARDATION"],
        weightLoss: json["WEIGHT LOSS"],
        depressedMood: json["DEPRESSED MOOD"],
        hypochondriasis: json["HYPOCHONDRIASIS"],
        genitalSymptoms: json["GENITAL SYMPTOMS"],
        anxietyPsychic: json["ANXIETY - PSYCHIC"],
        anxietySomatic: json["ANXIETY - SOMATIC"],
        feelingsOfGuilt: json["FEELINGS OF GUILT"],
        insomniaMiddle: json["INSOMNIA - Middle"],
        insomniaDelayed: json["INSOMNIA - Delayed"],
        insomniaInitial: json["INSOMNIA - Initial"],
        workAndInterests: json["WORK AND INTERESTS"],
        somaticSymptomsGeneral: json["SOMATIC SYMPTOMS - GENERAL"],
        somaticSymptomsGastrointestinal:
            json["SOMATIC SYMPTOMS - GASTROINTESTINAL"],
      );

  Map<String?, dynamic> toJson() => {
        "Q1": q1,
        "Q2": q2,
        "Q3": q3,
        "Q4": q4,
        "Q5": q5,
        "INSIGHT": insight,
        "SUICIDE": suicide,
        "AGITATION": agitation,
        "RETARDATION": retardation,
        "WEIGHT LOSS": weightLoss,
        "DEPRESSED MOOD": depressedMood,
        "HYPOCHONDRIASIS": hypochondriasis,
        "GENITAL SYMPTOMS": genitalSymptoms,
        "ANXIETY - PSYCHIC": anxietyPsychic,
        "ANXIETY - SOMATIC": anxietySomatic,
        "FEELINGS OF GUILT": feelingsOfGuilt,
        "INSOMNIA - Middle": insomniaMiddle,
        "INSOMNIA - Delayed": insomniaDelayed,
        "INSOMNIA - Initial": insomniaInitial,
        "WORK AND INTERESTS": workAndInterests,
        "SOMATIC SYMPTOMS - GENERAL": somaticSymptomsGeneral,
        "SOMATIC SYMPTOMS - GASTROINTESTINAL": somaticSymptomsGastrointestinal,
      };
}
