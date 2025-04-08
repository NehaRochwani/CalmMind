import 'package:flutter/material.dart';
import 'emergency_button.dart'; // Import EmergencyButton

class BaseScreen extends StatelessWidget {
  final Widget child;
  final AppBar? appBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;

  const BaseScreen({
    super.key,
    required this.child,
    this.appBar,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: child,
      floatingActionButton: floatingActionButton ?? EmergencyButton(), // Use provided FAB or default
      floatingActionButtonLocation:
      floatingActionButtonLocation ?? FloatingActionButtonLocation.endFloat, // Use provided location or default
    );
  }
}