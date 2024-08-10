
class Event {
  final String id;
  final String image;
  final String description;
  final String name;
  final String location;
  final String time;
  final String date;
  bool highlighted;

  Event({
    required this.id,
    required this.image,
    required this.description,
    required this.name,
    required this.location,
    required this.time,
    required this.date,
    this.highlighted = false,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? '', // Provide default value for 'id' if null
      image: json['image'] ?? '', 
      description: json['description'] ?? '', 
      name: json['name'] ?? '', 
      location: json['location'] ?? '', 
      time: json['time'] ?? '', 
      date: json['date'] ?? '', 
       highlighted: json['highlighted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'description': description,
      'name': name,
      'location': location,
      'time': time,
      'date': date,
      'highlighted': highlighted,
    };
  }
}
