import 'package:flutter/material.dart';

class upperpage1 extends StatelessWidget {
  const upperpage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background to black
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Chest Press",
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
              "• Sit with back flat against the pad.\n"
              "• Grip handles at chest level.\n"
              "• Push handles forward until arms are extended.\n"
              "• Slowly return to start position.\n"
              "• Keep movements controlled and elbows slightly bent at top.",
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
