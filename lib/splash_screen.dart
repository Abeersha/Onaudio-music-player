import 'dart:async';


import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio3/home.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'Model/model.dart';

 List<Songsdb> dbSongs = [];

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
   initState() {
    fetchSongs();
    _navigatetohome();
    super.initState();
  }

  final assetAudioPlayer = AssetsAudioPlayer.withId("0");
  List<Audio> audiosongs = [];
  final _audioQuery = OnAudioQuery();
  List<SongModel> fetchedSongs = [];
  List<SongModel> allsong =[];
    List<Songsdb> mappedSongs = [];
    // List<Songsdb> dbSongs = [];
  final box = Boxes.getInstance();

  fetchSongs() async {
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuery.permissionsRequest();
    }

    allsong = await _audioQuery.querySongs();

    mappedSongs = allsong
        .map((e) {
          return Songsdb(
            title: e.title,
            id: e.id.toString(),
            image: e.uri!,
            duration: e.duration.toString(),
            artist: e.artist);
        })
        .toList();





    await box.put("musics", mappedSongs);
    dbSongs = box.get("musics") as List<Songsdb>;
    

    for (var e in dbSongs) {
      audiosongs.add(Audio.file(e.image.toString(),
          metas: Metas(
              title: e.title,
              id: e.id.toString(),
              artist: e.artist)));
    }
    setState(() {});
  }




  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 3500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MusicHome()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 0, 0, 0),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Container(child: Image.asset('assets/image.jpg')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


