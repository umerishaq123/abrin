
import 'package:abrin_app_new/Events/updateEvents.dart';
import 'package:flutter/material.dart';

class EventsEditScreen extends StatefulWidget {
  final Map<String, dynamic> event;

  EventsEditScreen({required this.event});

  @override
  State<EventsEditScreen> createState() => _EventsEditScreenState();
}

class _EventsEditScreenState extends State<EventsEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.event['name'],
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.black,
            iconSize: 28,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditEventScreen(event: widget.event),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.event['image'] != null
                ? Image.network(widget.event['image'])
                : Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
            SizedBox(height: 16),
            Text(
              widget.event['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              widget.event['description'] ?? 'No description available.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 8),
            Text(
              widget.event['location'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 8),
            Text(
              widget.event['date'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 8),
            Text(
              widget.event['time'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
