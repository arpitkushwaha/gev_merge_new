class FeedbackListModel {
  String name;
  String text;
  double rating;

  FeedbackListModel({this.name, this.text, this.rating});

  factory FeedbackListModel.fromJson(Map<String, dynamic> json) {
    return FeedbackListModel(
        name: json['name'],
        text: json['comments'],
        rating: json['rating'].toDouble());
  }
}
