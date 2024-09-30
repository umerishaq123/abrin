import 'dart:io';

import 'package:abrin_app_new/Bussinesses/AddNewBusiness/LoactionPikerscreen.dart';
import 'package:abrin_app_new/Events/ApiHandlerForEvents.dart';
import 'package:abrin_app_new/Events/addeventsmodel.dart';
import 'package:abrin_app_new/RetriveToken.dart';
import 'package:abrin_app_new/aouth/component/session_handling_provider.dart';
import 'package:abrin_app_new/componets/widgets.dart';
import 'package:abrin_app_new/utilis/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final ApiService apiService = ApiService();
  bool _isLoading = false;

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  File? _image;
  // Position? location;
  String? selectedCity;
  String? selectedLocation;

  String selectedCategory = 'Select a category:';
  final List<String> cities = [
    'Conakry',
  ];

  final Map<String, List<String>> cityLocations = {
    'Conakry': [
      'Ratoma',
      'Kaloum',
      'Gbessia',
      'Dixinn',
      'Matoto',
      'Tombolia',
      'Lambanyi',
      'Sonfonia',
      'Matam',
      'Kagbelen',
      'Sanoyah',
      'Kassa',
    ],
    //  'Abbbottabad': [
    //   'fawaraChoke',
    //   'Kehal',
    //   'nawasher',
    //   'bilalTown',
    //   'Mandian',
    //   'MalikPura',

    // ],
  };

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

  // Future<void> pickLocation() async {
  //   try {
  //     bool serviceEnabled;
  //     LocationPermission permission;

  //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       throw Exception(
  //           'Location services are disabled. Please enable your location.');
  //     }

  //     permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         throw Exception('Location permissions are denied');
  //       }
  //     }

  //     if (permission == LocationPermission.deniedForever) {
  //       throw Exception(
  //           'Location permissions are permanently denied. We cannot request permissions.');
  //     }

  //     Position position = await Geolocator.getCurrentPosition();
  //     setState(() {
  //       location = position;
  //     });
  //     print('Picked Location: (${location!.latitude}, ${location!.longitude})');
  //   } catch (e) {
  //     print('Error fetching location: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           'Error fetching location: Enable your location services.',
  //           style: TextStyle(color: Colors.red),
  //         ),
  //       ),
  //     );
  //   }
  // }

  Future<void> addEvent() async {
    // if (_nameController.text.isNotEmpty &&
    //     _descriptionController.text.isNotEmpty &&
    //     _dateController.text.isNotEmpty &&
    //     _timeController.text.isNotEmpty &&
    //      selectedLocation!=null &&
    //     _image != null) {
    if (_nameController.text.isEmpty) {
      Utils.snackBar("Veuillez entrer un nom", context);
    } else if (_descriptionController.text.isEmpty) {
      Utils.snackBar("Veuillez saisir une description", context);
    } else if (_dateController.text.isEmpty) {
      Utils.snackBar("Veuillez entrer une date", context);
    } else if (_timeController.text.isEmpty) {
      Utils.snackBar("Veuillez entrer l'heure de l'événement", context);
    } else if (selectedLocation == null) {
      Utils.snackBar("Veuillez entrer un lieu d'événement", context);
    } else if (_image == null) {
      Utils.snackBar("Veuillez entrer une image", context);
    }

    setState(() {
      _isLoading = true; // Start loading
    });

    final token = await SessionHandlingViewModel().getToken();
    if (token == null || token.isEmpty) {
      setState(() {
        _isLoading = false; // Stop loading if token is invalid
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: Invalid token. Please login again.',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
      return;
    }

    final event = Event(
      id: '',
      image: _image!.path,
      description: _descriptionController.text,
      name: _nameController.text,
      location: '$selectedLocation',
      date: _dateController.text,
      time: _timeController.text,
    );

    try {
      final response = await apiService.addEvent(token, event);

      if (response.statusCode == 200) {
        Navigator.pop(context);
        print('Event added successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Event added successfully!',
              style: TextStyle(color: Colors.green),
            ),
          ),
        );
      } else {
        throw Exception('Failed to add event: ${response.body}');
      }
    } catch (error) {
      print('Failed to add event: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to add event: $error',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false; // Stop loading when request is completed
      });
    }
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(
    //         'Please fill all fields and select an image.',
    //         style: TextStyle(color: Colors.red),
    //       ),
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Add Event',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
          )),
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
                    ? Image.file(
                        _image!,
                        fit: BoxFit.fill,
                      )
                    : Center(
                        child: Icon(
                          CupertinoIcons.photo_camera,
                          size: 40,
                          color: Colors.blue,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Entrez le nom :",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            CustomTextField(
              obscureText: false,
              controller: _nameController,
              labelText: 'Nom:',
              required: true,
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Ajouter une description",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            CustomTextField(
              obscureText: false,
              controller: _descriptionController,
              labelText: 'Description:',
              required: true,
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Sélectionnez la date de l'événement",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
              required: true,
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Sélectionnez l'heure de l'événement",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            CustomTextField(
              obscureText: false,
              controller: _timeController,
              labelText: 'Temps:',
              suffixIcon: IconButton(
                icon: Icon(Icons.access_time, color: Colors.blue),
                onPressed: _pickTime,
              ),
              required: true,
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Sélectionnez l'adresse de l'événement",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            // SizedBox(height: 3),
            // CustomTextField(
            //   obscureText: false,
            //   controller: _locationController,
            //   labelText: 'Address:',
            //   suffixIcon: IconButton(
            //     icon: Icon(
            //       Icons.map,
            //       color: Colors.blue,
            //     ),
            //     onPressed: () async {
            //       // Use your location picker screen here
            //       String? result = await Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => LocationPickerScreen(),
            //         ),
            //       );

            //       if (result != null) {
            //         _locationController.text = result;
            //       }
            //     },
            //   ),
            // ),
            SizedBox(height: 3),
            DropdownButtonFormField<String>(
              value: selectedCity,
              onChanged: (value) {
                setState(() {
                  selectedCity = value;
                  selectedLocation = null; // Reset location on city change
                });
              },
              items: cities.map((city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Ville*',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedLocation,
              onChanged: (value) {
                setState(() {
                  selectedLocation = value;
                });
              },
              items: selectedCity != null
                  ? cityLocations[selectedCity!]!
                      .map((location) => DropdownMenuItem<String>(
                            value: location,
                            child: Text(location),
                          ))
                      .toList()
                  : [],
              decoration: InputDecoration(
                labelText: 'Emplacement*',
                border: OutlineInputBorder(),
              ),
            ),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: addEvent,
                    child: Text(
                      'Add Event Now',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
