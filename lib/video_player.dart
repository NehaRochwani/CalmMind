import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BlogScreen extends StatelessWidget {
  final String blogTitle;

  const BlogScreen({super.key, required this.blogTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(blogTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getBlogContent(blogTitle),
                style: const TextStyle(fontSize: 18, height: 1.6),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerScreen(blogTitle: blogTitle),
                      ),
                    );
                  },
                  child: const Text("Watch Related Video"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getBlogContent(String blogTitle) {
    switch (blogTitle) {
      case "Mental Health":
        return '''Mental health refers to emotional, psychological, and social well-being...'''
        // Add the rest of the blog content here as previously described
            ;

    // Repeat the same for other cases (Depression, Anger, etc.)

      default:
        return 'Content not found';
    }
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String blogTitle;

  const VideoPlayerScreen({super.key, required this.blogTitle});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the video player controller based on the blog topic
    _controller = VideoPlayerController.asset(
      'assets/videos/${widget.blogTitle.toLowerCase().replaceAll(" ", "_")}_video.mp4', // Assuming the video name matches the blog title
    )
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Watch Video")),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
