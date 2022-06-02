import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio3/Nowplaying.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

import 'music_home.dart';

class Favourite extends StatefulWidget {
   // ignore: prefer_const_constructors_in_immutables
   Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
        centerTitle: true,
        backgroundColor: Colors.black,
        // actions: [
        //   IconButton(
        //     onPressed: () async {
        //       await audioRoom.clearRoom(RoomType.FAVORITES);
        //       setState(() {});
        //     },
        //     icon: const Icon(Icons.delete_forever_rounded),
        //   )
        // ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                  Color.fromARGB(255, 80, 74, 80),
                  Color.fromARGB(255, 66, 34, 34),
                  Colors.black,
                ],
              // colors: [
              //   Colors.black,
              //   Color.fromARGB(255, 53, 135, 218),
              //   Colors.black,
              // ]),
          )
        ),
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder<List<FavoritesEntity>>(
          future: OnAudioRoom().queryFavorites(
            limit: 50,
            reverse: false,
            sortType: null, //  Null will use the [key] has sort.
          ),
          builder: (context,AsyncSnapshot<List<FavoritesEntity>> item) {
          
            if (item.data == null || item.data!.isEmpty) {
            
              return Center(
                child: Text(
                  'Nothing Found',
                  style: GoogleFonts.montserrat(color: Colors.white),
                ),
              );
            }

            List<FavoritesEntity> favorites = item.data!;
            List<Audio> favSongs = [];

            for (var songs in favorites) {
              favSongs.add(Audio.file(songs.lastData,
                  metas: Metas(
                      title: songs.title,
                      artist: songs.artist,
                      id: songs.id.toString(),),),);
            }

            return Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding:
                        EdgeInsets.only(left: 20, right: 20, bottom: 8, top: 8),
                    child: Divider(
                      thickness: 3.0,
                    ),
                  );
                },
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      await player.open(
                          Playlist(audios: favSongs, startIndex: index),
                          showNotification: true,
                          loopMode: LoopMode.playlist,
                          notificationSettings:
                              const NotificationSettings(stopEnabled: false));
                    },
                    title: Text(
                      favorites[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color.fromARGB(255, 202, 197, 197),
                      ),
                    ),
                    leading: QueryArtworkWidget(
                      id: favorites[index].id,
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(300),
                        ),
                        child: Image.asset(
                          'assets/music.jpeg',
                          fit: BoxFit.cover,
                          width: 60,
                          height: 60,
                        ),
                      ),
                    ),
                  );

                  // return ListTile(

                  //   title: Text(favorites[index].title),
                  //   subtitle: Text(favorites[index].dateAdded.toString()),
                  //   // onTap: () async {

                  //   //   //  Most the method will return a bool to indicate if method works.
                  //   //   await audioRoomone.deleteFrom(
                  //   //     RoomType.FAVORITES,
                  //   //     favorites[index].key,
                  //   //   );
                  //   //   //  Call setState to see the result,
                  //   //   setState(() {});
                  //   // },
                  // );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
