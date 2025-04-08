import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'home_screen.dart';
import 'journal_screen.dart';
import 'suggestions_screen.dart';
import 'weekly_mood_screen.dart';
import 'emergency_button.dart';
import 'ai_chat_screen.dart';
import 'profile_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _saveMood(String mood) async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    prefs.setString(today, mood);
  }

  void _onNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AIChatScreen()),
      );
    } else if (index == 0) { // Add this condition
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF8EC5FC), Color(0xFFE0C3FC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Text(
                'CalmMind Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.blueAccent),
              title: const Text('Home'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.book, color: Colors.blueAccent),
              title: const Text('Journal'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => JournalScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart, color: Colors.blueAccent),
              title: const Text('Weekly Mood'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WeeklyMoodScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.support_agent, color: Colors.blueAccent),
              title: const Text('CalmMind AI Chat'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AIChatScreen()));
              },
            ),
          ],
        ),
      ),
      body: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) => Opacity(
          opacity: _fadeAnimation.value,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8EC5FC), Color(0xFFE0C3FC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "CalmMind",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 2,
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "How are you feeling today?",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: [
                          emotionButton(context, "😊 Calm",
                              Colors.greenAccent.shade400, "Calm"),
                          emotionButton(context, "😟 Stressed",
                              Colors.orangeAccent.shade400, "Stressed"),
                          emotionButton(context, "😢 Sad",
                              Colors.blueAccent.shade400, "Sad"),
                          emotionButton(context, "😠 Angry",
                              Colors.redAccent.shade400, "Angry"),
                        ],
                      ),
                      const SizedBox(height: 40),
                      moodButton(
                          "Profile", ProfileScreen(), Colors.blueAccent),
                      const SizedBox(height: 20),
                      moodButton("Open Journal", JournalScreen(), Colors.blueAccent),
                      const SizedBox(height: 20),
                      moodButton("Weekly Mood", WeeklyMoodScreen(), Colors.blueAccent),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: EmergencyButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavTapped,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'AI Chat'),
        ],
      ),
    );
  }

  Widget emotionButton(
      BuildContext context, String mood, Color color, String moodValue) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 300),
      builder: (context, scale, child) => Transform.scale(
        scale: scale,
        child: ElevatedButton(
          onPressed: () {
            _saveMood(moodValue);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SuggestionsScreen(emotion: mood),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 5,
          ),
          child: Text(
            mood,
            style: const TextStyle(
                fontSize: 19, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget moodButton(String text, Widget screen, Color color) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.9),
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        elevation: 7,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}