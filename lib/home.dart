import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio3/favorites.dart';
import 'package:audio3/miniscreen.dart';
import 'package:audio3/music_home.dart';
import 'package:audio3/playlist/playlist.dart';

import 'package:flutter/material.dart';

class MusicHome extends StatefulWidget {
  const MusicHome({Key? key}) : super(key: key);

  @override
  State<MusicHome> createState() => _MusicHomeState();
}

class _MusicHomeState extends State<MusicHome> {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.withId('0');

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  int _currentSelectedIndex = 0;

  final _pages = [
    const Home(),
    Favourite(),
    const playlistscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentSelectedIndex],
      bottomSheet: const MiniPlayer(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        currentIndex: _currentSelectedIndex,
        onTap: (newIndex) {
          setState(() {
            _currentSelectedIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Music'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add), label: 'Playlist'),
        ],
      ),
    );
  }
}
