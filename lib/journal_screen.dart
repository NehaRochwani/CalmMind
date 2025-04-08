import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'emergency_button.dart';

class JournalScreen extends StatefulWidget {
  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _entries = [];
  DateTime _selectedDate = DateTime.now();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final user = _auth.currentUser;
    if (user != null) {
      final journalDocs = await _firestore
          .collection('journals')
          .doc(user.uid)
          .collection('entries')
          .orderBy('date', descending: true)
          .get();

      setState(() {
        _entries = journalDocs.docs
            .map((doc) => {
          'date': doc['date'] as String,
          'text': doc['text'] as String,
        })
            .toList();
      });
    }
  }

  Future<void> _saveEntry() async {
    if (_controller.text.isNotEmpty) {
      final user = _auth.currentUser;
      if (user != null) {
        final entry = {
          'date': DateFormat('yyyy-MM-dd').format(_selectedDate),
          'text': _controller.text,
        };
        await _firestore
            .collection('journals')
            .doc(user.uid)
            .collection('entries')
            .add(entry);

        setState(() {
          _entries.insert(0, entry);
          _controller.clear();
        });
      }
    }
  }

  Future<void> _deleteEntry(int index) async {
    final user = _auth.currentUser;
    if (user != null) {
      final entryToDelete = _entries[index];
      final journalDocs = await _firestore
          .collection('journals')
          .doc(user.uid)
          .collection('entries')
          .where('date', isEqualTo: entryToDelete['date'])
          .where('text', isEqualTo: entryToDelete['text'])
          .get();

      if (journalDocs.docs.isNotEmpty) {
        await _firestore
            .collection('journals')
            .doc(user.uid)
            .collection('entries')
            .doc(journalDocs.docs.first.id)
            .delete();

        setState(() {
          _entries.removeAt(index);
        });
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async { // Added _selectDate method
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.purple,
            hintColor: Colors.purpleAccent,
            colorScheme: ColorScheme.light(primary: Colors.purple),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Journal Entries"),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple[100]!, Colors.blue[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}",
                      style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today, color: Colors.purple),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "Write your thoughts...",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purpleAccent),
                  ),
                  labelStyle: TextStyle(color: Colors.deepPurple),
                ),
                style: TextStyle(color: Colors.black87),
              ),
            ),
            ElevatedButton(
              onPressed: _saveEntry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              child: Text("Save Entry"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _entries.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    elevation: 3,
                    color: Colors.white.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(_entries[index]['text']!, style: TextStyle(color: Colors.black87)),
                      subtitle: Text(_entries[index]['date']!, style: TextStyle(color: Colors.grey)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteEntry(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: EmergencyButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}