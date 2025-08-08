class CardModel {
  final String? image;
  final String? title;
  final String? description;
  final double? rate;
  final String? time;

  CardModel({
    required this.image,
    required this.title,
    required this.description,
    required this.rate,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'title': title,
      'description': description,
      'rate': rate,
      'time': time,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      image: map['image'] != null ? map['image'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      rate: map['rate'] != null ? map['rate'] as double : null,
      time: map['time'] != null ? map['time'] as String : null,
    );
  }
}
