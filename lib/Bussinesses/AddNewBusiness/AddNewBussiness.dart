import 'dart:async';
import 'dart:io';

import 'package:abrin_app_new/Bussinesses/AddNewBusiness/LoactionPikerscreen.dart';
import 'package:abrin_app_new/Home/home_Screen.dart';
import 'package:abrin_app_new/RetriveToken.dart';
import 'package:abrin_app_new/aouth/component/session_handling_provider.dart';
import 'package:abrin_app_new/componets/modelCategories.dart';
import 'package:abrin_app_new/componets/widgets.dart';
import 'package:abrin_app_new/utilis/utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as https;
import 'package:image_picker/image_picker.dart';

class AddNewBusinessScreen extends StatefulWidget {
  final List<Categorys> categories;
  const AddNewBusinessScreen({required this.categories, super.key});

  @override
  State<AddNewBusinessScreen> createState() => _AddNewBusinessScreenState();
}

class _AddNewBusinessScreenState extends State<AddNewBusinessScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController socialMediaController = TextEditingController();
  bool _isLoading = false;
  String? selectedCity;
  String? selectedLocation;

  String selectedCategory = 'Sélectionnez une catégorie :';
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
  final List<String> categories = [
    'Sélectionnez une catégorie :',
    ' Restaurant , Café , Dessert',
    ' Entreprise événementielle',
    " Hotel , Motel , Résidence",
    ' Travailleur indépendant ',
    ' Boulangerie , Patisserie',
    ' Club , Bar , Lounge',
    ' Salon , Spa',
    'Vente en ligne',
    ' Vente en boutique',
    ' Hôpital , Pharmacie',
    ' Immobilier ',
    ' Supermarché , alimentation générale ',
    ' Institution financière',
    ' Sport , Gym',
    'Transport , Livraison',
    ' Station essence',
        ' École , Université et Institut de formation',
    ' Média et actualité',
    ' Institution gouvernementale',
    ' Plage , Plain air',
    ' Garage auto et moto',
    'Lavage auto et moto',
    ' Pressing',
    ' Police , Service d’urgence',
    ' Voyage , Tourisme',
    ' Infographie',
    ' Mosquée , Église',
    ' Autres'
  ];

  XFile? profilePicture;
  XFile? coverPicture;
  List<XFile> galleryImages = [];
  // Position? location;

  Future<void> pickProfilePicture() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          profilePicture = pickedFile;
        });
      }
    } catch (e) {
      print("Error picking profile picture: $e");
    }
  }

  Future<void> pickCoverPicture() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          coverPicture = pickedFile;
        });
      }
    } catch (e) {
      print("Error picking cover picture: $e");
    }
  }

  Future<void> pickGalleryImages() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile>? pickedFiles = await picker.pickMultiImage();
      if (pickedFiles != null) {
        setState(() {
          galleryImages.addAll(pickedFiles);
        });
      }
    } catch (e) {
      print("Error picking gallery images: $e");
    }
  }

  // Future<void> pickLocation() async {
  //   try {
  //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       throw Exception(
  //           'Location services are disabled. Please enable your location.');
  //     }

  //     LocationPermission permission = await Geolocator.checkPermission();
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
  //       addressController.text = '${position.latitude}, ${position.longitude}';
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

  // Future<void> addBusiness() async {
  //   if (nameController.text.isEmpty ||
  //       selectedCategory == 'Select a category:' ||
  //       descriptionController.text.isEmpty ||
  //      selectedLocation == null ||
  //       profilePicture == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           'Please fill in all required fields',
  //           style: TextStyle(color: Colors.red),
  //         ),
  //       ),
  //     );
  //     return;
  //   }

  //   final token = await SessionHandlingViewModel().getToken();
  //   if (token == null || token.isEmpty) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           'Error: Invalid token. Please login again.',
  //           style: TextStyle(color: Colors.red),
  //         ),
  //       ),
  //     );
  //     return;
  //   }

  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     final url = Uri.parse('https://srv562456.hstgr.cloud/api/business/add');
  //     final request = https.MultipartRequest('POST', url)
  //       ..headers['Authorization'] = '$token'
  //       ..fields['name'] = nameController.text
  //       ..fields['category'] = selectedCategory
  //       ..fields['description'] = descriptionController.text
  //       ..fields['phone'] = phoneController.text
  //       ..fields['email'] = emailController.text
  //       ..fields['website'] = websiteController.text
  //       ..fields['socialMedia'] = socialMediaController.text
  //       ..fields['location'] = selectedLocation ?? "";

  //     print('Location Data: ${request.fields['location']}');

  //     if (profilePicture != null) {
  //       request.files.add(await https.MultipartFile.fromPath(
  //         'profilePicture',
  //         profilePicture!.path,
  //       ));
  //     }

  //     if (coverPicture != null) {
  //       request.files.add(await https.MultipartFile.fromPath(
  //         'coverPicture',
  //         coverPicture!.path,
  //       ));
  //     }

  //     for (var image in galleryImages) {
  //       request.files.add(await https.MultipartFile.fromPath(
  //         'gallery',
  //         image.path,
  //       ));
  //     }

  //     final response = await request.send();

  //     if (response.statusCode == 200) {
  //       print('Business Added Successfully');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //             'Business Added Successfully',
  //             style: TextStyle(color: Colors.green),
  //           ),
  //         ),
  //       );
  //     } else {
  //       final responseBody = await response.stream.bytesToString();
  //       print('Failed to add business. Status code: ${response.statusCode}');
  //       print('Response body: $responseBody');
  //       throw Exception(
  //           'Failed to add business. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error adding business: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           'Error adding business: Something went wrong ',
  //           style: TextStyle(color: Colors.red),
  //         ),
  //       ),
  //     );
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  Future<void> addBusiness() async {
    print("::: the category is :$selectedCategory");
    // if (nameController.text.isEmpty ||
    //     selectedCategory == 'Sélectionnez une catégorie :' ||
    //     descriptionController.text.isEmpty ||
    //     selectedLocation == null ||
    //     profilePicture == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(
    //         'Please fill in all required fields',
    //         style: TextStyle(color: Colors.red),
    //       ),
    //     ),
    //   );
    //   return;
    // } 
    if(nameController.text.isEmpty){
      Utils.snackBar('Veuillez entrer le nom', context);
    }else if(selectedCategory.isEmpty){
      Utils.snackBar('Veuillez sélectionner une catégorie', context);
    }else if(selectedCity==null){
      Utils.snackBar('Veuillez sélectionner une ville', context);
    }else if(selectedLocation==null){
      Utils.snackBar("Veuillez entrer un emplacement", context);

    }
    else if(descriptionController.text.isEmpty){
      Utils.snackBar("Veuillez saisir une description", context);

    }else if(phoneController.text.isEmpty){
      Utils.snackBar('Veuillez entrer un numéro de téléphone', context);
    }
    else if (galleryImages.length < 5) {
      Utils.toastMessage('Please select at least 5 photos.');
      return;
    }

    final token = await SessionHandlingViewModel().getToken();
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

    try {
      final url = Uri.parse('https://srv562456.hstgr.cloud/api/business/add');
      final request = https.MultipartRequest('POST', url)
        ..headers['Authorization'] = ' $token' // Use Bearer token prefix
        ..fields['name'] = nameController.text
        ..fields['category'] = selectedCategory
        ..fields['description'] = descriptionController.text
        ..fields['phone'] = phoneController.text
        ..fields['email'] = emailController.text
        ..fields['website'] = websiteController.text
        ..fields['socialMedia'] = socialMediaController.text
        ..fields['location'] = selectedLocation ?? ""
        ..fields['city'] = selectedCity ?? "";

      print('Location Data: ${request.fields['location']}');

      if (profilePicture != null) {
        request.files.add(await https.MultipartFile.fromPath(
          'profilePicture',
          profilePicture!.path,
        ));
      }

      if (coverPicture != null) {
        request.files.add(await https.MultipartFile.fromPath(
          'coverPicture',
          coverPicture!.path,
        ));
      }

      for (var image in galleryImages) {
        request.files.add(await https.MultipartFile.fromPath(
          'gallery',
          image.path,
        ));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Business Added Successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Entreprise ajoutée avec succès',
              style: TextStyle(color: Colors.green),
            ),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomeScreen(categories: widget.categories,), // Replace with your Signup screen widget
          ),
        );
      } else {
        final responseBody = await response.stream.bytesToString();
        print('Failed to add business. Status code: ${response.statusCode}');
        print('Response body: $responseBody');
        throw Exception(
            'Failed to add business. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding business: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Erreur lors de l'ajout d'une entreprise : un problème s'est produit",
            style: TextStyle(color: Colors.red),
          ),
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Ajouter nouvelle entreprise',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.blue),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: pickProfilePicture,
                  child: profilePicture == null
                      ? Container(
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
                            File(profilePicture!.path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  obscureText: false,
                  controller: nameController,
                  labelText: 'Nom:',
                  required: true,
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
                    labelText: 'Catégorie: *',

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  selectedItemBuilder: (BuildContext context) {
                    return categories.map<Widget>((String item) {
                      return Text(item);
                    }).toList();
                  },
                  // Customizing the dropdown menu
                  dropdownColor: Colors.white,
                  isExpanded:
                      true, // Allows the dropdown to take the full width of the parent
                  menuMaxHeight: 200.0, // Maximum height of the dropdown list
                ),

                // DropdownButtonFormField<String>(
                //   value: selectedCategory,
                //   items: categories.map((category) {
                //     return DropdownMenuItem<String>(
                //       value: category,
                //       child: Text(category),
                //     );
                //   }).toList(),
                //   onChanged: (value) {
                //     setState(() {
                //       selectedCategory = value!;
                //     });
                //   },
                //   decoration: InputDecoration(
                //     labelText: 'Category:',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //   ),
                // ),

                const SizedBox(height: 16),
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
                    labelText: 'Ville:*',
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
                    labelText: 'Emplacement:*',
                    border: OutlineInputBorder(),
                  ),
                ),
                // CustomTextField(
                //   obscureText: false,
                //   controller: addressController,
                //   labelText: 'Adresse:',
                //   suffixIcon: IconButton(
                //     icon: Icon(Icons.map),
                //     onPressed: () async {
                //       String? result = await Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => LocationPickerScreen()),
                //       );

                //       if (result != null) {
                //         addressController.text = result;
                //       }
                //     },
                //   ),
                // ),
                const SizedBox(height: 16),
                CustomTextField(
                  obscureText: false,
                  controller: descriptionController,
                  labelText: 'Description:',
                  required: true,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  obscureText: false,
                  controller: phoneController,
                  labelText: 'Phone:',
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  required: true,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  obscureText: false,
                  controller: emailController,
                  labelText: 'Email:',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  obscureText: false,
                  controller: websiteController,
                  labelText: 'Site web:',
                  keyboardType: TextInputType.url,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  obscureText: false,
                  controller: socialMediaController,
                  labelText: 'Réseaux sociaux:',
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: pickCoverPicture,
                  child: coverPicture == null
                      ? Container(
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
                          File(coverPicture!.path),
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Galerie',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: galleryImages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == galleryImages.length) {
                        return GestureDetector(
                          onTap: pickGalleryImages,
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
                            File(galleryImages[index].path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue),
                  onPressed: _isLoading ? null : addBusiness,
                  child: _isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          'Ajouter une entreprise',
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
