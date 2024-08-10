
import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  bool isLocationBasedSearch = false;
  double? selectedLatitude;
  double? selectedLongitude;

  void setLocation(double lat, double lng) {
    selectedLatitude = lat;
    selectedLongitude = lng;
    isLocationBasedSearch = true;
    notifyListeners();
  }

  void clearLocation() {
    selectedLatitude = null;
    selectedLongitude = null;
    isLocationBasedSearch = false;
    notifyListeners();
  }

  void enableLocationBasedSearch() {
    isLocationBasedSearch = true;
    notifyListeners();
  }
}
