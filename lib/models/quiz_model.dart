// To parse this JSON data, do
//
//     final quiz = quizFromJson(jsonString);

import 'dart:convert';

Quiz quizFromJson(String str) => Quiz.fromJson(json.decode(str));

String quizToJson(Quiz data) => json.encode(data.toJson());

class Quiz {
    Quiz({
        required this.quizs,
    });

    List<QuizElement> quizs;

    factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        quizs: List<QuizElement>.from(json["quizs"].map((x) => QuizElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "quizs": List<dynamic>.from(quizs.map((x) => x.toJson())),
    };
}

class QuizElement {
    QuizElement({
        required this.uid,
        required this.createdAt,
        required this.data,
        required this.options,
        required this.score,
        required this.user,
        required this.questionare,
    });

    String uid;
    DateTime createdAt;
    Data data;
    Options options;
    int score;
    String user;
    String questionare;

    factory QuizElement.fromJson(Map<String, dynamic> json) => QuizElement(
        uid: json["uid"],
        createdAt: DateTime.parse(json["created_at"]),
        data: Data.fromJson(json["data"]),
        options: Options.fromJson(json["options"]),
        score: json["score"],
        user: json["user"],
        questionare: json["questionare"],
    );

    Map<String, dynamic> toJson() => {
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

    List<QuestionElement> questions;
    Questionare questionare;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        questions: List<QuestionElement>.from(json["questions"].map((x) => QuestionElement.fromJson(x))),
        questionare: Questionare.fromJson(json["questionare"]),
    );

    Map<String, dynamic> toJson() => {
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "questionare": questionare.toJson(),
    };
}

class Questionare {
    Questionare({
        required this.uid,
        required this.type,
    });

    String uid;
    Type type;

    factory Questionare.fromJson(Map<String, dynamic> json) => Questionare(
        uid: json["uid"],
        type: typeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "type": typeValues.reverse[type],
    };
}

enum Type { BID, HAM_D }

final typeValues = EnumValues({
    "BID": Type.BID,
    "HAM_D": Type.HAM_D
});

class QuestionElement {
    QuestionElement({
        required this.options,
        this.question1,
        this.question,
    });

    List<Option> options;
    Question1Class? question1;
    Question1Class? question;

    factory QuestionElement.fromJson(Map<String, dynamic> json) => QuestionElement(
        options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        question1: json["Question 1"] == null ? null : Question1Class.fromJson(json["Question 1"]),
        question: json["question"] == null ? null : Question1Class.fromJson(json["question"]),
    );

    Map<String, dynamic> toJson() => {
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "Question 1": question1?.toJson(),
        "question": question?.toJson(),
    };
}

class Option {
    Option({
        required this.uid,
        required this.option,
        required this.question,
        required this.optionId,
    });

    String uid;
    String option;
    String question;
    int optionId;

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        uid: json["uid"],
        option: json["option"],
        question: json["question"],
        optionId: json["option_id"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "option": option,
        "question": question,
        "option_id": optionId,
    };
}

class Question1Class {
    Question1Class({
        required this.uid,
        required this.question,
        this.description,
        required this.questionare,
    });

    String uid;
    String question;
    String? description;
    String questionare;

    factory Question1Class.fromJson(Map<String, dynamic> json) => Question1Class(
        uid: json["uid"],
        question: json["question"],
        description: json["description"],
        questionare: json["questionare"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "question": question,
        "description": description,
        "questionare": questionare,
    };
}

class Options {
    Options({
        this.question1,
        this.insight,
        this.suicide,
        this.agitation,
        this.retardation,
        this.weightLoss,
        this.depressedMood,
        this.hypochondriasis,
        this.genitalSymptoms,
        this.anxietyPsychic,
        this.anxietySomatic,
        this.feelingsOfGuilt,
        this.insomniaMiddle,
        this.insomniaDelayed,
        this.insomniaInitial,
        this.workAndInterests,
        this.somaticSymptomsGeneral,
        this.somaticSymptomsGastrointestinal,
        this.question2,
        this.question3,
        this.question4,
        this.question5,
        this.question6,
        this.question7,
        this.question8,
        this.question9,
        this.question10,
        this.question11,
        this.question12,
        this.question13,
        this.question14,
        this.question15,
        this.question16,
        this.question17,
        this.question18,
        this.question19,
        this.question20,
        this.question21,
    });

    dynamic question1;
    int? insight;
    int? suicide;
    int? agitation;
    int? retardation;
    int? weightLoss;
    int? depressedMood;
    int? hypochondriasis;
    int? genitalSymptoms;
    int? anxietyPsychic;
    int? anxietySomatic;
    int? feelingsOfGuilt;
    int? insomniaMiddle;
    int? insomniaDelayed;
    int? insomniaInitial;
    int? workAndInterests;
    int? somaticSymptomsGeneral;
    int? somaticSymptomsGastrointestinal;
    int? question2;
    int? question3;
    int? question4;
    int? question5;
    int? question6;
    int? question7;
    int? question8;
    int? question9;
    int? question10;
    int? question11;
    int? question12;
    int? question13;
    int? question14;
    int? question15;
    int? question16;
    int? question17;
    int? question18;
    int? question19;
    int? question20;
    int? question21;

    factory Options.fromJson(Map<String, dynamic> json) => Options(
        question1: json["Question 1"],
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
        somaticSymptomsGastrointestinal: json["SOMATIC SYMPTOMS - GASTROINTESTINAL"],
        question2: json["Question 2"],
        question3: json["Question 3"],
        question4: json["Question 4"],
        question5: json["Question 5"],
        question6: json["Question 6"],
        question7: json["Question 7"],
        question8: json["Question 8"],
        question9: json["Question 9"],
        question10: json["Question 10"],
        question11: json["Question 11"],
        question12: json["Question 12"],
        question13: json["Question 13"],
        question14: json["Question 14"],
        question15: json["Question 15"],
        question16: json["Question 16"],
        question17: json["Question 17"],
        question18: json["Question 18"],
        question19: json["Question 19"],
        question20: json["Question 20"],
        question21: json["Question 21"],
    );

    Map<String, dynamic> toJson() => {
        "Question 1": question1,
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
        "Question 2": question2,
        "Question 3": question3,
        "Question 4": question4,
        "Question 5": question5,
        "Question 6": question6,
        "Question 7": question7,
        "Question 8": question8,
        "Question 9": question9,
        "Question 10": question10,
        "Question 11": question11,
        "Question 12": question12,
        "Question 13": question13,
        "Question 14": question14,
        "Question 15": question15,
        "Question 16": question16,
        "Question 17": question17,
        "Question 18": question18,
        "Question 19": question19,
        "Question 20": question20,
        "Question 21": question21,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
