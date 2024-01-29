import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

Future<String> getCurrentLocation() async {
  String locationInfo = '';

  try {
    // Specify high accuracy options for location request
    LocationAccuracy desiredAccuracy = LocationAccuracy.bestForNavigation;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: desiredAccuracy,
    );

    // print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');

    // Reverse geocoding to get location information including landmarks
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark? place = placemarks.isNotEmpty ? placemarks[0] : null;

    if (place != null) {
      // Build a string with location information
      locationInfo = "${place.name}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
    } else {
      locationInfo = 'Location information not found';
    }
  } catch (e) {
    // print('Error getting current location: $e');
    locationInfo = 'Error!!';
  }

  return locationInfo;
}
