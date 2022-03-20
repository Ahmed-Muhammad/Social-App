import 'package:firebase_practicing/core/shared/components.dart';
import 'package:flutter/material.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
        context: context,
        title: 'New Post',
      ),
    );
  }
}
