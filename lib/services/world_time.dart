import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time = '';
  String flag;
  String url;
  bool isDaytime = true; 
  String bgImage = 'morning.jpg'; // Keep your bgImage logic

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      http.Response response = await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0,3); // Following your reference
      
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour > 6 && now.hour < 20;
      time = DateFormat.jm().format(now);
      
      // Keep the bgImage logic
      if (now.hour >= 5 && now.hour < 8) {
        bgImage = 'sunrise.jpg';
      } else if (now.hour >= 8 && now.hour < 17) {
        bgImage = 'morning.jpg';
      } else if (now.hour >= 17 && now.hour < 19) {
        bgImage = 'sunset.jpg';
      } else {
        bgImage = 'night.jpg';
      }
      
    } catch (e) {
      print('Caught error: $e');
      time = 'could not get time data';
    }
  }
}
