import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time = '';
  String flag;
  String url;
  bool isDaytime = true; 
  String bgImage = 'morning.jpg'; // Default background image

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Uri uri = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      http.Response response = await http.get(uri);
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      String offsetHours = data['utc_offset'].substring(0,1) == '+' ? offset : '-$offset';
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsetHours)));

      isDaytime = now.hour > 6 && now.hour < 20;

      // Determine the background image
      if (now.hour >= 5 && now.hour < 8) {
        bgImage = 'sunrise.jpg';
      } else if (now.hour >= 8 && now.hour < 17) {
        bgImage = 'morning.jpg';
      } else if (now.hour >= 17 && now.hour < 19) {
        bgImage = 'sunset.jpg';
      } else {
        bgImage = 'night.jpg';
      }

      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught error: $e');
      time = 'could not get time data';
    }
  }
}
