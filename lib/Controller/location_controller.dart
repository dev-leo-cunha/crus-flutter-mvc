import 'package:location/location.dart';

Future<LocationData> getLocation() async {
  final Location location = Location();
  LocationData currentLocation;
  try {
    currentLocation = await location.getLocation();
  } catch (e) {
    rethrow;
  }

  if (currentLocation != null) {
    return currentLocation;
  } else {
    throw 'Erro ao obter localização';
  }
}
