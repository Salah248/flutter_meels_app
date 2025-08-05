class CardModel {
  final int? id;
  final String? image;
  final String? title;
  final String? rate;
  final String? time;

  CardModel({this.id, this.image, this.title, this.rate, this.time});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'title': title,
      'rate': rate,
      'time': time,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'] != null ? map['id'] as int : null,
      image: map['image'] != null ? map['image'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      rate: map['rate'] != null ? map['rate'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
    );
  }
}
