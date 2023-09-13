import 'dart:async';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationController {
  double? latitude;
  double? longitude;
  StreamController<LocationData> _locationStreamController = StreamController<LocationData>.broadcast();

  LocationController() {
    Timer.periodic(Duration(seconds: 5), (Timer t) {
      _getLocation();
    });
  }

  Stream<LocationData> get locationStream => _locationStreamController.stream;

  dispose() {
    _locationStreamController.close();
  }

  _getLocation() async {
    final Location location = Location();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      LocationData locationData = await location.getLocation();
      double? newLatitude = locationData.latitude;
      double? newLongitude = locationData.longitude;

      await prefs.setDouble('latitude', newLatitude ?? 0.0);
      await prefs.setDouble('longitude', newLongitude ?? 0.0);

      latitude = newLatitude;
      longitude = newLongitude;

      _locationStreamController.sink.add(locationData); // Notifique os ouvintes com a nova localização
    } catch (e) {
      
    }
  }
}
