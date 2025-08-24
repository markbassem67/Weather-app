import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';

Future<String> getCityAndCountry(double lat, double lon) async {
  final placemarks = await placemarkFromCoordinates(lat, lon);
  if (placemarks.isNotEmpty) {
    final place = placemarks.first;
    final locality = place.locality ?? place.subLocality ?? "Unknown";
    final country = place.country ?? "Unknown";
    return "$locality, $country";
  }
  return "Unknown location";
}

void main() {
  test('Get city and country from coordinates', () async {
    final result = await getCityAndCountry(40.7128, -74.0060); // New York
    print(result);
    expect(result.contains("United States"), true);
  });
}
