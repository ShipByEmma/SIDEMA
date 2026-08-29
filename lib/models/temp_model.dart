class TempModel {
  final double temperatura;

  TempModel({required this.temperatura});

  factory TempModel.fromJson(Map<String, dynamic> json) {
    return TempModel(
      temperatura: (json['temperatura'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperatura': temperatura,
    };
  }
}
