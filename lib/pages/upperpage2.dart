import 'package:flutter/material.dart';

class upperpage2 extends StatelessWidget {
  const upperpage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background to black
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Cable Chest Fly",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: Colors.white, // White container
            borderRadius: BorderRadius.circular(20),
          ),
          child: const SingleChildScrollView(
            child: Text(
              "• Stand in the center of the cable machine.\n"
              "• Grip handles with palms facing forward.\n"
              "• Slight bend in elbows, arms extended out to sides.\n"
              "• Bring handles together in front of chest.\n"
              "• Squeeze chest at the center, then slowly return.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }
}
