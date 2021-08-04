import 'package:flutter/material.dart';
import 'main_menu.dart';

void main() {
  runApp(NexusOmega());
}

class NexusOmega extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts',
      theme: ThemeData(
        primaryColor: Colors.black,
        primarySwatch: Colors.grey,
        fontFamily: 'LexendDeca',
      ),
      home: MainMenu(),
    );
  }
}
