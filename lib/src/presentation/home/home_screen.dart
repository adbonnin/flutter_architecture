import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _onButtonPressed,
          child: Text("Increment $count"),
        ),
      ),
    );
  }

  void _onButtonPressed() {
    setState(() {
      count++;
    });
  }
}
