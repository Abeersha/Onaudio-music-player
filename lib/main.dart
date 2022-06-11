import 'package:audio3/Model/playlist_model.dart';
import 'package:audio3/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

import 'Model/model.dart';

String boxname = 'songs';
// late Box<> playlistBox;

void main() async {
  await Hive.initFlutter();
  

  Hive.registerAdapter(SongsdbAdapter());
  Hive.registerAdapter(ModelPlaylistAdapter());

 

  await Hive.openBox<List>(boxname);
// playlistBox =
  await Hive.openBox<ModelPlaylist>('playlists');

  // await Hive.openBox<List>('favourites');

  runApp(const MyApp());
}

void permission() {
  Permission.storage.request();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    permission();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
