import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencyButton extends StatefulWidget {
  @override
  _EmergencyButtonState createState() => _EmergencyButtonState();
}

class _EmergencyButtonState extends State<EmergencyButton> {
  String phoneNumber = ""; // Initialize with empty string
  final String message = "I need immediate help! Please respond ASAP.";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isMounted = false; // Track if the widget is mounted

  @override
  void initState() {
    super.initState();
    _isMounted = true; // Set to true when the widget is created
    _loadEmergencyNumber();
  }

  @override
  void dispose() {
    _isMounted = false; // Set to false when the widget is disposed
    super.dispose();
  }

  Future<void> _loadEmergencyNumber() async {
    User? user = _auth.currentUser;
    print("Current User: $user"); // Debug print

    if (user != null) {
      try {
        DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(user.uid).get();

        print("Snapshot exists: ${snapshot.exists}"); // Debug print

        if (snapshot.exists && _isMounted) {
          setState(() {
            phoneNumber = snapshot['emergencyNumber'] ?? "";
            print("Emergency Number fetched: $phoneNumber"); // Debug print
          });
        } else if (!snapshot.exists) {
          print("Document does not exist for user: ${user.uid}"); // Debug print
        } else {
          print("Widget was disposed before setState could be called."); // Debug print
        }
      } catch (e) {
        print("Error loading emergency number: $e"); // Debug print
      }
    } else {
      print("User is not logged in."); // Debug print
    }
  }

  Future<void> _sendWhatsAppMessage() async {
    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Emergency number not set.")),
      );
      return;
    }

    final String encodedMessage = Uri.encodeComponent(message);
    final Uri whatsappUri = Uri.parse("https://wa.me/$phoneNumber?text=$encodedMessage");

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open WhatsApp.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _sendWhatsAppMessage,
      backgroundColor: Colors.redAccent,
      child: const Icon(Icons.warning, color: Colors.white),
      tooltip: "Send Emergency Message",
    );
  }
}