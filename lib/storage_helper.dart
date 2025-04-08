import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  // Save a Map as JSON String
  static Future<void> saveMoodData(Map<String, String> moodData) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(moodData);
    await prefs.setString('mood_data', jsonData);
  }

  // Load and Decode JSON String back to Map
  static Future<Map<String, String>> loadMoodData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('mood_data');

    if (jsonData != null) {
      return Map<String, String>.from(jsonDecode(jsonData));
    }

    return {};  // Return empty map if no data is found
  }
}
