import 'package:flutter/material.dart';

class upperpage6 extends StatelessWidget {
  const upperpage6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Dumbbell Bicep Curl", style: TextStyle(color: Colors.white)),
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
              "• Stand with dumbbells in each hand at your sides.\n"
              "• Keep palms facing forward.\n"
              "• Curl weights toward shoulders.\n"
              "• Squeeze biceps at the top.\n"
              "• Lower slowly with control.",
              style: TextStyle(color: Colors.black, fontSize: 18, height: 1.5),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }
}
