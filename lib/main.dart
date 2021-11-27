import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './authentication/check_logged_in.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckLoggedIn(),
    );
  }
}
