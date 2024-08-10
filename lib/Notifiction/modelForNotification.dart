class NotificationModel {
  final String id;
  final String date;
  final String message;
  final String time;

  NotificationModel({
    required this.id,
    required this.date,
    required this.message,
    required this.time,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      date: json['date'],
      message: json['message'],
      time: json['time'],
    );
  }
}
