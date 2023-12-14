import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import './statistics.dart';
import './main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  late CameraDescription camera;
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Missing Child Finder'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Column(
          children: [
            Container(
              height: 200.0,
              child: Stack(
                children: [
                  PageView(
                    controller: _pageController,
                    children: [
                      Image.asset(
                        'assets/images/missing1.jpg',
                        fit: BoxFit.cover,
                      ),
      
                      Image.asset(
                        'assets/images/missing2.jpg',
                        fit: BoxFit.cover,
                      ),
      
                      Image.asset(
                        'assets/images/missing3.jpg',
                        fit: BoxFit.cover,
                      ),
                    ],
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Center(
                    child: Text(
                      'Uniting Hearts with Missing Child Finder',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
      
            SizedBox(height: 30),
      
            ElevatedButton(
              onPressed: () async {
                List<CameraDescription> cameras = await availableCameras();
                CameraDescription firstCamera = cameras.first;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(camera: firstCamera)),
                );
              },
              child: Text('Open Camera'),
            ),
      
            SizedBox(height: 30),
      
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Review 1',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Great Initiative!',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '⭐️⭐️⭐️⭐️⭐️',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '"Impressed by the initiative behind this app. The Missing Child Finder app takes on a crucial role in aiding the search for missing children. The UI is user-friendly, making it accessible for everyone. The integration of real-time statistics and the open camera feature adds significant value. I appreciate the effort put into creating such a meaningful and potentially life-saving application."',
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Review 2',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fulfilling a Vital Role',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '⭐️⭐️⭐️⭐️',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'The Missing Child Finder app is user-friendly and serves an important purpose. The combination of a well-designed interface, sliding photos, and easy navigation makes it a seamless experience. The open camera functionality is a unique and thoughtful addition, providing users with a practical tool.',
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      
            SizedBox(height: 40),
      
            Text(
              'HOW TO USE',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
      
            SizedBox(height: 30),
      
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Step 1: Open Camera',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        // Additional details or image for Step 1 if needed
                        SizedBox(height: 10),
            // Generalized Icon for Step 1
            Icon(
              Icons.camera_alt,
              size: 50, // Adjust the size as needed
            ),
                      ],
                    ),
                  ),
                ),
      
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Step 2: Scan Your Surroundings',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Additional details or image for Step 2 if needed
                        SizedBox(height: 10),
            // Generalized Icon for Step 2
            Icon(
              Icons.search,
              size: 50, // Adjust the size as needed
            ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      
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
        selectedItemColor: Colors.blue,
        currentIndex: 1,
        onTap: (index) async {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StatisticsPage()),
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
      
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
      ),
    );
  }
}
