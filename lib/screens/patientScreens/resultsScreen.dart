import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Result Screen'),
        ),
        body: Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg1.png"),
            fit: BoxFit.cover,
          ),
        )));
  }
}
