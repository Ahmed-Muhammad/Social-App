import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Social App',
        ),
        centerTitle: true,
        actions: const [
          //search screen icon
        ],
      ),
      body: Container(),
    );
  }
}
