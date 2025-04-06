import 'package:flutter/material.dart';
class lowerpage2 extends StatelessWidget {
  const lowerpage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Leg Press", style: TextStyle(color: Colors.white)),
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
              "• Sit on the machine and place feet on platform.\n"
              "• Lower platform slowly toward chest.\n"
              "• Stop when knees are 90°.\n"
              "• Push back to start without locking knees.\n"
              "• Keep back flat and hips down.",
              style: TextStyle(color: Colors.black, fontSize: 18, height: 1.5),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }
}
