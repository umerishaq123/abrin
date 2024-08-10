class BookmarkedBusiness {
  final int id;
  final String name;
  final String category;
  final String coverPicture;
  final String location;

  BookmarkedBusiness({
    required this.id,
    required this.name,
    required this.category,
    required this.coverPicture,
    required this.location,
  });

  factory BookmarkedBusiness.fromJson(Map<String, dynamic> json) {
    return BookmarkedBusiness(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      coverPicture: json['coverPicture'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'coverPicture': coverPicture,
      'location': location,
    };
  }
}
