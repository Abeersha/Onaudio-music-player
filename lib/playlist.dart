import 'package:audio3/refactoring/drawer.dart';
import 'package:flutter/material.dart';

class Playlist extends StatelessWidget {
  const Playlist ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
          title: const Text("Playlists"),
        centerTitle: true,
        // leading: Icon(Icons.settings),
        actions: [Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(Icons.add),
        )],
        
      ),
        
      
      body: Column(
        
        children: const [
          ListTile(
            leading: Icon(Icons.favorite,color: Colors.red,),
            title: Text('Favourites'),
            subtitle: Text('40 songs'),
            trailing: Icon(Icons.more_vert_rounded,),
          ),
           ListTile(
            leading: Icon(Icons.phone_android,color: Colors.black,),
            title: Text('Recently Added'),
             subtitle: Text('40 songs'),
            trailing: Icon(Icons.more_vert_rounded),
          ),
           ListTile(
            leading: Icon(Icons.music_note_outlined,color: Colors.black,),
            title: Text('Most Played'),
             subtitle: Text('40 songs'),
            trailing: Icon(Icons.more_vert_rounded),
          ),
           ListTile(
            leading: Icon(Icons.music_note_rounded,color: Colors.black,),
            title: Text('Recently Added'),
             subtitle: Text('40 songs'),
            trailing: Icon(Icons.more_vert_rounded),
          ),
               ListTile(
            leading: Icon(Icons.playlist_add,color: Colors.black,),
            title: Text('My Playlist'),
             subtitle: Text('40 songs'),
            trailing: Icon(Icons.more_vert_rounded),
          ),




        ],
      ),
        
      );
      
    
  }
}