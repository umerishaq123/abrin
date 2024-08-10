class ReviewModel {
  final String userName;
  final String comment;
  final int rating;

  ReviewModel({required this.userName, required this.comment, required this.rating});

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      userName: json['userName'],
      comment: json['comment'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'comment': comment,
      'rating': rating,
    };
  }
}
