import 'package:flutter/material.dart';

class lowerpage3 extends StatelessWidget {
  const lowerpage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lower Page 3"),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 141, 173, 226),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: Text(
              "",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}