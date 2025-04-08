import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'intro_screen.dart';
import 'journal_screen.dart';
import 'emergency_button.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await DotEnv.dotenv.load(fileName: ".env");
  } catch (e) {
    print("Error loading .env file: $e");
    // Handle the error (e.g., show an error message to the user)
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CalmMind',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const MainScreen(),
      routes: {
        '/intro': (context) => IntroScreen(),
        '/journal': (context) => JournalScreen(),
        '/loginPage': (context) => LoginPage(),
        '/registerPage': (context) => RegisterPage(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return IntroScreen();
        } else {
          return LoginPage();
        }
      },
    );
  }
}