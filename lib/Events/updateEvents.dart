
import 'dart:io';

import 'package:abrin_app_new/Bussinesses/AddNewBusiness/LoactionPikerscreen.dart';
import 'package:abrin_app_new/Bussinesses/UpdateBusiness/apiForUpdateBusiness.dart';
import 'package:abrin_app_new/Events/ApiHandlerForEvents.dart';
import 'package:abrin_app_new/Events/addeventsmodel.dart';
import 'package:abrin_app_new/RetriveToken.dart';
import 'package:abrin_app_new/componets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class EditEventScreen extends StatefulWidget {
  final Map<String, dynamic> event;

  EditEventScreen({required this.event});

  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final ApiService apiService = ApiService();
  bool _isLoading = false;

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  File? _image;
  Position? location;

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.event['description'] ?? '';
    _nameController.text = widget.event['name'] ?? '';
    _locationController.text = widget.event['location'] ?? '';
    _dateController.text = widget.event['date'] ?? '';
    _timeController.text = widget.event['time'] ?? '';
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text =
            "${pickedDate.year}/${pickedDate.month}/${pickedDate.day}";
      });
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _timeController.text =
            "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> pickLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception(
            'Location services are disabled. Please enable your location.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied. We cannot request permissions.');
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        location = position;
      });
      print('Picked Location: (${location!.latitude}, ${location!.longitude})');
    } catch (e) {
      print('Error fetching location: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Error fetching location: Enable your location services.',
              style: TextStyle(color: Colors.red)),
        ),
      );
    }
  }

  Future<void> updateEvent() async {
    setState(() {
      _isLoading = true;
    });

    final token = await getToken();
    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: Invalid token. Please login again.',
              style: TextStyle(color: Colors.red)),
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final updatedEvent = Event(
      id: widget.event['id'] ?? '',
      image: _image?.path ?? widget.event['image'] ?? '',
      description: _descriptionController.text,
      name: _nameController.text,
      location: _locationController.text,
      date: _dateController.text,
      time: _timeController.text,
    );

    try {
      final response = await apiService.updateEvent(
          widget.event['id'] ?? '', token, updatedEvent);

      if (response.statusCode == 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Event updated successfully!',
                style: TextStyle(color: Colors.green)),
          ),
        );
      } else {
        throw Exception('Failed to update event: ${response.body}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update event: $error',
              style: TextStyle(color: Colors.red)),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Edit Event',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            color: Colors.blue,
            iconSize: 30,
            onPressed: _isLoading ? null : updateEvent,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 150,
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.blue)),
                child: _image != null
                    ? Image.file(_image!, fit: BoxFit.fill)
                    : Center(
                        child: Icon(CupertinoIcons.photo_camera,
                            size: 40, color: Colors.blue),
                      ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Enter Name:",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 6),
            CustomTextField(
              obscureText: false,
              controller: _nameController,
              labelText: 'Name:',
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Add some description",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 6),
            CustomTextField(
              obscureText: false,
              controller: _descriptionController,
              labelText: 'Description:',
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Select date for event",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 6),
            CustomTextField(
              obscureText: false,
              controller: _dateController,
              labelText: 'Date:',
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today, color: Colors.blue),
                onPressed: _pickDate,
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Select time for event",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 6),
            CustomTextField(
              obscureText: false,
              controller: _timeController,
              labelText: 'Time:',
              suffixIcon: IconButton(
                icon: Icon(Icons.access_time, color: Colors.blue),
                onPressed: _pickTime,
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Select address of event",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 6),
            CustomTextField(
              obscureText: false,
              controller: _locationController,
              labelText: 'Address:',
              suffixIcon: IconButton(
                icon: Icon(Icons.map, color: Colors.blue),
                onPressed: () async {
                  String? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LocationPickerScreen()),
                  );

                  if (result != null) {
                    _locationController.text = result;
                  }
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
