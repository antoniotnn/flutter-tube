import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/video.dart';

// ignore: constant_identifier_names
const API_KEY = 'API_KEY_HERE';

class Api {

  late String _search;
  late String _nextToken;

  Future<List<Video>> search(String search) async {

    _search = search;

    http.Response response = await http.get(
      Uri.parse("https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10")
    );

    return decode(response);
  }

  Future<List<Video>> nextPage() async {

    http.Response response = await http.get(
      Uri.parse("https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken")
    );

    return decode(response);

  }

  List<Video> decode(http.Response response) {
    if(response.statusCode == 200) {
      var decoded = json.decode(response.body);

      _nextToken = decoded['nextPageToken'];

      List<Video> videos = decoded['items'].map<Video>(
        (map) {
          return Video.fromJson(map);
        }
      ).toList();

      return videos;
    } else {
      //print(response.statusCode);
      var decoded = json.decode(response.body);

      throw Exception("Fail to load videos: ${decoded['error']['message']}");
    }
  }

}