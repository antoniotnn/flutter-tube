import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../blocs/favorite_bloc.dart';
import '../models/video.dart';
import '../widgets/yt_player.dart';


class Favorites extends StatelessWidget {
  const Favorites({ Key? key }) : super(key: key);
  

  

  @override
  Widget build(BuildContext context) {

    final favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        stream: favoriteBloc.outFav,
        initialData: const {},
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data!.values.map((video) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) { 
                      return YtPlayer(video.title, video.id, video.description);
                    })
                  );
                },
                onLongPress: () {
                  favoriteBloc.toggleFavorite(video);
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: Image.network(video.thumb),
                    ),
                    Expanded(
                      child: Text(
                        video.title,
                        style: const TextStyle(color: Colors.white70),
                        maxLines: 2,
                      )
                    )
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}