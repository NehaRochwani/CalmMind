import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  late GenerativeModel _model;

  GeminiService() {
    final apiKey = dotenv.env['GOOGLE_API_KEY'];
    if (apiKey == null) {
      print("Error: Google API key not found in .env file.");
      // Handle the error appropriately
    }
    _model = GenerativeModel(
      model: 'gemini-1.5-flash', // Updated to gemini-1.5-flash
      apiKey: apiKey!,
    );
  }

  Future<String> getChatResponse(String message) async {
    try {
      final content = [Content.text(message)];
      final response = await _model.generateContent(content);
      return response.text ?? 'No response from Gemini.';
    } catch (e, stackTrace) {
      print('Gemini error: $e, StackTrace: $stackTrace');
      return 'Error generating response.';
    }
  }
}