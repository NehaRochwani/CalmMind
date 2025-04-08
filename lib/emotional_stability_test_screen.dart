import 'package:flutter/material.dart';

class EmotionalStabilityTestScreen extends StatefulWidget {
  const EmotionalStabilityTestScreen({super.key});

  @override
  _EmotionalStabilityTestScreenState createState() => _EmotionalStabilityTestScreenState();
}

class _EmotionalStabilityTestScreenState extends State<EmotionalStabilityTestScreen> {
  final List<Map<String, Object>> _questions = [
    {
      'question': 'Do you get upset easily?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you find it hard to stay calm in stressful situations?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you often feel emotionally drained?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you have mood swings?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you feel overly sensitive to criticism?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you often overreact to situations?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you often find it hard to forgive others?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you feel overwhelmed by your emotions?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you often feel anxious or stressed?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you find it difficult to regulate your emotions?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
  ];

  List<int> _selectedAnswers = List.filled(10, -1);

  void _submitTest() {
    int score = _selectedAnswers.where((answer) => answer != -1).length;
    String resultMessage = '';

    if (score >= 8) {
      resultMessage = 'You may struggle with emotional stability. Consider seeking professional help to manage emotions effectively.';
    } else if (score >= 5) {
      resultMessage = 'You may experience occasional emotional instability. Working on emotional regulation techniques may help.';
    } else {
      resultMessage = 'You seem to have good emotional control, but if you ever face challenges, consider seeking support.';
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
      appBar: AppBar(title: const Text('Emotional Stability Test')),
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
                'Answer the following questions to evaluate your emotional stability.',
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
