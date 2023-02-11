class baseResp {
  Questionare? questionare;
  List<Questions> questions=[];

  baseResp({this.questionare,required this.questions});

  baseResp.fromJson(Map<String, dynamic> json) {
    questionare = json['questionare'] != null
        ? Questionare.fromJson(json['questionare'])
        : null;
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (questionare != null) {
      data['questionare'] = questionare!.toJson();
    }
    if (questions != null) {
      data['questions'] = questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questionare {
  String? uid;
  String? type;

  Questionare({this.uid, this.type});

  Questionare.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['type'] = type;
    return data;
  }
}

class Questions {
  Question? question;
  List<Options>? options;

  Questions({this.question, this.options});

  Questions.fromJson(Map<String, dynamic> json) {
    question = json['question'] != null
        ?  Question.fromJson(json['question'])
        : null;
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (question != null) {
      data['question'] = question!.toJson();
    }
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  String? uid;
  String? question;
  String? description;
  String? questionare;

  Question({this.uid, this.question, this.description, this.questionare});

  Question.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    question = json['question'];
    description = json['description'];
    questionare = json['questionare'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['question'] = question;
    data['description'] = description;
    data['questionare'] = questionare;
    return data;
  }
}

class Options {
  String? uid;
  String? option;
  int? optionId;
  String? question;

  Options({this.uid, this.option, this.optionId, this.question});

  Options.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    option = json['option'];
    optionId = json['option_id'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['option'] = option;
    data['option_id'] = optionId;
    data['question'] = question;
    return data;
  }
}
