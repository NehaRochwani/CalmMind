import 'package:flutter/material.dart';

class MotivationScreen extends StatelessWidget {
  MotivationScreen({super.key});

  final List<List<String>> motivationQuotes = [
    ["Stay Strong", "You have survived 100% of your bad days."],
    ["You Are Enough", "Believe in yourself, you are more powerful than you know."],
    ["Keep Going", "Tough times never last, but tough people do."],
    ["Believe in Yourself", "Your only limit is your mind. Keep pushing forward."],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Motivation")),
      body: PageView.builder(
        itemCount: motivationQuotes.length,
        itemBuilder: (context, index) {
          return buildMotivationPage(
            motivationQuotes[index][0],
            "assets/images/motivation${index + 1}.jpg",
            motivationQuotes[index][1],
          );
        },
      ),
    );
  }

  Widget buildMotivationPage(String title, String imagePath, String quote) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const Spacer(), // Pushes content to the bottom
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(bottom: 30), // Adjusts bottom spacing
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  quote,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
