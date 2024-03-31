import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;

    String bgImage = 'day/' + data['bgImage']; 
    Color bgColor = data['isDaytime'] ? Colors.blue : (Colors.indigo[700] ?? Colors.indigo);

    // Determine the text color based on the background image
    Color textColor;
    switch (bgImage) {
      case 'morning.jpg':
        textColor = Colors.black87; 
        break;
      case 'sunrise.jpg':
        textColor = Colors.black87; 
        break;
      case 'sunset.jpg':
        textColor = Colors.white; 
        break;
      case 'night.jpg':
        textColor = Colors.white; 
        break;
      default:
        textColor = Colors.black87; 
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/location');
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: textColor, 
                  ),
                  label: Text(
                    'Edit Location',
                    style: GoogleFonts.poppins(
                      color: textColor, 
                      fontSize: 16.0, 
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: textColor,
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: GoogleFonts.poppins(
                        color: textColor, 
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: GoogleFonts.poppins(
                    color: textColor, 
                    fontSize: 66.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
