class HoursParser {
  final String targetString = 'T';


  List<String> parseHours(List<String> hours) {
    return hours.map((h) => h.split('T')[1]).toList();
  }
}
