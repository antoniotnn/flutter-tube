
import 'dart:async';
import 'dart:ui';
import 'package:flutter_tube/api.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

import '../models/video.dart';





class VideosBloc implements BlocBase {

  late Api api;

  late List<Video> videos;

  final StreamController<List<Video>> _videosController = StreamController<List<Video>>();

  Stream get outVideos => _videosController.stream;

  final StreamController _searchController = StreamController();
  Sink get inSearch => _searchController.sink;

  VideosBloc() {
    api = Api();

    _searchController.stream.listen(_search);
  }

  void _search(search) async {
    if(search != null) {
      _videosController.sink.add([]);
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }
    _videosController.sink.add(videos);
  }

  @override
  void addListener(VoidCallback listener) {
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
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