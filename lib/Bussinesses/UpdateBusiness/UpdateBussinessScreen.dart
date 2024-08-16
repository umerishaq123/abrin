import 'dart:io';

import 'package:abrin_app_new/Bussinesses/bussinessModel.dart';
import 'package:abrin_app_new/RetriveToken.dart';
import 'package:abrin_app_new/componets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import 'apiForUpdateBusiness.dart';

class EditBusinessScreen extends StatefulWidget {
  final Map<String, dynamic> business;

  EditBusinessScreen({required this.business});

  @override
  _EditBusinessScreenState createState() => _EditBusinessScreenState();
}

class _EditBusinessScreenState extends State<EditBusinessScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _socialMediaController = TextEditingController();

  String selectedCategory = 'Select a category:';
  final List<String> categories = [
    'Select a category:',
    'Restaurant',
    'Shopping',
    'Hotel',
    'Entertainment',
    'Tech',
    'Services',
    'Education',
  ];

  File? _profilePicture;
  File? _coverPicture;
  List<File> _galleryImages = [];
  Position? _location;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    _nameController.text = widget.business['name'] ?? '';
    _descriptionController.text = widget.business['description'] ?? '';
    selectedCategory = widget.business['category'] ?? 'Select a category:';
    _addressController.text = widget.business['address'] ?? '';
    _phoneController.text = widget.business['phone'] ?? '';
    _emailController.text = widget.business['email'] ?? '';
    _websiteController.text = widget.business['website'] ?? '';
    _socialMediaController.text = widget.business['socialMedia'] ?? '';
  }

  Future<void> _pickImage(ImageSource source, {required bool isProfile}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (isProfile) {
          _profilePicture = File(pickedFile.path);
        } else {
          _coverPicture = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _pickGalleryImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _galleryImages.addAll(pickedFiles.map((file) => File(file.path)));
      });
    }
  }

  Future<void> _pickLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _location = position;
        _addressController.text = '${position.latitude}, ${position.longitude}';
      });
    } catch (e) {
      print('Error fetching location: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error fetching location: Enable your location services.',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }

  Future<void> _updateBusiness() async {
    if (_nameController.text.isEmpty)
      _nameController.text = widget.business['name'];
    if (selectedCategory == 'Select a category:')
      selectedCategory = widget.business['category'];
    if (_descriptionController.text.isEmpty)
      _descriptionController.text = widget.business['description'];
    if (_addressController.text.isEmpty)
      _addressController.text = widget.business['address'];
    if (_phoneController.text.isEmpty)
      _phoneController.text = widget.business['phone'];
    if (_emailController.text.isEmpty)
      _emailController.text = widget.business['email'];
    if (_websiteController.text.isEmpty)
      _websiteController.text = widget.business['website'];
    if (_socialMediaController.text.isEmpty)
      _socialMediaController.text = widget.business['socialMedia'];

    final token = await getToken();
    if (token == null || token.isEmpty) {
      setState(() {
        _isLoading = false;
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

    setState(() {
      _isLoading = true;
    });

    final updatedBusiness = Business(
      id: widget.business['id'],
      name: _nameController.text,
      description: _descriptionController.text,
      category: selectedCategory!,
      coverPicture:
          _coverPicture?.path ?? widget.business['coverPicture'] ?? '',
      location: _addressController.text,
      // rating: widget.business['rating'],
      isApproved: widget.business['isApproved'],
      isVerified: true,
      profilePicture: '',
      // email: widget.business['email'],
      phone: widget.business['phone'],
      socialMedia: widget.business['socialMedia'],
      website: widget.business['website'],
    );

    try {
      final response = await ApiServices().updateBusiness(
        widget.business['id'],
        token,
        updatedBusiness,
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Business updated successfully!',
              style: TextStyle(color: Colors.green),
            ),
          ),
        );
      } else {
        throw Exception('Failed to update business: ${response.body}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to update business: $error',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
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
          'Modifier l\'entreprise',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),
        ),
        actions: [
          IconButton(
            icon: _isLoading
                ? CircularProgressIndicator()
                : Icon(
                    Icons.check,
                    color: Colors.blue,
                    size: 28,
                  ),
            onPressed: _isLoading ? null : _updateBusiness,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _pickImage(ImageSource.gallery, isProfile: true),
                child: _profilePicture == null
                    ? widget.business['profilePicture'] != null
                        ? ClipOval(
                            child: Image.network(
                              widget.business['profilePicture'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.grey[800],
                            ),
                          )
                    : ClipOval(
                        child: Image.file(
                          _profilePicture!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                obscureText: false,
                controller: _nameController,
                labelText: 'Name:',
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Catégorie:',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                obscureText: false,
                controller: _descriptionController,
                labelText: 'Description:',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                obscureText: false,
                controller: _phoneController,
                labelText: 'Phone:',
                keyboardType: TextInputType.phone,
                maxLength: 11,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                obscureText: false,
                controller: _emailController,
                labelText: 'Email:',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                obscureText: false,
                controller: _websiteController,
                labelText: 'Website:',
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                obscureText: false,
                controller: _socialMediaController,
                labelText: 'Social Media:',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                obscureText: false,
                controller: _addressController,
                labelText: 'Address',
                suffixIcon: IconButton(
                  icon: Icon(Icons.map),
                  onPressed: _pickLocation,
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _pickImage(ImageSource.gallery, isProfile: false),
                child: _coverPicture == null
                    ? widget.business['coverPicture'] != null
                        ? Image.network(
                            widget.business['coverPicture'],
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.grey[800],
                            ),
                          )
                    : Image.file(
                        _coverPicture!,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(height: 16),
              Text(
                'Gallery',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _galleryImages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _galleryImages.length) {
                      return GestureDetector(
                        onTap: _pickGalleryImages,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.grey[800],
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.file(
                          _galleryImages[index],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
