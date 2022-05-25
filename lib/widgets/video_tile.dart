import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/blocs/favorite_bloc.dart';
import 'package:flutter_tube/widgets/yt_player.dart';

import '../models/video.dart';

class VideoTile extends StatelessWidget {
  const VideoTile(this.video, { Key? key }) : super(key: key);
  
  final Video video;
  

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.getBloc<FavoriteBloc>();

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) { 
            return YtPlayer(video.title, video.id, video.description);
          })
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16.0/9.0,
              child: Image.network(video.thumb, fit: BoxFit.cover),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          video.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          video.channel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                StreamBuilder<Map<String, Video>>(
                  stream: bloc.outFav,
                  //initialData: const {},
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      return IconButton(
                        icon: Icon(
                          snapshot.data!.containsKey(video.id) ?
                            Icons.star
                          : Icons.star_border
                        ),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: (){
                          bloc.toggleFavorite(video);
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}