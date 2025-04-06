import 'package:flutter/material.dart';

class lowerpage5 extends StatelessWidget {
  const lowerpage5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Lunges", style: TextStyle(color: Colors.white)),
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
              "• Stand upright with feet together.\n"
              "• Step forward with one leg and lower until knees form 90° angles.\n"
              "• Keep front knee above ankle.\n"
              "• Push back to starting position.\n"
              "• Alternate legs each rep.",
              style: TextStyle(color: Colors.black, fontSize: 18, height: 1.5),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }
}
