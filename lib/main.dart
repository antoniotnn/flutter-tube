import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/blocs/favorite_bloc.dart';
import 'package:flutter_tube/blocs/videos_bloc.dart';
import 'package:flutter_tube/screens/home.dart';


void main() {
  
  //Api api = Api();
  //api.search('games');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((i) => FavoriteBloc()),
      ],
      dependencies: const [],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlutterTube',
        home: Home()
      ),
    ); 
  }


}
