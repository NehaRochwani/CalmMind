import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'emergency_button.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class WeeklyMoodScreen extends StatefulWidget {
  @override
  _WeeklyMoodScreenState createState() => _WeeklyMoodScreenState();
}

class _WeeklyMoodScreenState extends State<WeeklyMoodScreen> {
  Map<String, int> moodCounts = {};
  final FirebaseAuth _auth = FirebaseAuth.instance; // Instance of FirebaseAuth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // instance of firestore

  @override
  void initState() {
    super.initState();
    _loadWeeklyMood();
  }

  Future<void> _loadWeeklyMood() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final weekAgo = today.subtract(const Duration(days: 7));
    moodCounts = {};

    for (var i = 0; i < 7; i++) {
      final date = today.subtract(Duration(days: i));
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      final mood = prefs.getString(formattedDate);
      if (mood != null) {
        moodCounts[mood] = (moodCounts[mood] ?? 0) + 1;
        //store in firestore
        await _storeMoodInFirestore(formattedDate, mood);
      }
    }
    setState(() {});
  }

  Future<void> _storeMoodInFirestore(String date, String mood) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('moods')
          .doc(date)
          .set({'mood': mood});
    }
  }

  List<BarChartGroupData> _createBarChartData() {
    List<BarChartGroupData> barGroups = [];
    int index = 0;

    moodCounts.forEach((mood, days) {
      Color barColor;
      if (mood == 'Calm') {
        barColor = Colors.green;
      } else if (mood == 'Stressed') {
        barColor = Colors.orange;
      } else if (mood == 'Sad') {
        barColor = Colors.blue;
      } else if (mood == 'Angry') {
        barColor = Colors.red;
      } else {
        barColor = Colors.grey;
      }

      barGroups.add(
        BarChartGroupData(
          x: index++,
          barRods: [
            BarChartRodData(
              toY: days.toDouble(),
              color: barColor,
              width: 22,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      );
    });
    return barGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weekly Mood Analysis"),
        backgroundColor: Colors.purple[200],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple[100]!, Colors.blue[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (moodCounts.isNotEmpty)
                SizedBox(
                  height: 300,
                  child: BarChart(
                    BarChartData(
                      barGroups: _createBarChartData(),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return Text(moodCounts.keys.toList()[value.toInt()]);
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barTouchData: BarTouchData(
                        enabled: true,
                      ),
                    ),
                    swapAnimationDuration: Duration(milliseconds: 150),
                    swapAnimationCurve: Curves.linear,
                  ),
                )
              else
                const Text("No mood data available for the week."),
              const SizedBox(height: 20),
              Column(
                children: moodCounts.entries.map((entry) {
                  return Text("${entry.key}: ${entry.value} days");
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: EmergencyButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}