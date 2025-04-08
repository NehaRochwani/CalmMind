import 'package:flutter/material.dart';

class SleepHabitTestScreen extends StatefulWidget {
  const SleepHabitTestScreen({super.key});

  @override
  _SleepHabitTestScreenState createState() => _SleepHabitTestScreenState();
}

class _SleepHabitTestScreenState extends State<SleepHabitTestScreen> {
  final List<Map<String, Object>> _questions = [
    {
      'question': 'How often do you have trouble falling asleep?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you wake up feeling refreshed?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you have trouble staying asleep throughout the night?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you use electronics (phone, TV, etc.) right before bed?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you experience difficulty waking up in the morning?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you feel drowsy or tired during the day?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you take naps during the day?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you have a consistent sleep schedule?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you drink caffeine or alcohol before bedtime?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
    {
      'question': 'Do you feel you get enough sleep each night?',
      'options': ['Never', 'Sometimes', 'Often', 'Always'],
    },
  ];

  List<int> _selectedAnswers = List.filled(10, -1);

  void _submitTest() {
    int score = _selectedAnswers.where((answer) => answer != -1).length;
    String resultMessage = '';

    if (score >= 8) {
      resultMessage = 'You may have sleep-related issues. Consider improving your sleep hygiene and consulting a professional if needed.';
    } else if (score >= 5) {
      resultMessage = 'You may have mild sleep disturbances. It’s advisable to work on your sleep habits.';
    } else {
      resultMessage = 'Your sleep habits seem fine, but if issues persist, seek professional advice.';
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
      appBar: AppBar(title: const Text('Sleep Habit Test')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/depression_test_screen_bg.jpg'),
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
                'Answer the following questions regarding your sleep habits.',
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
