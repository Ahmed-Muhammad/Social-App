import 'package:flutter/material.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

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
