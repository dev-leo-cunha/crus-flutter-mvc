import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

getLocation() async {
  final Location location = Location();
  SharedPreferences _SharedPreferences = await SharedPreferences.getInstance();

  LocationData locationData = await location.getLocation();
  double? latitude = locationData.latitude;
  double? longitude = locationData.longitude;

  _SharedPreferences.setString('latitude', '$latitude');
  _SharedPreferences.setString('longitude', '$longitude');
}
