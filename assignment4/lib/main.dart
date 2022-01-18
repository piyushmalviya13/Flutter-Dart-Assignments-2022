import 'package:assignment4/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PermissionStatus? contactPermission;

  @override
  void initState() {
    super.initState();
    askContactPermission();
  }

  void askContactPermission() async {
    var status = await Permission.contacts.request();
    setState(() {
      contactPermission = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: contactPermission == PermissionStatus.granted
          ? const HomeScreen()
          : contactPermission == PermissionStatus.denied
              ? const PermissionDeniedScreen()
              : const Scaffold(),
    );
  }
}

//change name to widget
//shift text to const widget.
class PermissionDeniedScreen extends StatelessWidget {
  const PermissionDeniedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
                padding: EdgeInsets.all(40.0),
                child: Text(
                    'Please provide contact access. Press the button below to open settings.')),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Contact Permission'),
                          content: const Text(
                              'Please open settings and provide contacts access'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Deny'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: const Text('Open Settings'),
                              onPressed: () => openAppSettings(),
                            ),
                          ],
                        ));
              },
              child: const Text('Open Settings'),
            )
          ],
        ),
      ),
    );
  }
}
