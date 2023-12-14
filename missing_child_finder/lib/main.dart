import 'dart:io';
import 'dart:ui';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:camera/camera.dart';
import './home_page.dart';
import 'statistics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(MainApp(camera: firstCamera));
}

class MainApp extends StatelessWidget {
  final CameraDescription camera;
  MainApp({required this.camera, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Missing Child Finder',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(camera: camera),
      home: HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final CameraDescription camera;
  MyHomePage({required this.camera, Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loading = false;
  CameraController? _controller;
  List _outputs = [];
  late Position _currentPosition = Position(
    latitude: 0.0,
    longitude: 0.0,
    altitude: 0.0,
    timestamp: DateTime.now(),
    heading: 0.0,
    accuracy: 0.0,
    speed: 0.0,
    headingAccuracy: 0.0,
    altitudeAccuracy: 0.0,
    speedAccuracy: 0.0
  );

  @override
  void initState() {
    super.initState();
    _loading = true;
    initCamera();
  }

  Future<void> initCamera() async {
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    await _controller!.initialize();

    if (!mounted) {
      return;
    }

    setState(() {
      _loading = false;
    });

    await loadModel();
    
    _controller!.startImageStream((CameraImage img) {
      classifyImage(img);
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  classifyImage(CameraImage img) async {
    var recognitions = await Tflite.runModelOnFrame(
      bytesList: img.planes.map((plane) => plane.bytes).toList(),
      imageHeight: img.height,
      imageWidth: img.width,
      imageMean: 127.5,
      imageStd: 127.5,
      rotation: 90, // Adjust if needed based on your camera orientation
      numResults: 2, // Number of results you want to retrieve
      threshold: 0.1, // Detection threshold
      asynch: true, // Run the detection asynchronously
    );

    setState(() {
      _loading = false;
      _outputs = recognitions ?? [];
    });
  }

  void _sendEmail(String personName) async {
    Position? currentPosition = await _getCurrentLocation();

    final Email email = Email(
      body: 'Name : ${personName}, Latitude: ${currentPosition?.latitude}, Longitude: ${currentPosition?.longitude}',
      subject: 'MISSING CHILD FINDER',
      recipients: ['atharvmandpe2@gmail.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  Future<Position?> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      print("Error getting location: $e");

      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Missing Child Finder"),
        automaticallyImplyLeading: false,
      ),
      body: _loading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _controller == null
                      ? Container()
                      : CameraPreview(_controller!),
                  SizedBox(
                    height: 20,
                  ),
                  _outputs != null && _outputs.isNotEmpty
                      ? Column(
                          children: [
                            // Text(
                            //   "${_outputs[0]["label"]}".replaceAll(RegExp(r'[0-9]'), ''),
                            //   style: TextStyle(
                            //     color: Colors.black,
                            //     fontSize: 20.0,
                            //     background: Paint()..color = Colors.white,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),

                            SizedBox(height: 10),
                            _outputs[0]["confidence"] != null &&
                                    (_outputs[0]["confidence"] as double) > 0.75
                                ? ElevatedButton(
                                    onPressed: () {
                                      String personName = "${_outputs[0]["label"]}".replaceAll(RegExp(r'[0-9]'), '');
                                      _sendEmail(personName);
                                    },
                                    child: Text('Submit'),
                                  )
                                : SizedBox.shrink(),
                          ],
                        )
                      : Text(""),
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

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}