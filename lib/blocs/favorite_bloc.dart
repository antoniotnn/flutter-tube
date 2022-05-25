import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_tube/models/video.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc implements BlocBase {

  Map<String, Video> _favorites = {};

  //final StreamController<Map<String, Video>> _favController = StreamController<Map<String, Video>>.broadcast();
  final _favController = BehaviorSubject<Map<String, Video>>.seeded({});


  Stream<Map<String, Video>> get outFav => _favController.stream;

  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      //prefs.clear();
      if(prefs.containsKey('favorites')) {
        _favorites = json.decode(prefs.getString('favorites')!).map((key, value) {
          return MapEntry(key, Video.fromJson(value));
        }).cast<String, Video>();

        _favController.add(_favorites);
      }
    });
  }

  void toggleFavorite(Video video) {
    if(_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }
    _favController.sink.add(_favorites);

    _saveFav();
  }

  void _saveFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('favorites', json.encode(_favorites));
    });
  }

  @override
  void addListener(VoidCallback listener) {
  }

  @override
  void dispose() {
    _favController.close();
  }

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
  }

  @override
  void removeListener(VoidCallback listener) {
  }

}