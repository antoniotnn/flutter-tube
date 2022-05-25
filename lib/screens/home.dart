import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/blocs/favorite_bloc.dart';
import 'package:flutter_tube/blocs/videos_bloc.dart';
import 'package:flutter_tube/delegates/data_search.dart';
import 'package:flutter_tube/models/video.dart';
import 'package:flutter_tube/screens/favorites.dart';

import '../widgets/video_tile.dart';


class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final videosBloc = BlocProvider.getBloc<VideosBloc>();
    final favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 25,
          child: Image.asset('images/yt_logo_rgb_dark.png'),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: [
          StreamBuilder<Map<String, Video>>(
            stream: favoriteBloc.outFav,
            //initialData: const {},
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return Center(
                  widthFactor: 3.3,
                  child: Text(
                    '${snapshot.data!.length}',
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              } else {
                return Container();
              }
            }
          ),
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Favorites(), 
                )
              );
            }, 
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              String? result = await showSearch(context: context, delegate: DataSearch());
              if (result != null) {
                videosBloc.inSearch.add(result);
              }
            }, 
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: videosBloc.outVideos,
        initialData: const [],
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                if(index < snapshot.data.length) {
                  return VideoTile(snapshot.data[index]);
                } else if (index > 1) {
                  videosBloc.inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
                  );
                } else {
                  return Container();
                }
              },
              itemCount: snapshot.data.length + 1,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}