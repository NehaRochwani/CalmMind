import 'package:flutter/material.dart';

class SelfDisclosureTestScreen extends StatefulWidget {
  const SelfDisclosureTestScreen({super.key});

  @override
  _SelfDisclosureTestScreenState createState() => _SelfDisclosureTestScreenState();
}

class _SelfDisclosureTestScreenState extends State<SelfDisclosureTestScreen> {
  final List<Map<String, Object>> _questions = [
    {
      'question': 'How often do you share your personal thoughts with others?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you find it difficult to open up emotionally to others?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'How comfortable are you discussing your emotions?',
      'options': ['Not at all', 'Somewhat', 'Very comfortable', 'Extremely comfortable'],
    },
    {
      'question': 'Do you share your personal challenges with close friends?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you often keep secrets from your family?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you feel judged when you share personal thoughts?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you find it easy to disclose personal problems to others?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'How much do you trust people with your secrets?',
      'options': ['Not at all', 'Somewhat', 'Very much', 'Completely'],
    },
    {
      'question': 'Do you tend to share information about your private life?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you find self-disclosure helpful for your mental well-being?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
  ];

  List<int> _selectedAnswers = List.filled(10, -1);

  void _submitTest() {
    int score = _selectedAnswers.where((answer) => answer != -1).length;
    String resultMessage = '';

    if (score >= 8) {
      resultMessage = 'You seem to disclose a lot of personal information and are comfortable with self-disclosure.';
    } else if (score >= 5) {
      resultMessage = 'You disclose some personal information, but you may find it difficult at times.';
    } else {
      resultMessage = 'You may struggle with self-disclosure and might find it challenging to share personal details with others.';
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
      appBar: AppBar(title: const Text('Self Disclosure Test')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/adhd_test_screen_bg.jpg'),
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
                'Answer the following questions to evaluate your self-disclosure habits.',
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
