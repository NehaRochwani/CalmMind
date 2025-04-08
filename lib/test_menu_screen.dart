import 'package:flutter/material.dart';

import 'anxiety_test_screen.dart';
import 'adhd_test_screen.dart';
import 'sleep_habit_test_screen.dart';
import 'self_disclosure_test_screen.dart';
import 'emotional_stability_test_screen.dart';

class TestMenuScreen extends StatelessWidget {
  const TestMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select a Test")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1,
          ),
          itemCount: 5,
          itemBuilder: (context, index) {
            List<String> testNames = [
              "Anxiety Test",
              "ADHD Test",
              "Sleep Habit Test",
              "Self Disclosure Test",
              "Emotional Stability Test"
            ];

            List<String> imagePaths = [
              "assets/images/anxiety_test_bg.jpg",
              "assets/images/adhd_test_bg.jpg",
              "assets/images/sleep_habits.jpg",
              "assets/images/self_disclosure_test_bg.jpg",
              "assets/images/emotional_stability_test_bg.jpg"
            ];

            return buildTestButton(
                context, testNames[index], imagePaths[index]);
          },
        ),
      ),
    );
  }

  Widget buildTestButton(BuildContext context, String testName, String imagePath) {
    return GestureDetector(
      onTap: () {
        if (testName == "Anxiety Test") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AnxietyTestScreen()),
          );
        } else if (testName == "ADHD Test") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ADHDTestScreen()),
          );
        } else if (testName == "Sleep Habit Test") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SleepHabitTestScreen()),
          );
        } else if (testName == "Self Disclosure Test") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SelfDisclosureTestScreen()),
          );
        } else if (testName == "Emotional Stability Test") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EmotionalStabilityTestScreen()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 2),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end, // Align to bottom
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration:  BoxDecoration(
                color: Colors.transparent, // Remove grey background
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                testName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8), // Add some space from bottom
          ],
        ),
      ),
    );
  }
}