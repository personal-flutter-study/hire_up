class InterviewModel {
  final String type;
  final int sec;
  final DateTime date;

  InterviewModel({required this.type, required this.sec, required this.date});

  factory InterviewModel.fromJson(Map json) => InterviewModel(
    type: json['type'],
    sec: json['sec'],
    date: DateTime.parse(json['date'] as String),
  );

  Map toJson() => {'type': type, 'sec': sec, 'date': date.toIso8601String()};
}
