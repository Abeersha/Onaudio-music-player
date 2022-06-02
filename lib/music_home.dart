import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio3/Nowplaying.dart';
import 'package:audio3/playlist/playlistfunction.dart';
import 'package:audio3/settings.dart';

import 'package:audio3/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

final OnAudioRoom audioRoom = OnAudioRoom();
final audioquery = OnAudioQuery();
List<SongModel> allSongs = [];
List<Audio> songDetails = [];

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() async {
    Permission.storage.request();
    allSongs = await audioquery.querySongs();
    for (var i in allSongs) {
      songDetails.add(Audio.file(i.uri.toString(),
          metas: Metas(
              title: i.title,
              artist: i.artist,
              id: i.id.toString(),
              album: i.album)));
    }
  }

  @override
  Widget build(BuildContext context) {
    print(dbSongs.length.toString());

    return Scaffold(
       drawer: drawer(),

//===========AppBar===============//

      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.arrow_back,
        //       color: Colors.yellow,
        //     )),
        backgroundColor: Colors.black,
        title: Text(
          '${dbSongs.length} songs',
          // style: TextStyle(
          //     color: Color.fromARGB(255, 233, 217, 72),
          //     fontWeight: FontWeight.w600,
          //     fontSize: 30,
          //     fontStyle: FontStyle.italic),
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          )
        ],
        centerTitle: true,
      ),
      body: FutureBuilder<List<SongModel>>(
        future: audioquery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return const Center(
              child: Text(
                'No Songs to Display',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return Container(
            decoration: const BoxDecoration(
              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(18), topRight: Radius.circular(18)),
              // color: Colors.grey[200],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 80, 74, 80),
                  Color.fromARGB(255, 66, 34, 34),
                  Colors.black,
                ],
              ),
            ),
            child: ListView.builder(
              itemCount: item.data!.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 85,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 110, 21, 21),
                        Color.fromARGB(255, 13, 14, 14),
                      ],
                    ),
                  ),
                  child: FocusedMenuHolder(
                    menuItems: [
                      FocusedMenuItem(
                          title: const Text("Add to favourites"),
                          onPressed: () {
                            audioRoom.addTo(
                              RoomType.FAVORITES, // Specify the room type
                              allSongs[index].getMap.toFavoritesEntity(),
                              ignoreDuplicate: false, // Avoid the same song
                            );
                            final snackBar = SnackBar(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                backgroundColor: Colors.white,
                                content: const Text(
                                  ' Added to favourites',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                          },
                          trailingIcon: const Icon(Icons.favorite)),
                      FocusedMenuItem(
                          title: const Text("Add to playlists "),
                          onPressed: () {
                            {
                              dialogBox(context, allSongs, audioRoom, index);

                            }
                          },
                          trailingIcon: const Icon(Icons.playlist_add))
                    ],
                    onPressed: () {},
                    child: Center(
                      child: ListTile(
                        onTap: () async {
                          await player.open(
                              Playlist(audios: songDetails, startIndex: index),
                              showNotification: true,
                              loopMode: LoopMode.playlist,
                              notificationSettings:
                                  const NotificationSettings(stopEnabled: false));
                        },
                        leading: QueryArtworkWidget(
                          artworkHeight: 60,
                          artworkWidth: 60,
                          size: 600,
                          id: int.parse(dbSongs[index].id!),
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(300),
                            ),
                            child: Image.asset(
                              'assets/image.jpg',
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ),
                        title: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(dbSongs[index].title!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white)),
                        ),
                        // trailing: Wrap(children: [
                        //   IconButton(
                        //       onPressed: () {
                        //         audioRoom.addTo(
                        //           RoomType.FAVORITES, // Specify the room type
                        //           allSongs[index].getMap.toFavoritesEntity(),
                        //           ignoreDuplicate: false, // Avoid the same song
                        //         );
                        //       },
                        //       icon: const Icon(
                        //         Icons.favorite,
                        //         color: Colors.white,
                        //       )),
                        //   IconButton(
                        //       onPressed: () {
                        //         dialogBox(context, allSongs, audioRoom, index);
                        //       },
                        //       icon: const Icon(Icons.playlist_add)),
                        // ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void songsLibrary(int index, List<Audio> audios) async {
  await player.open(
    Playlist(
      audios: audios,
      startIndex: index,
    ),
    showNotification: true,
    notificationSettings: const NotificationSettings(
      stopEnabled: false,
    ),
    playInBackground: PlayInBackground.enabled,
  );
}
