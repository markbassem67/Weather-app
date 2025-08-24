import 'package:geocoding/geocoding.dart';

class ReverseGeocodingService {
  Future<String> getCityAndCountry(double lat, double lon) async {
    final placemarks = await placemarkFromCoordinates(lat, lon);
    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      final locality = place.locality ?? place.subLocality ?? "Unknown";
      final country = place.country ?? "Unknown";
      return " $locality, $country";
    }
    return "Unknown location";
  }
}
