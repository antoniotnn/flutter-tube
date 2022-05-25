
class Video {
  
  final String id;
  final String title;
  final String thumb;
  final String channel;
  final String description;

  Video({required this.id, required this.title, required this.thumb, required this.channel, required this.description});

  factory Video.fromJson(Map<String, dynamic> json) {
    if(json.containsKey('id')) {
      //coming from google api
      return Video(
        id: json['id']['videoId'],
        title: json['snippet']['title'],
        thumb: json['snippet']['thumbnails']['high']['url'],
        channel: json['snippet']['channelTitle'],
        description: json['snippet']['description'],
      );
    } else {
      return Video(
        id: json['videoId'], 
        title: json['title'], 
        thumb: json['thumb'], 
        channel: json['channel'],
        description: json['description'],
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'videoId': id,
      'title': title,
      'thumb': thumb,
      'channel': channel,
      'description': description
    };
  }

}