
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time = ''; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for API endpoint

  WorldTime({required this.location, required this.url, required this.flag});

  Future<void> getTime() async {
    try {
      final response = await http.get(
          Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=Europe/Berlin'));
      final data = jsonDecode(response.body);

      print('API response: $data');

      if (data['dateTime'] == null || data['utc_offset'] == null) {
        print('Missing datetime or utc_offset in response');
        time = 'Could not fetch time';
        return;
      }

      final String datetime = data['dateTime'];
      final String offset = data['utc_offset']; // e.g. "+05:30"

      DateTime now = DateTime.parse(datetime);
      final int hours = int.parse(offset.substring(1, 3));
      final int minutes = int.parse(offset.substring(4, 6));

      if (offset.startsWith('-')) {
        now = now.subtract(Duration(hours: hours, minutes: minutes));
      } else {
        now = now.add(Duration(hours: hours, minutes: minutes));
      }

      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Error fetching time: $e');
      time = 'Error occurred';
    }
  }
}

// Example instance
WorldTime instance = WorldTime(
  location: 'Berlin',
  flag: 'germany.png',
  url: 'Europe/Berlin',
);
