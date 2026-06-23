class QuestionModel {
  final int questionNumber;
  final String questionText;
  final String audioUrl;
  final int duration;

  QuestionModel({
    required this.questionNumber,
    required this.questionText,
    required this.audioUrl,
    required this.duration,
  });

  factory QuestionModel.fromJson(Map json) => QuestionModel(
    questionNumber: json['questionNumber'],
    questionText: json['questionText'],
    audioUrl: json['audioUrl'],
    duration: json['duration'],
  );
}

/*
{
"questionNumber": 1,
"questionText": "자기소개를 부탁드립니다.",
"audioUrl": "http://localhost:8000/interview-audio/fe_q1.mp3",
"duration": 8
},*/
