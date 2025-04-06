import 'package:flutter/material.dart';

class lowerpage6 extends StatelessWidget {
  const lowerpage6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Seated Leg Curl", style: TextStyle(color: Colors.white)),
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
              "• Sit on the leg curl machine and place feet under pad.\n"
              "• Adjust pad to rest just above heels.\n"
              "• Curl legs by bending knees fully.\n"
              "• Hold briefly at the top.\n"
              "• Return slowly to start position.",
              style: TextStyle(color: Colors.black, fontSize: 18, height: 1.5),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }
}
