import 'package:flutter/material.dart';
import 'main_menu.dart';

void main() {
  runApp(const NexusOmega());
}

class NexusOmega extends StatelessWidget {
  const NexusOmega({Key? key}) : super(key: key);

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
      home: const MainMenu(),
    );
  }
}
