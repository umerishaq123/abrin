
import 'package:abrin_app_new/Bussinesses/UpdateBusiness/UpdateBussinessScreen.dart';
import 'package:flutter/material.dart';

class ViewBuisnessScreen extends StatefulWidget {
  final Map<String, dynamic> business;

  ViewBuisnessScreen({required this.business});

  @override
  State<ViewBuisnessScreen> createState() => _ViewBuisnessScreenState();
}

class _ViewBuisnessScreenState extends State<ViewBuisnessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.business['name']),
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
                    builder: (context) => EditBusinessScreen(
                          business: widget.business,
                        )),
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
            widget.business['coverPicture'] != null
                ? Image.network(widget.business['coverPicture'])
                : Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
            SizedBox(height: 16),
            Text(
              widget.business['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              widget.business['category'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            Text(
              widget.business['description'] ?? 'No description available.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
