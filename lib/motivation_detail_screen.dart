import 'package:flutter/material.dart';

class MotivationDetailScreen extends StatelessWidget {
  final List<String> quotes;

  const MotivationDetailScreen({super.key, required this.quotes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Motivational Quotes")),
      body: PageView.builder(
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    quotes[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
