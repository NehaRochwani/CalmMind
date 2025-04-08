import 'package:flutter/material.dart';
import 'test_menu_screen.dart';
import 'insights_screen.dart';
import 'motivation_screen.dart';
import 'sounds_screen.dart';
import 'emergency_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CalmMind")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: (constraints.maxWidth / 2 - 16) / (constraints.maxHeight / 2 - 16),
              children: [
                buildSquareButton(context, "Tests", "assets/images/test_bg.jpg"),
                buildSquareButton(context, "Insights", "assets/images/insight_bg.jpg"),
                buildSquareButton(context, "Motivation", "assets/images/motivation_bg.jpg"),
                buildSquareButton(context, "Sounds", "assets/images/sound_bg.jpg"),
              ],
            );
          },
        ),
      ),
      floatingActionButton: EmergencyButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buildSquareButton(BuildContext context, String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        if (title == "Insights") { // Corrected title
          Navigator.push(context, MaterialPageRoute(builder: (context) => const InsightsScreen()));
        } else if (title == "Tests") { // Corrected title
          Navigator.push(context, MaterialPageRoute(builder: (context) => const TestMenuScreen()));
        } else if (title == "Motivation") { // Corrected title
          Navigator.push(context, MaterialPageRoute(builder: (context) => MotivationScreen()));
        } else if (title == "Sounds") { // Corrected title
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SoundsScreen()));
        }
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 2)],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                color: Colors.black.withOpacity(0.4),
                width: double.infinity,
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // changed text color to white.
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}