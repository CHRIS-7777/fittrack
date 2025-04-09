import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  Map<String, dynamic> _logData = {};

  @override
  void initState() {
    super.initState();
    _loadLogData();
  }

  Future<void> _loadLogData() async {
    final prefs = await SharedPreferences.getInstance();
    String? dataJson = prefs.getString('daily_log');
    if (dataJson != null) {
      setState(() {
        _logData = jsonDecode(dataJson);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> sortedDates = _logData.keys.toList()
      ..sort((a, b) => a.compareTo(b));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Daily Calorie Log"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: _logData.isEmpty
          ? const Center(child: Text("No data saved yet.", style: TextStyle(color: Colors.white)))
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.grey[900]),
                columns: const [
                  DataColumn(label: Text("Date", style: TextStyle(color: Colors.orange))),
                  DataColumn(label: Text("Gained", style: TextStyle(color: Colors.orange))),
                  DataColumn(label: Text("Burned", style: TextStyle(color: Colors.orange))),
                ],
                rows: sortedDates.map((date) {
                  final data = _logData[date];
                  final gained = data['gained'];
                  final burned = data['burned'];
                  return DataRow(cells: [
                    DataCell(Text(date, style: const TextStyle(color: Colors.white))),
                    DataCell(Text(gained.toString(), style: const TextStyle(color: Colors.green))),
                    DataCell(Text(burned.toString(), style: const TextStyle(color: Colors.red))),
                  ]);
                }).toList(),
              ),
            ),
    );
  }
}
