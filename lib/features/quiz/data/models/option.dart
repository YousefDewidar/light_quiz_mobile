import 'dart:convert';

class Option {
  String optionId;
  String optionText;
  String optionLetter;

  Option({
    required this.optionId,
    required this.optionText,
    required this.optionLetter,
  });

  factory Option.fromMap(Map<String, dynamic> map) {
    return Option(
      optionId: map['optionId'] as String,
      optionText: map['optionText'] as String,
      optionLetter: map['optionLetter'] as String,
    );
  }

  factory Option.fromJson(String source) =>
      Option.fromMap(json.decode(source) as Map<String, dynamic>);
}
