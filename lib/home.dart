
import 'package:audio3/Nowplaying.dart';
import 'package:audio3/favorites.dart';
import 'package:audio3/music_home.dart';
import 'package:audio3/playlist.dart';

import 'package:flutter/material.dart';

class MusicHome extends StatefulWidget {
  const MusicHome ({ Key? key }) : super(key: key);

  @override
  State<MusicHome> createState() => _MusicHomeState();
}

class _MusicHomeState extends State<MusicHome> {

int _currentSelectedIndex = 0;

  final _pages = [
  
    Home(),
    
    Favorites(),
    Playlist(),
    // Album(),

    // ScreenPayment(),
    // ScreenAccount(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: _pages[_currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        currentIndex: _currentSelectedIndex,
        onTap: (newIndex) {
          setState(() {
            _currentSelectedIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Music'),
          // BottomNavigationBarItem(icon: Icon(Icons.headset), label: 'Now Playing'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourites'),
          BottomNavigationBarItem(icon: Icon(Icons.playlist_add), label: 'Playlist'),
          // BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Albums'),
          // BottomNavigationBarItem(icon: Icon(Icons.payment),label: 'Payment'),
          // BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
//       appBar: AppBar(
//         title: const Text("MusicHome"),
        
//       ),
//       body: const Center(
//         child: Text("Music Home"),
//       ),
//     );
//   }
// }