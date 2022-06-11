import 'package:hive_flutter/adapters.dart';

import '../main.dart';
part 'model.g.dart';

@HiveType(typeId: 10)
class Songsdb extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  String? duration;
  @HiveField(3)
  String? id;
  @HiveField(4)
  String? songUri;

 

  Songsdb({
    required this.title,
    required this.artist,
    required this.duration,
    required this.id,
    required this.songUri,
  
  });
}



class Boxes {
  // static Box<List>? _box;
  static Box<List> getInstance(String boxname) {
    return Hive.box<List>(boxname);
  }
}