// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

// class MapScreen extends StatefulWidget {
//   final Function(LatLng) onLocationSelected;

//   const MapScreen({Key? key, required this.onLocationSelected}) : super(key: key);

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController _mapController;
//   LatLng? _currentLocation;
//   final Set<Marker> _markers = {};

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Handle the case where location services are not enabled
//       return;
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
//         // Handle the case where permission is denied
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Handle the case where permission is permanently denied
//       return;
//     }

//     final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       _currentLocation = LatLng(position.latitude, position.longitude);
//       _markers.add(
//         Marker(
//           markerId: MarkerId('current_location'),
//           position: _currentLocation!,
//           infoWindow: InfoWindow(title: 'You are here'),
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor. hueRed),
//         ),
//       );
//     });

//     _mapController.animateCamera(
//       CameraUpdate.newLatLngZoom(_currentLocation!, 15),
//     );
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;
//   }

//   void _onTap(LatLng location) async {
//     // Handle business search here
//     final businesses = await _fetchBusinessesAtLocation(location);
//     if (businesses.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("No businesses found at this location.")),
//       );
//     } else {
//       widget.onLocationSelected(location);
//       Navigator.pop(context);
//     }
//   }

//   Future<List<dynamic>> _fetchBusinessesAtLocation(LatLng location) async {
//     // Replace with your own implementation to fetch businesses
//     // For now, just return an empty list to simulate no businesses found
//     return [];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Select Location"),
//         backgroundColor: Colors.blue,
//       ),
//       body: _currentLocation == null
//           ? Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: _currentLocation!,
//                 zoom: 15,
//               ),
//               markers: _markers,
//               onTap: _onTap,
//             ),
//     );
//   }
// }



// import 'package:abrin_app_new/Search/Service.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
//  // Update the import path as needed

// class MapScreen extends StatefulWidget {
//   final Function(LatLng) onLocationSelected;

//   const MapScreen({Key? key, required this.onLocationSelected}) : super(key: key);

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController _mapController;
//   LatLng? _currentLocation;
//   final Set<Marker> _markers = {};

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return;
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return;
//     }

//     final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       _currentLocation = LatLng(position.latitude, position.longitude);
//       _markers.add(
//         Marker(
//           markerId: MarkerId('current_location'),
//           position: _currentLocation!,
//           infoWindow: InfoWindow(title: 'You are here'),
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//         ),
//       );
//     });

//     _mapController.animateCamera(
//       CameraUpdate.newLatLngZoom(_currentLocation!, 15),
//     );
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;
//   }
//   void _onTap(LatLng location) async {
//   // Get the address from the location
//   List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
//   Placemark place = placemarks.first;

//   String city = place.locality ?? '';
  
//   // Fetch business events and check if any event matches the city
//   final businessService = BusinessServicesearch();
//   final businesses = await businessService.fetchBusinesses();
//   final matchingEvents = businesses.where((event) => event.location.toLowerCase().contains(city.toLowerCase())).toList();

//   if (matchingEvents.isNotEmpty) {
//     // Pass matching events back to the previous screen
//     Navigator.pop(context, matchingEvents);
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("No businesses found in $city.")),
//     );
//   }
// }

//   // void _onTap(LatLng location) async {
//   //   // Get the address from the location
//   //   List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
//   //   Placemark place = placemarks.first;

//   //   String city = place.locality ?? '';
//   //   print("::: the ccity we selected is :$city");
//   //   String address = "${place.name ?? ''} ${place.subLocality ?? ''} ${place.subAdministrativeArea ?? ''} ${place.postalCode ?? ''}";
    
//   //   // Fetch business events and check if any event matches the city
//   //   final businessService = BusinessServicesearch();
//   //   final businesses = await businessService.fetchBusinesses();
//   //   final matchingEvents = businesses.where((event) => event.location.toLowerCase().contains(city.toLowerCase())).toList();
//   // print("::: The matching events are: ${matchingEvents.map((event) => 'Name: ${event.name}, Location: ${event.location}').join(', ')}");
//   //   if (matchingEvents.isNotEmpty) {
//   //     widget.onLocationSelected(location);
//   //     Navigator.pop(context);
//   //   } else {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text("No businesses found in $city.")),
//   //     );
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Select Location"),
//         backgroundColor: Colors.blue,
//       ),
//       body: _currentLocation == null
//           ? Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: _currentLocation!,
//                 zoom: 15,
//               ),
//               markers: _markers,
//               onTap: _onTap,
//             ),
//     );
//   }
// }



import 'package:abrin_app_new/Search/Service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  final Function(List<Business>) onEventsFound;

  const MapScreen({Key? key, required this.onEventsFound}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  LatLng? _currentLocation;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          markerId: MarkerId('current_location'),
          position: _currentLocation!,
          infoWindow: InfoWindow(title: 'You are here'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });

    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(_currentLocation!, 15),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onTap(LatLng location) async {
    // Get the address from the location
    List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
    Placemark place = placemarks.first;

    String city = place.locality ?? '';
    
    // Fetch business events and check if any event matches the city
    final businessService = BusinessServicesearch();
    final businesses = await businessService.fetchBusinesses();
    final matchingEvents = businesses.where((event) => event.location.toLowerCase().contains(city.toLowerCase())).toList();

    if (matchingEvents.isNotEmpty) {
      // Pass matching events back to the previous screen
      widget.onEventsFound(matchingEvents);
      Navigator.pop(context); // Pop back to previous screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No businesses found in $city.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
        backgroundColor: Colors.blue,
      ),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentLocation!,
                zoom: 15,
              ),
              markers: _markers,
              onTap: _onTap,
            ),
    );
  }
}
