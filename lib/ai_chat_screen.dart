import 'package:flutter/material.dart';
import 'ai_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AIChatScreen extends StatefulWidget {
  @override
  _AIChatScreenState createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();
  final GeminiService _geminiService = GeminiService();

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _startChat(); // Call _startChat in initState
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = prefs.getString('chatMessages');
    if (messagesJson != null) {
      final decodedMessages = json.decode(messagesJson) as List;
      setState(() {
        messages = decodedMessages.map((item) => Map<String, String>.from(item)).toList();
      });
    }
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = json.encode(messages);
    await prefs.setString('chatMessages', messagesJson);
  }

  void _sendMessage() async {
    final userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      messages.add({"sender": "You", "text": userMessage});
      _isLoading = true;
    });
    _controller.clear();

    String aiResponse = await _geminiService.getChatResponse(userMessage);

    setState(() {
      messages.add({"sender": "CalmMind AI", "text": aiResponse});
      _isLoading = false;
    });

    _saveMessages();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _startChat() {
    if (messages.isEmpty) { // Check if there are any messages before adding the welcome message.
      setState(() {
        messages.add({"sender": "CalmMind AI", "text": "Hi, how may I help you?"});
      });
      _saveMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CalmMind Chat")),
      backgroundColor: Colors.grey[100], // Background color for the whole chat
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUserMessage = message["sender"] == "You";
                return Align(
                  alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUserMessage ? Colors.blue[200] : Colors.green[200], // Message box colors
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [ // Add a subtle shadow
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      message["text"] ?? "",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}