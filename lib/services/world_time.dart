import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time = ''; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for API endpoint
  bool isDayTime= true; // rue or false if daytime or not

  WorldTime({required this.location, required this.url, required this.flag});

  Future<void> getTime() async {
    try {
      final response = await http.get(
        Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=$url'),
      );
      final data = jsonDecode(response.body);

      print('API response: $data');

      if (data['dateTime'] == null) {
        print('Missing dateTime in response');
        time = 'Could not fetch time';
        return;
      }

      // Parse the dateTime string from API
      DateTime apiTime = DateTime.parse(data['dateTime']);

      // Format it however you like — here's HH:mm (24-hour) and h:mm a (12-hour)
      isDayTime = apiTime.hour > 6 && apiTime.hour < 12 ? true : false;
      time = DateFormat('h:mm a').format(apiTime); // e.g., "8:06 AM"
      // Or: time = DateFormat('HH:mm').format(apiTime); // e.g., "08:06"

    } catch (e) {
      print('Error fetching time: $e');
      time = 'Error occurred';
    }
  }
}
WorldTime instance = WorldTime(location: 'Berlin', url: 'Europe/berlin', flag:'germany.png' );