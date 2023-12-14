import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import './home_page.dart';
import 'main.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int _rescuedChildren = 1;
  int _successfulSearches = 1;
  int _totalActiveSearches = 1;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    const duration = Duration(milliseconds: 2);
    Timer.periodic(duration, (Timer timer) {
      if (_rescuedChildren < 123) {
        setState(() {
          _rescuedChildren++;
        });
      }
      if (_successfulSearches < 456) {
        setState(() {
          _successfulSearches++;
        });
      }
      if (_totalActiveSearches < 789) {
        setState(() {
          _totalActiveSearches++;
        });
      }

      // Stop the timer when the values reach their final numbers
      if (_rescuedChildren == 123 && _successfulSearches == 456 && _totalActiveSearches == 789) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Missing Child Finder'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Number of Rescued Children:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '$_rescuedChildren',
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Number of Successful Searches:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '$_successfulSearches',
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Total Active Searches:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '$_totalActiveSearches',
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Open Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Statistics',
          ),
        ],
        selectedItemColor: Colors.blue, // Highlighted color
        currentIndex: 2, // Set the index of the highlighted button
        onTap: (index) async {
          if (index == 2) {
            // If the Statistics button is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StatisticsPage()),
            );
          }

          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }

          if (index == 1) {
            List<CameraDescription> cameras = await availableCameras();

            if (cameras.isNotEmpty) {
              CameraDescription firstCamera = cameras.first;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage(camera: firstCamera)),
              );
            } else {
              print("No cameras available");
            }
          }
        },
      ),
    );
  }
}
