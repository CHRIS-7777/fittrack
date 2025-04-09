import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  List<Map<String, dynamic>> _logEntries = [];

  @override
  void initState() {
    super.initState();
    _loadLogData();
  }

  Future<void> _loadLogData() async {
    final prefs = await SharedPreferences.getInstance();
    String? dataJson = prefs.getString('daily_log');
    if (dataJson != null) {
      List<dynamic> decoded = jsonDecode(dataJson);
      setState(() {
        _logEntries = decoded.map((e) => Map<String, dynamic>.from(e)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> sortedEntries = [..._logEntries];
    sortedEntries.sort((a, b) => a['date'].compareTo(b['date']));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Daily Calorie Log"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: sortedEntries.isEmpty
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
                rows: sortedEntries.map((entry) {
                  return DataRow(cells: [
                    DataCell(Text(entry['date'], style: const TextStyle(color: Colors.white))),
                    DataCell(Text(entry['gained'].toString(), style: const TextStyle(color: Colors.green))),
                    DataCell(Text(entry['burned'].toString(), style: const TextStyle(color: Colors.red))),
                  ]);
                }).toList(),
              ),
            ),
    );
  }
}
