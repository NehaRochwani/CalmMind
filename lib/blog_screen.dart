import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BlogScreen extends StatefulWidget {
  final String blogTitle;
  final String imagePath;
  final String content;
  final String videoPath;
  final bool showControls;

  const BlogScreen({
    Key? key,
    required this.blogTitle,
    required this.imagePath,
    required this.content,
    required this.videoPath,
    this.showControls = false,
  }) : super(key: key);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  late VideoPlayerController _controller;
  Duration _videoPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
        _controller.play(); // Start playing the video immediately
      });

    _controller.addListener(() {
      setState(() {
        _videoPosition = _controller.value.position;
      });
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
      appBar: AppBar(title: Text(widget.blogTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.imagePath),
            const SizedBox(height: 16),
            Text(
              widget.blogTitle,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              widget.content,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  if (widget.showControls)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _buildVideoControls(),
                    ),
                ],
              ),
            )
                : const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoControls() {
    final isInitialized = _controller.value.isInitialized;
    final videoDuration =
    isInitialized ? _controller.value.duration : Duration.zero;
    final currentPosition = isInitialized ? _videoPosition : Duration.zero;

    return isInitialized
        ? Container(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            value: currentPosition.inMilliseconds
                .clamp(0, videoDuration.inMilliseconds)
                .toDouble(),
            max: videoDuration.inMilliseconds.toDouble(),
            onChanged: (double value) {
              setState(() {
                _videoPosition = Duration(milliseconds: value.toInt());
                _controller.seekTo(Duration(milliseconds: value.toInt())); // Seek during onChange
              });
            },
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  _controller.seekTo(Duration.zero);
                },
                icon: const Icon(Icons.stop, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    )
        : const SizedBox.shrink();
  }
}