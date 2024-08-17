



// import 'package:abrin_app_new/Search/Service.dart';
// import 'package:abrin_app_new/Search/localBusinesscategory.dart';
// import 'package:abrin_app_new/Search/localBusinnesCategores.dart';
// import 'package:abrin_app_new/Search/map_screen.dart';
// import 'package:abrin_app_new/Search/provider.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';

// class Searchbusiness extends StatefulWidget {
//   const Searchbusiness({super.key});

//   @override
//   State<Searchbusiness> createState() => _SearchbusinessState();
// }

// class _SearchbusinessState extends State<Searchbusiness> {
//   final TextEditingController _controller = TextEditingController();
//   List<LocalBusinessCategory> _searchResults = [];
//   List<LocalBusinessCategory> _locationResults = [];
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchAllBusinesses();
//   }

//   Future<void> _fetchAllBusinesses() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final businesses = await BusinessServicesearch().fetchBusinesses();
//       if (!mounted) return; 
//       setState(() {
//         _allitems = businesses
//             .map((business) => LocalBusinessCategory(
//                   businessName: business.name,
//                   imagePath:
//                       business.coverPicture ?? 'assets/images/default.png',
//                   category: business.category,
//                   location: business.location,
//                   rating: business.rating,
//                 ))
//             .toList();
//       });
//     } catch (e) {
//       print('Error fetching businesses: $e');
//     } 
//     finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   List<LocalBusinessCategory> _allitems = [];

//   void _performSearch(String query) {
//     if (query.isEmpty) {
//       setState(() {
//         _searchResults = [];
//       });
//       return;
//     }
//     setState(() {
//       _searchResults = _allitems
//           .where((item) =>
//               item.businessName.toLowerCase().contains(query.toLowerCase()) ||
//               item.category.toLowerCase().contains(query.toLowerCase()) ||
//               item.location.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   Future<void> _performLocationSearch(double lat, double lng) async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final businesses =
//           await BusinessServicesearch().searchBusinesses(lat: lat, lng: lng);
//           if (!mounted) return; 
//       setState(() {
//         _locationResults = businesses
//             .map((business) => LocalBusinessCategory(
//                   businessName: business.name,
//                   imagePath:
//                       business.coverPicture ?? 'assets/images/default.png',
//                   category: business.category,
//                   location: business.location,
//                   rating: business.rating,
//                 ))
//             .toList();
//       });
//     } catch (e) {
//       print('Error fetching businesses: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _fetchCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     final position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     _performLocationSearch(position.latitude, position.longitude);
//   }


 
//   void _navigateToMapScreen() async {
//     List<Businessclass>? selectedEvents = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => MapScreen(
//           onEventsFound: (events) {
//             if (!mounted) return; 
//             // Handle the events found in the map screen
//             setState(() {
//               _locationResults = events.map((event) => LocalBusinessCategory(
//                 businessName: event.name,
//                 imagePath: event.coverPicture ?? 'assets/images/default.png',
//                 category: event.category,
//                 location: event.location,
//                 rating: event.rating,
//               )).toList();
//             });
//           },
//         ),
//       ),
//     );
//  // Optionally, handle the selected events if needed
//     if (selectedEvents != null && selectedEvents.isNotEmpty) {
//       if (!mounted) return; 
//       setState(() {
//         _locationResults = selectedEvents.map((event) => LocalBusinessCategory(
//           businessName: event.name,
//           imagePath: event.coverPicture ?? 'assets/images/default.png',
//           category: event.category,
//           location: event.location,
//           rating: event.rating,
//         )).toList();
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     final locationProvider = Provider.of<LocationProvider>(context);

//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           color: Colors.white,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.all(15.0),
//                 child: Text(
//                   "Trouvez tout ce dont vous avez besoin",
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.blue),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       height: 45,
//                       width: MediaQuery.of(context).size.width - 75,
//                       child: TextFormField(
//                         controller: _controller,
//                         onChanged: (value) {
//                           _performSearch(value);
//                         },
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                             borderSide:
//                                 const BorderSide(color: Colors.blue, width: 2),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                             borderSide:
//                                 const BorderSide(color: Colors.blue, width: 2),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                             borderSide: const BorderSide(color: Colors.blue),
//                           ),
//                           prefixIcon: Icon(
//                             Icons.search_rounded,
//                             color: Colors.blue,
//                           ),
//                           hintStyle: const TextStyle(
//                             fontWeight: FontWeight.w500,
//                             color: Color.fromARGB(255, 121, 120, 120),
//                             fontSize: 13,
//                             fontFamily: "Montserrat",
//                           ),
//                           hintText: "Rechercher une entreprise ou des services",
//                           filled: true,
//                           fillColor: Colors.white,
//                           errorStyle: const TextStyle(
//                             height: 0.07,
//                             color: Colors.red,
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         if (locationProvider.isLocationBasedSearch) {
//                           locationProvider.clearLocation();
//                           setState(() {
//                             _locationResults = [];
//                           });
//                         } else {
//                           locationProvider.enableLocationBasedSearch();
//                           _fetchCurrentLocation();
//                         }
//                       _navigateToMapScreen();
//                       },
//                       color: Colors.blue,
//                       icon: Icon(
//                         locationProvider.isLocationBasedSearch
//                             ? Icons.clear
//                             : Icons.location_on_sharp,
//                         color: Colors.blue,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               _isLoading
//                   ? Center(child: CircularProgressIndicator())
//                   : Expanded(
//                     child: SizedBox(
//                       height: MediaQuery.of(context).size.height,
//                       child: ListView.builder(
//                         reverse: false,
//                         shrinkWrap: true,
//                         itemCount: _controller.text.isEmpty
//                             ? (locationProvider.isLocationBasedSearch
//                                 ? _locationResults.length
//                                 : _allitems.length)
//                             : _searchResults.length,
//                         itemBuilder: (context, index) {
//                           var item = _controller.text.isEmpty
//                               ? (locationProvider.isLocationBasedSearch
//                                   ? _locationResults[index]
//                                   : _allitems[index])
//                               : _searchResults[index];
//                           return Localbusinnescategores(
//                             businescategory: item,
//                             latLng: LatLng(28.3901, 70.3300),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//             ],
//           ),
//         ),
//         floatingActionButton: Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             height: 35,
//             width: 160,
//             child: FloatingActionButton(
//               onPressed: () {
//                 locationProvider.enableLocationBasedSearch();
//                 _fetchCurrentLocation();
//                 _navigateToMapScreen();
//               },
//               backgroundColor: Colors.blue,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: Text(
//                 "Voir sur la carte",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       ),
//     );
//   }
// }





import 'package:abrin_app_new/Bussinesses/bussinessModel.dart';
import 'package:abrin_app_new/Home/business/businessDataHandler.dart';
import 'package:abrin_app_new/Search/Service.dart';
import 'package:abrin_app_new/Search/localBusinesscategory.dart';
import 'package:abrin_app_new/Search/localBusinnesCategores.dart';
import 'package:abrin_app_new/Search/map_screen.dart';
import 'package:abrin_app_new/Search/provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Searchbusiness extends StatefulWidget {
  const Searchbusiness({super.key});

  @override
  State<Searchbusiness> createState() => _SearchbusinessState();
}

class _SearchbusinessState extends State<Searchbusiness> {
  final TextEditingController _controller = TextEditingController();
  List<Business> _searchResults = [];
  List<Business> _locationResults = [];
  List<Business> _allitems = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchAllBusinesses();
  }

  Future<void> _fetchAllBusinesses() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final businesses = await BusinessService().fetchBusinesses();
      if (!mounted) return; 
      setState(() {
        _allitems = businesses;
      });
    } catch (e) {
      print('Error fetching businesses: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }
    setState(() {
      _searchResults = _allitems
          .where((item) =>
              item.name.toLowerCase().contains(query.toLowerCase()) ||
              item.category.toLowerCase().contains(query.toLowerCase()) ||
              item.location.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // Future<void> _performLocationSearch(double lat, double lng) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   try {
  //     final businesses = await BusinessServicesearch().searchBusinesses(lat: lat, lng: lng);
  //     if (!mounted) return; 
  //     setState(() {
  //       _locationResults = businesses;
  //     });
  //   } catch (e) {
  //     print('Error fetching businesses: $e');
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  // Future<void> _fetchCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   final position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   _performLocationSearch(position.latitude, position.longitude);
  // }

  // void _navigateToMapScreen() async {
  //   List<Business>? selectedEvents = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => MapScreen(
  //         onEventsFound: (events) {
  //           if (!mounted) return; 
  //           setState(() {
  //             _locationResults = events;
  //           });
  //         },
  //       ),
  //     ),
  //   );
  //   if (selectedEvents != null && selectedEvents.isNotEmpty) {
  //     if (!mounted) return; 
  //     setState(() {
  //       _locationResults = selectedEvents;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Trouvez tout ce dont vous avez besoin",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width - 75,
                      child: TextFormField(
                        controller: _controller,
                        onChanged: (value) {
                          _performSearch(value);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.blue, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.blue, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: Colors.blue,
                          ),
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 121, 120, 120),
                            fontSize: 13,
                            fontFamily: "Montserrat",
                          ),
                          hintText: "Rechercher une entreprise ou des services",
                          filled: true,
                          fillColor: Colors.white,
                          errorStyle: const TextStyle(
                            height: 0.07,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     if (locationProvider.isLocationBasedSearch) {
                    //       locationProvider.clearLocation();
                    //       setState(() {
                    //         _locationResults = [];
                    //       });
                    //     } else {
                    //       locationProvider.enableLocationBasedSearch();
                    //       _fetchCurrentLocation();
                    //     }
                    //     _navigateToMapScreen();
                    //   },
                    //   color: Colors.blue,
                    //   icon: Icon(
                    //     locationProvider.isLocationBasedSearch
                    //         ? Icons.clear
                    //         : Icons.location_on_sharp,
                    //     color: Colors.blue,
                    //   ),
                    // ),
                  ],
                ),
              ),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _controller.text.isEmpty
                            ? (locationProvider.isLocationBasedSearch
                                ? _locationResults.length
                                : _allitems.length)
                            : _searchResults.length,
                        itemBuilder: (context, index) {
                          Business item = _controller.text.isEmpty
                              ? (locationProvider.isLocationBasedSearch
                                  ? _locationResults[index]
                                  : _allitems[index])
                              : _searchResults[index];
                          return Localbusinnescategores(
                            businescategory: item,
                            // latLng: LatLng(28.3901, 70.3300),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      //   floatingActionButton: Align(
      //     alignment: Alignment.bottomCenter,
      //     child: Container(
      //       height: 35,
      //       width: 160,
      //       child: FloatingActionButton(
      //         onPressed: () {
      //           locationProvider.enableLocationBasedSearch();
      //           _fetchCurrentLocation();
      //           _navigateToMapScreen();
      //         },
      //         backgroundColor: Colors.blue,
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(30),
      //         ),
      //         child: Text(
      //           "Voir sur la carte",
      //           style: TextStyle(
      //             fontSize: 16,
      //             color: Colors.white,
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
