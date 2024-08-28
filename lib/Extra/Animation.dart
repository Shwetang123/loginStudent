import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// Class to hold video ID and its associated controller
class YouTubeVideo {
  final String videoId;
  final YoutubePlayerController controller;

  YouTubeVideo({required this.videoId})
      : controller = YoutubePlayerController() {
    controller.cueVideoById(videoId: videoId);
  }
}

class YoutubePlayerScreen extends StatefulWidget {
  const YoutubePlayerScreen({super.key});

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  // List of videos
  final List<YouTubeVideo> videos = [
    YouTubeVideo(videoId: "LbOW7rDlTNs"),
    YouTubeVideo(videoId: "LbOW7rDlTNs"),
    YouTubeVideo(videoId: "dQw4w9WgXcQ"),
    YouTubeVideo(videoId: "PrEuE1Rq1VA"),
    YouTubeVideo(videoId: "PrEuE1Rq1VA"),
  ];

  @override
  void dispose() {
    // Dispose of each controller when the widget is disposed
    for (var video in videos) {
      video.controller.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: videos.map((video) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0,top: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: YoutubePlayer(
                    controller: video.controller,
                    aspectRatio: 16 / 9,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
