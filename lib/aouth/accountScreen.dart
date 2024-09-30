import 'dart:convert';
import 'dart:io';

import 'package:abrin_app_new/Bussinesses/UpdateBusiness/ViewBusiness.dart';
import 'package:abrin_app_new/Bussinesses/bussinessModel.dart';
import 'package:abrin_app_new/Events/ViewEvents.dart';
import 'package:abrin_app_new/Home/ReviewBusiness/BottomSheet.dart';
import 'package:abrin_app_new/Home/ReviewBusiness/ReviewScreen.dart';
import 'package:abrin_app_new/Home/business/customRatings.dart';
import 'package:abrin_app_new/RetriveToken.dart';
import 'package:abrin_app_new/aouth/component/session_handling_provider.dart';
import 'package:abrin_app_new/aouth/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  

 
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? _userName;
  String? _profilePicPath;
  bool _isLoading = false;
  bool _isEditingName = false;
  final ImagePicker _picker = ImagePicker();
  List<Map<String, dynamic>> _businesses = [];
  List<Map<String, dynamic>> _events = [];
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _fetchBusinesses();
    _fetchEvents();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_name') ?? 'Username';
      _profilePicPath = prefs.getString('profile_pic_path');
    });
    _nameController.text = _userName!;
  }

  Future<void> _updateProfilePic() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_pic_path', pickedFile.path);
      setState(() {
        _profilePicPath = pickedFile.path;
      });
    }
  }

  Future<void> _saveUserName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', _nameController.text);
    setState(() {
      _userName = _nameController.text;
      _isEditingName = false;
    });
  }

  Future<void> _fetchBusinesses() async {
    setState(() {
      _isLoading=true;
    });
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
    final response = await https.get(
      Uri.parse('https://srv562456.hstgr.cloud/api/auth/my-businesses'),
      headers: {'Authorization': '$token'},
    );

    if (response.statusCode == 200) {
      final List businesses = json.decode(response.body);
      setState(() {
        _businesses = businesses.map((b) => b as Map<String, dynamic>).toList();
      });
    }
    setState(() {
      _isLoading=false;
    });
  }

  Future<void> _fetchEvents() async {
    setState(() {
      _isLoading=true;
    });
    final token = await SessionHandlingViewModel().getToken();
    final response = await https.get(
      Uri.parse('https://srv562456.hstgr.cloud/api/auth/my-events'),
      headers: {'Authorization': '$token'},
    );
    print("::: the events in screen :${response.body}");
    if (response.statusCode == 200) {
      final List events = json.decode(response.body);

      setState(() {
        _events = events.map((e) => e as Map<String, dynamic>).toList();
      });
    }
    setState(() {
      _isLoading=false;
    });
  }

  Future<void> _logout() async {
    // final prefs = await SharedPreferences.getInstance();
    final prefsf = await SessionHandlingViewModel();
    await prefsf.removeUser();
    // await prefs.remove('user_name');
    // await prefs.remove('profile_pic_path');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(islogin: true,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100),
            GestureDetector(
              onTap: _updateProfilePic,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _profilePicPath != null
                    ? FileImage(File(_profilePicPath!))
                    : AssetImage('assets/defaultimg.jpg') as ImageProvider,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _isEditingName
                      ? Container(
                          width: 200,
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: 'Enter your name',
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text(
                            _userName ?? '',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                  IconButton(
                    icon: Icon(_isEditingName ? Icons.check : Icons.edit),
                    onPressed: () {
                      if (_isEditingName) {
                        _saveUserName();
                      } else {
                        setState(() {
                          _isEditingName = true;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    indicator: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(25), // Adjusted border radius
                      color: Colors.blue,
                    ),
                    indicatorColor: Colors.blue,
                    indicatorPadding: EdgeInsets.symmetric(
                        horizontal: -4,
                        vertical:
                            8), // Adjust this to make the indicator narrower
                    labelColor: Colors.white,
                    labelStyle: TextStyle(fontSize: 16),
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10), // Reduced padding
                        child: Tab(text: ' Mes entreprises '),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10), // Reduced padding
                        child: Tab(text: ' Mes événements '),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: TabBarView(
                      children: [
                        _buildBusinessList(),
                        _buildEventList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            height: 42,
            width: MediaQuery.of(context).size.width*0.4,
            child: FloatingActionButton.extended(
              onPressed: _logout,
              icon: Icon(Icons.logout),
              label: Text(
                "Déconnexion",
                style: TextStyle(fontSize: 16),
              ),
              backgroundColor: Color.fromARGB(255, 235, 101, 91),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBusinessList() {
    if (_businesses.isEmpty) {
      return Center(
        child: Text(
          "No Businesses yet",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      );
    }
    return ListView.builder(
      itemCount: _businesses.length,
      itemBuilder: (context, index) {
        final business = _businesses[index];
        // final allbussines=widget.business[in]
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReviewsScreen(
                    customRating: CustomRating(
                        coverPicture: business['coverPicture'],
                        type: business['category'],
                        name: business['name'],
                        address: business['location'],
                        description: business['description'],
                        profilePicture: business['profilePicture'],
                        isVerified: business['isVerified'],
                        phone: business['phone'],
                        website: business['website'],
                        socialMedia: business['socialMedia'],
                        id: business['_id'], email: business['email'], city: business['city'],),
                    bottomModel: BottomModel(
                        title: business['name'],
                        image: business['coverPicture'],
                        message: business['category'],
                        time: business['name']),
                    businessId: business['_id']),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                business['coverPicture'] != null
                    ? Container(
                        height: 70,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          image: DecorationImage(
                            image: NetworkImage(business['coverPicture']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        height: 70,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 143, 142, 142),
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                SizedBox(
                  width: 13,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(business['name'],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 4,
                      ),
                      Text(business['category'],
                          style: TextStyle(
                            fontSize: 16,
                          ),
                           overflow: TextOverflow.ellipsis,
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEventList() {
  if (_events.isEmpty) {
    print("::: print1");
    return Center(
      child: Text("No Events yet",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
    );
  }
  return ListView.builder(
    itemCount: _events.length,
    itemBuilder: (context, index) {
      final event = _events[index];
      print("::: the image path is :${event['image']}");

      // Determine if the image is a local file or a network URL
      bool isNetworkImage = event['image'] != null && event['image'].startsWith('http');

      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventsEditScreen(event: event),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              if (event['image'] != null)
                Container(
                  height: 60,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    image: DecorationImage(
                      image: isNetworkImage
                          ? NetworkImage(event['image'])
                          : FileImage(File(event['image'])) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                Container(
                  height: 70,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 143, 142, 142),
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              SizedBox(width: 13),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event['name'], style: TextStyle(fontSize: 18)),
                  SizedBox(height: 4),
                  Text(event['date'], style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

}
