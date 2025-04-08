import 'package:flutter/material.dart';
import 'journal_screen.dart'; // Import JournalScreen
import 'storage_helper.dart';  // Import the helper file

void someFunction() async {
  Map<String, String> moodData = await StorageHelper.loadMoodData();
  print("Loaded Mood Data: $moodData");
}

class SuggestionsScreen extends StatelessWidget {
  final String emotion;

  const SuggestionsScreen({super.key, required this.emotion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Suggestions for $emotion"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Here are some ways to calm down and distract yourself:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            ...getSuggestions(emotion).map((suggestion) => suggestionCard(suggestion)).toList(),

            const SizedBox(height: 30),

            // Button to Open Journal Page
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JournalScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Open Journal",
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to get suggestions based on emotion
  List<String> getSuggestions(String emotion) {
    switch (emotion) {
      case "😊 Calm":
        return ["Listen to soft music", "Go for a peaceful walk", "Try meditation"];
      case "😟 Stressed":
        return ["Practice deep breathing", "Watch a funny video", "Write down your thoughts"];
      case "😢 Sad":
        return ["Call a loved one", "Watch a happy movie", "Try painting or journaling"];
      case "😠 Angry":
        return ["Do a quick workout", "Listen to calming music", "Try writing down your feelings"];
      default:
        return ["Take a deep breath", "Try mindfulness exercises"];
    }
  }

  // Function to create a card for each suggestion
  Widget suggestionCard(String text) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.blue.shade50,
      child: ListTile(
        leading: const Icon(Icons.lightbulb, color: Colors.blue),
        title: Text(text, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
