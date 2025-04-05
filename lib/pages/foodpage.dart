import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Food_Page extends StatefulWidget {
  const Food_Page({super.key});

  @override
  State<Food_Page> createState() => _Food_PageState();
}

class _Food_PageState extends State<Food_Page> {
  String _selectedFood = 'Apple';
  double _quantity = 1.0; // in KG

  final List<String> foodItems = ['Apple', 'Banana', 'Chicken Biriyani', 'Fish Fry','Egg'];

  double calculateCalories(String food, double kg) {
    Map<String, double> rates = {
      'Apple': 520.0,
      'Banana': 890.0,
      'Chicken Biriyani': 1500.0,
      'Fish Fry': 1200.0,
      'Egg':100,
    };

    double rate = rates[food] ?? 1000.0;
    return rate * kg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Food Selection.."),
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
              "Choose Food",
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
                value: _selectedFood,
                decoration: const InputDecoration(border: InputBorder.none),
                style: const TextStyle(color: Colors.white),
                items: foodItems.map((String food) {
                  return DropdownMenuItem<String>(
                    value: food,
                    child: Text(food),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFood = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Quantity (in Kg)",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: "Enter quantity (kg)",
                hintStyle: const TextStyle(color: Colors.white54),
              ),
              keyboardType: TextInputType.number,
              initialValue: _quantity.toString(),
              onChanged: (val) {
                _quantity = double.tryParse(val) ?? 1.0;
              },
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  double gained = calculateCalories(_selectedFood, _quantity);

                  final prefs = await SharedPreferences.getInstance();
                  double currentCalories = prefs.getDouble('calories') ?? 1000.0;

                  double updatedCalories = currentCalories + gained;
                  updatedCalories = updatedCalories.clamp(0.0, 10000.0);

                  await prefs.setDouble('calories', updatedCalories);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "You gained ${gained.toStringAsFixed(1)} cal from $_quantity kg of $_selectedFood!\nTotal: ${updatedCalories.toStringAsFixed(1)}",
                      ),
                      duration: const Duration(seconds: 4),
                      backgroundColor: Colors.green[600],
                    ),
                  );

                  Navigator.pop(context, {
                    'food': _selectedFood,
                    'quantity': _quantity,
                    'caloriesGained': gained,
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
                child: const Text("Submit Food", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
