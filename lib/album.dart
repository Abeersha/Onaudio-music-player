import 'package:audio3/refactoring/fact_songs.dart';
import 'package:flutter/material.dart';

class Album extends StatefulWidget {
  const Album({Key? key}) : super(key: key);

  @override
  State<Album> createState() => _AlbumState();
}

class _AlbumState extends State<Album> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Albums"),
        leading: Icon(Icons.settings),
        actions: [Icon(Icons.search)],
      ),
      body: Padding(
        
        padding: const EdgeInsets.only(top: 80),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: GridView.count(crossAxisCount: 2,
            childAspectRatio: 25/28,
            crossAxisSpacing: 12,
            mainAxisSpacing: 15,
            children: const [
              Albumgrid(albumthump: "assets/images/fios.jpeg", albumname: 'Fault In Our Stars'),
              Albumgrid(albumthump: "assets/images/callme.jpeg", albumname: 'Call Me By Your Name'),
              Albumgrid(albumthump: "assets/images/the night.jpeg", albumname: 'The Night We Met'),
              Albumgrid(albumthump: "assets/images/anne.jpg", albumname: 'Anne With An E'),
              // Albumgrid(albumthump: "assets/images/fios.jpeg", albumname: 'albumname'),
              // Albumgrid(albumthump: "assets/images/fios.jpeg", albumname: 'albumname'),


            ],),
          ),

        ),
      ),
      
    );
  }
}
