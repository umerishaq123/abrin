
import 'package:abrin_app_new/Notifiction/modelForNotification.dart';
import 'package:flutter/material.dart';

class Notificationdata extends StatelessWidget {
  final NotificationModel notification;
  final Function(String) onMarkAsRead;

  const Notificationdata({
    Key? key,
    required this.notification,
    required this.onMarkAsRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(147, 216, 213, 213),
        ),
        child: ListTile(
          leading: CircleAvatar(
            maxRadius: 26,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/Notification.png'),
          ),
          title: Text(
            notification.date,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            notification.message,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(notification.time),
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  onMarkAsRead(notification.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
