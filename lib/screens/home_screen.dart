import 'package:flutter/material.dart';
import '../authentication/authentication_functions.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Logout'),
          onPressed: () => logOut(context),
        ),
      ),
    );
  }
}
