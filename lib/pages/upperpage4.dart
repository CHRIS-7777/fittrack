import 'package:flutter/material.dart';

class upperpage4 extends StatelessWidget {
  const upperpage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Seated Chest Press", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const SingleChildScrollView(
            child: Text(
              "• Sit on the machine and adjust handles to chest level.\n"
              "• Grip handles firmly.\n"
              "• Press forward until arms are extended.\n"
              "• Return slowly to start position.\n"
              "• Focus on squeezing chest muscles.",
              style: TextStyle(color: Colors.black, fontSize: 18, height: 1.5),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }
}
