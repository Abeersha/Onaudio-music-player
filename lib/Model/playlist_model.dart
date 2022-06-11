import 'package:audio3/Model/model.dart';
import 'package:hive_flutter/adapters.dart';

part 'playlist_model.g.dart';

@HiveType(typeId: 0)
class ModelPlaylist extends HiveObject {
  @HiveField(0)
  String? playlistName;
  @HiveField(1)
  List<Songsdb> playlistSongs = [];
 
 
  ModelPlaylist({
    required this.playlistSongs,
    required this.playlistName
  });
}


