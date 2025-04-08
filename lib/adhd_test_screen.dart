import 'package:flutter/material.dart';

class ADHDTestScreen extends StatefulWidget {
  const ADHDTestScreen({super.key});

  @override
  _ADHDTestScreenState createState() => _ADHDTestScreenState();
}

class _ADHDTestScreenState extends State<ADHDTestScreen> {
  final List<Map<String, Object>> _questions = [
    {
      'question': 'Do you often find it difficult to stay focused?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you have trouble organizing tasks?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you often forget important appointments?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you frequently lose things like keys, phone, etc.?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you get distracted easily when working on a task?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you feel restless or fidgety when sitting still?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you struggle to follow through on tasks?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you often interrupt others while they are speaking?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you avoid tasks that require a lot of mental effort?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you find it hard to relax or unwind?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
  ];

  List<int> _selectedAnswers = List.filled(10, -1); // List to store answers

  void _submitTest() {
    int score = _selectedAnswers.where((answer) => answer != -1).length;
    String resultMessage = '';

    if (score >= 8) {
      resultMessage = 'You may have symptoms of ADHD. It’s recommended to consult a healthcare professional for a thorough assessment.';
    } else if (score >= 5) {
      resultMessage = 'You may have mild symptoms of ADHD. It’s advisable to monitor your symptoms and consider seeking advice from a professional.';
    } else {
      resultMessage = 'Your symptoms are not indicative of ADHD. However, if you continue to experience difficulties, consider consulting a professional.';
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
      appBar: AppBar(title: const Text('ADHD Test')),
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
