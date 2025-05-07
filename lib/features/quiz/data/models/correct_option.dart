
class CorrectedOption {
  final String id;
  final String text;
  final String optionLetter;

  CorrectedOption({
    required this.id,
    required this.text,
    required this.optionLetter,
  });

  factory CorrectedOption.fromJson(Map<String, dynamic> json) {
    return CorrectedOption(
      id: json['optionId'],
      text: json['optionText'],
      optionLetter: json['optionLetter'],
    );
  }

  static CorrectedOption empty() =>
      CorrectedOption(id: '', text: '', optionLetter: '');
}
