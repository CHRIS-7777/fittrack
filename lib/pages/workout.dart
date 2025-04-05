import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  String _selectedWorkout = 'Running';
  int _duration = 30;

  final List<String> workouts = ['Running', 'Cycling', 'Yoga', 'Weight Lifting'];

  int calculateCalories(String workout, int duration) {
    Map<String, double> rates = {
      'Running': 10.0,
      'Cycling': 8.0,
      'Yoga': 4.0,
      'Weight Lifting': 6.0,
    };
    double rate = rates[workout] ?? 5.0;
    return (rate * duration).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Workout Selection"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose Workout",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButtonFormField<String>(
                dropdownColor: Colors.grey[900],
                value: _selectedWorkout,
                decoration: const InputDecoration(border: InputBorder.none),
                style: const TextStyle(color: Colors.white),
                items: workouts.map((String workout) {
                  return DropdownMenuItem<String>(
                    value: workout,
                    child: Text(workout),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedWorkout = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Duration (minutes)",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: "Enter duration",
                hintStyle: const TextStyle(color: Colors.white54),
              ),
              keyboardType: TextInputType.number,
              initialValue: _duration.toString(),
              onChanged: (val) {
                _duration = int.tryParse(val) ?? 30;
              },
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  int burned = calculateCalories(_selectedWorkout, _duration);
                  final prefs = await SharedPreferences.getInstance();
                  double currentCalories = prefs.getDouble('calories') ?? 1000.0;
                  double updatedCalories = currentCalories - burned;
                  updatedCalories = updatedCalories.clamp(0.0, 10000.0);
                  await prefs.setDouble('calories', updatedCalories);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("You burned $burned cal! Remaining: ${updatedCalories.toStringAsFixed(1)}"),
                      duration: const Duration(seconds: 5),
                      backgroundColor: Colors.green[600],
                    ),
                  );

                  Navigator.pop(context, {
                    'workout': _selectedWorkout,
                    'duration': _duration,
                    'caloriesBurned': burned,
                    'updatedCalories': updatedCalories,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                ),
                child: const Text("Submit Workout", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
