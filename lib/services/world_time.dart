import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  late String time;
  String flag; 
  String url; 

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

      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught error: $e');
      time = 'could not get time data';
    }
  }
}
