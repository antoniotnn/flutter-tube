import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';



class YtPlayer extends StatefulWidget {
  const YtPlayer(this.title, this.videoId, this.description, { Key? key }) : super(key: key);

  final String title;
  final String videoId;
  final String description;

  @override
  State<YtPlayer> createState() => _YtPlayerState();
}

class _YtPlayerState extends State<YtPlayer> {
  
  
  late YoutubePlayerController _controller;

  void runYoutubePlayer() {
    _controller = YoutubePlayerController(
      //initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        enableCaption: false,
        isLive: false,
        autoPlay: false
      )
    );
  }

  @override
  void initState() {
    runYoutubePlayer();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player){
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: Colors.black87,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              player,
              const SizedBox(height: 40.0),
              Text(widget.description),
            ],
          ),
        );
      },
    );
  }
}