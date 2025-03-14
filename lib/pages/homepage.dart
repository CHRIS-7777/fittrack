import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Homee extends StatefulWidget {
  const Homee({super.key});

  @override
  _HomeeState createState() => _HomeeState();
}

class _HomeeState extends State<Homee> {
  int _streakDays = 10;

  @override
  void initState() {
    super.initState();
    _loadStreak();
  }

  Future<void> _loadStreak() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String lastDate = prefs.getString('last_active_date') ?? "";
    final int savedStreak = prefs.getInt('streak_days') ?? 1;

    DateTime now = DateTime.now();
    DateTime lastActive = lastDate.isNotEmpty ? DateTime.parse(lastDate) : now;

    if (now.difference(lastActive).inDays == 1) {
      _streakDays = savedStreak + 1;
    } else if (now.difference(lastActive).inDays > 1) {
      _streakDays = 1;
    } else {
      _streakDays = savedStreak;
    }

    await prefs.setInt('streak_days', _streakDays);
    await prefs.setString('last_active_date', now.toIso8601String());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.account_circle, size: 40, color: Colors.white),
                SizedBox(width: 3),
                Text(
                  "USER",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 4, offset: Offset(2, 2))
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.local_fire_department, color: Colors.orange, size: 30),
                  SizedBox(width: 5),
                  Text("$_streakDays", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey[900]),
              child: Text('Menu', style: TextStyle(fontSize: 24, color: Colors.white)),
            ),
            ListTile(leading: Icon(Icons.home, color: Colors.white), title: Text("Home", style: TextStyle(color: Colors.white)), onTap: () {}),
            ListTile(leading: Icon(Icons.settings, color: Colors.white), title: Text("Settings", style: TextStyle(color: Colors.white)), onTap: () {}),
            ListTile(leading: Icon(Icons.info, color: Colors.white), title: Text("About", style: TextStyle(color: Colors.white)), onTap: () {}),
            ListTile(leading: Icon(Icons.logout, color: Colors.white), title: Text("Logout", style: TextStyle(color: Colors.white)), onTap: () {}),
          ],
        ),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 1,
            child: Image.asset(
              "assets/gymboy.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatCard("Calories", "79.9%", Colors.white),
                    _buildStatCard("Proteins", "83.8%", Colors.white),
                  ],
                ),
                SizedBox(height: 80),
                _buildOptionButton(context, "Choose a food", Icons.fastfood, Colors.orange, '/foodPage'),
                SizedBox(height: 20),
                _buildOptionButton(context, "Choose a workout", Icons.fitness_center, Colors.orange, '/workoutPage'),
                SizedBox(height: 20),
                _buildOptionButton(context, "Get to be Trained?", Icons.sports_gymnastics_rounded, Colors.orange, '/tutorialPage'),
                SizedBox(height: 20),
                _buildOptionButton(context, "Other Information", Icons.info_outline, Colors.orange, '/trainingPage'),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
Widget _buildOptionButton(BuildContext context, String text, IconData icon, Color color, String route) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, route);
    },
    child: Container(
      width: 310,
      height: 100,
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: color),
          SizedBox(height: 10),
          Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

Widget _buildStatCard(String title, String value, Color color) {
  return Container(
    width: 150,
    height: 100,
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.5),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2))],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        SizedBox(height: 10),
        Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
      ],
    ),
  );
}
