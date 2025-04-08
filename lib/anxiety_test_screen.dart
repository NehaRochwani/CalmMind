import 'package:flutter/material.dart';

class AnxietyTestScreen extends StatefulWidget {
  const AnxietyTestScreen({super.key});

  @override
  _AnxietyTestScreenState createState() => _AnxietyTestScreenState();
}

class _AnxietyTestScreenState extends State<AnxietyTestScreen> {
  final List<Map<String, Object>> _questions = [
    {
      'question': 'Do you often feel nervous or anxious?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you have difficulty relaxing?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you often feel restless or on edge?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you experience rapid heartbeats or palpitations?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you avoid situations that cause anxiety?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you find it difficult to focus due to anxiety?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you feel like you’re always on edge?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you experience excessive worry?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you experience trouble sleeping due to anxiety?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you have panic attacks?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
  ];

  List<int> _selectedAnswers = List.filled(10, -1); // List to store answers

  void _submitTest() {
    int score = _selectedAnswers.where((answer) => answer != -1).length;
    String resultMessage = '';

    if (score >= 8) {
      resultMessage = 'You may be experiencing high anxiety. It’s recommended to consult a professional.';
    } else if (score >= 5) {
      resultMessage = 'You are experiencing moderate anxiety. Some lifestyle changes could help.';
    } else {
      resultMessage = 'Your anxiety levels seem to be low. Keep an eye on your mental well-being.';
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Test Result'),
        content: Text(resultMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anxiety Test')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/anxiety_test_screen_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Answer the following questions to the best of your ability.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: _questions.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _questions[index]['question'] as String,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            ...(_questions[index]['options'] as List<String>)
                                .asMap()
                                .entries
                                .map(
                                  (option) => RadioListTile<int>(
                                title: Text(option.value),
                                value: option.key,
                                groupValue: _selectedAnswers[index],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedAnswers[index] = value!;
                                  });
                                },
                              ),
                            )
                                .toList(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _submitTest,
                child: const Text('Submit Test'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
