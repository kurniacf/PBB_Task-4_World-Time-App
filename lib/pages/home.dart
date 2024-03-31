import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>? ?? {};

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
          child: Column(
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/location').then((result) {
                    if (result != null) {
                      setState(() {
                        data = result as Map<dynamic, dynamic>;
                      });
                    }
                  });
                },
                icon: Icon(Icons.edit_location),
                label: Text('Edit Location'),
                style: TextButton.styleFrom(foregroundColor: Colors.black),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'] ?? 'Location',
                    style: TextStyle(
                      fontSize: 28.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                data['time'] ?? 'Time',
                style: TextStyle(
                  fontSize: 66.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
