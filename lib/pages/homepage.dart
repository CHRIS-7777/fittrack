import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

class Homee extends StatefulWidget {
  const Homee({super.key});

  @override
  _HomeeState createState() => _HomeeState();
}

class _HomeeState extends State<Homee> {
  int _streakDays = 1;
  double _calories = 0.0;
  Timer? _dayCheckTimer;

  @override
  void initState() {
    super.initState();
    _initializeCalories();
    _loadStats();
    _checkAndUpdateStreak();
    _startDayChangeChecker();
  }

  void _startDayChangeChecker() {
    _dayCheckTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkAndUpdateStreak();
    });
  }

  Future<void> _initializeCalories() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('calories')) {
      await prefs.setDouble('calories', 0);
    }
  }

  Future<void> _checkAndUpdateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final String? lastDateStr = prefs.getString('last_active_date');
    final int savedStreak = prefs.getInt('streak_days') ?? 0;

    DateTime now = DateTime.now();

    if (lastDateStr == null) {
      _streakDays = 1;
      await prefs.setInt('streak_days', _streakDays);
      await prefs.setString('last_active_date', now.toIso8601String());
    } else {
      DateTime lastDate = DateTime.parse(lastDateStr);
      if (now.year != lastDate.year || now.month != lastDate.month || now.day != lastDate.day) {
        _streakDays = savedStreak + 1;
        await prefs.setInt('streak_days', _streakDays);
        await prefs.setString('last_active_date', now.toIso8601String());
      } else {
        _streakDays = savedStreak;
      }
    }

    setState(() {});
  }

  Future<void> _loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _calories = prefs.getDouble('calories') ?? 0;
    });
  }

  Future<void> _saveTodayData() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final String today = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    double gained = prefs.getDouble('calories_gained') ?? 0;
    double burned = prefs.getDouble('calories_burned') ?? 0;

    String? dataJson = prefs.getString('daily_log');
    Map<String, dynamic> dataMap = dataJson != null ? jsonDecode(dataJson) : {};

    dataMap[today] = {
      "gained": gained,
      "burned": burned,
    };

    await prefs.setString('daily_log', jsonEncode(dataMap));

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Saved: $gained cal gained, $burned cal burned on $today"),
      backgroundColor: Colors.green,
    ));
  }

  @override
  void dispose() {
    _dayCheckTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            const Icon(Icons.account_circle, size: 30, color: Colors.white),
            const SizedBox(width: 5),
            const Expanded(
              child: Text(
                "Chris",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.table_chart, color: Colors.white),
              tooltip: "Check Logs",
              onPressed: () {
                Navigator.pushNamed(context, '/dataPage');
              },
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 4, offset: const Offset(2, 2))
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.local_fire_department, color: Colors.orange, size: 24),
                  const SizedBox(width: 5),
                  Text(
                    "$_streakDays",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
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
              child: const Text('Menu', style: TextStyle(fontSize: 24, color: Colors.white)),
            ),
            _buildDrawerTile(Icons.home, "Home", "/home"),
            _buildDrawerTile(Icons.settings, "Settings", "/home"),
            _buildDrawerTile(Icons.info, "About", "/home"),
            _buildDrawerTile(Icons.logout, "Logout", "/splashscreen"),
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
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatCard("Calories Gained", "${_calories.toStringAsFixed(1)} cal🔥", Colors.white, screenWidth),
                  ],
                ),
                SizedBox(height: size.height * 0.06),
                _buildOptionButton(context, "Choose a food", Icons.fastfood, Colors.orange, '/foodpage', screenWidth),
                SizedBox(height: size.height * 0.02),
                _buildOptionButton(context, "Choose a workout", Icons.fitness_center, Colors.orange, '/workoutPage', screenWidth),
                SizedBox(height: size.height * 0.02),
                _buildOptionButton(context, "Get to be Trained?", Icons.sports_gymnastics_rounded, Colors.orange, '/tutorialPage', screenWidth),
                SizedBox(height: size.height * 0.02),
                _buildOptionButton(context, "Other Information", Icons.info_outline, Colors.orange, '/trainingPage', screenWidth),
                SizedBox(height: size.height * 0.02),
                ElevatedButton.icon(
                  onPressed: _saveTodayData,
                  icon: const Icon(Icons.save),
                  label: const Text("Save Today's Data"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerTile(IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  Widget _buildStatCard(String title, String value, Color color, double screenWidth) {
    return Container(
      width: screenWidth * 0.6,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, String text, IconData icon, Color color, String route, double screenWidth) {
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(context, route);
        await _loadStats();
      },
      child: Container(
        width: screenWidth * 0.9,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 10),
            Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
