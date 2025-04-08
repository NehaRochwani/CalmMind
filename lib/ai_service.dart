import 'package:http/http.dart' as http;
import 'dart:convert';

class GeminiService {
  final String _cloudFunctionUrl = 'YOUR_PYTHON_CLOUD_FUNCTION_URL'; // Replace with your actual URL

  Future<String> getChatResponse(String message) async {
    try {
      final response = await http.post(
        Uri.parse(_cloudFunctionUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['response'] ?? 'No response from Gemini.';
      } else {
        print('Error from Cloud Function: ${response.statusCode}, ${response.body}');
        return 'Error generating response.';
      }
    } catch (e) {
      print('Error communicating with Cloud Function: $e');
      return 'Error generating response.';
    }
  }
}