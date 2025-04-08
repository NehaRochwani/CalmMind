import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SoundsScreen extends StatefulWidget {
  const SoundsScreen({super.key});

  @override
  _SoundsScreenState createState() => _SoundsScreenState();
}

class _SoundsScreenState extends State<SoundsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sounds"), backgroundColor: Colors.purple), // App Bar color
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple[100]!, Colors.blue[100]!], // Gradient background
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView( // Use ListView for scrollable buttons
            children: [
              buildSoundButton(
                  "Krishna Flute 1",
                  "assets/sound/flute.mp3",
                  "assets/images/flute1.jpg",
                  Colors.blue,
                  Colors.lightBlueAccent,
                  context),
              buildSoundButton(
                  "Krishna Flute 2",
                  "assets/sound/krishna.mp3",
                  "assets/images/flute2.jpg",
                  Colors.teal,
                  Colors.cyan,
                  context),
              buildSoundButton(
                  "OM Chanting",
                  "assets/sound/om.mp3",
                  "assets/images/om.jpg",
                  Colors.green,
                  Colors.lightGreenAccent,
                  context),
              buildSoundButton(
                  "Ocean Waves",
                  "assets/sound/ocean.mp3",
                  "assets/images/ocean.jpg",
                  Colors.teal,
                  Colors.cyan,
                  context),
              buildSoundButton(
                  "Rain Sounds",
                  "assets/sound/rain.mp3",
                  "assets/images/rain.jpg",
                  Colors.green,
                  Colors.lightGreenAccent,
                  context),
              buildSoundButton(
                  "Meditation Music",
                  "assets/sound/meditation.mp3",
                  "assets/images/meditation.jpg",
                  Colors.purple,
                  Colors.deepPurpleAccent,
                  context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSoundButton(String title, String audioPath, String imagePath,
      Color startColor, Color endColor, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton( // Use ElevatedButton for better styling
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageAndAudioScreen(
                imagePath: imagePath,
                audioPath: audioPath,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Transparent background
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 5,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [startColor, endColor]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            constraints: const BoxConstraints(minHeight: 50),
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 2. Updated ImageAndAudioScreen:

class ImageAndAudioScreen extends StatefulWidget {
  final String imagePath;
  final String audioPath;

  const ImageAndAudioScreen(
      {super.key, required this.imagePath, required this.audioPath});

  @override
  _ImageAndAudioScreenState createState() => _ImageAndAudioScreenState();
}

class _ImageAndAudioScreenState extends State<ImageAndAudioScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _initAudioPlayer() async {
    try {
      await _audioPlayer.setAsset(widget.audioPath);
      _audioPlayer.playerStateStream.listen((playerState) {
        setState(() {
          _isPlaying = playerState.playing;
        });
      });
      _audioPlayer.durationStream.listen((duration) {
        setState(() {
          _duration = duration ?? Duration.zero;
        });
      });
      _audioPlayer.positionStream.listen((position) {
        setState(() {
          _position = position;
        });
      });
      await _audioPlayer.play();
    } catch (e) {
      print("Error initializing audio player: $e");
    }
  }

  Future<void> _seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image and Audio"), backgroundColor: Colors.purple), // App Bar color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                widget.imagePath,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Slider(
              value: _position.inMilliseconds.toDouble(),
              max: _duration.inMilliseconds.toDouble(),
              onChanged: (double value) {
                _seek(Duration(milliseconds: value.toInt()));
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _seek(Duration.zero),
                  icon: const Icon(Icons.stop),
                ),
                IconButton(
                  onPressed: _isPlaying ? _audioPlayer.pause : _audioPlayer.play,
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}