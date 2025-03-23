import 'dart:convert';

class PromptBlockModel {
  final String type;
  final List<PromptModel> prompts;

  PromptBlockModel({required this.type, required this.prompts});
}

class PromptModel {
  final String id;
  final String name;
  final String text;
  final int rating;
  final int viewedCnt;
  final String type;

  PromptModel(
      {required this.id,
      required this.name,
      required this.text,
      required this.rating,
      required this.viewedCnt,
      required this.type});

  factory PromptModel.fromJson(Map<String, dynamic> json) => PromptModel(
        id: json['id'],
        name: json['name'],
        text: json['text'],
        rating: json['rating'],
        viewedCnt: json['viewedCnt'],
        type: json['type'],
      );

  String toJson() => jsonEncode({
        'id': id,
        'name': name,
        'text': text,
        'rating': rating,
        'viewedCnt': viewedCnt,
        'type': type,
      });
}
