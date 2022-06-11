import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio3/Model/model.dart';
import 'package:audio3/Nowplaying.dart';
import 'package:audio3/main.dart';
import 'package:audio3/playlist/playlistfunction.dart';
import 'package:audio3/search1.dart';
import 'package:audio3/settings.dart';

import 'package:audio3/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

final audioquery = OnAudioQuery();
List<SongModel> allSongs = [];
List<Audio> songDetails = [];
List favouriteAllsongs = [];

late Box box;

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    box = Boxes.getInstance(boxname);

    // print(favouriteAllsongs);

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
    // print(dbSongs.length.toString());

    return Scaffold(
      drawer: drawer(),

//===========AppBar===============//

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          '${dbSongs.length} songs',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: deligatesearch(),
                  );
                },
                icon: const Icon(Icons.search)),
          )
        ],
        centerTitle: true,
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
          ),
        ),

        child: ListView.builder(
          itemCount: dbSongs.length,
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
                        favouriteAllsongs = box.get('favourites') ?? [];

                        //  final box =    Boxes.getInstance(boxname);

                        bool isAdded = favouriteAllsongs
                            .where((element) =>
                                element.id == allSongs[index].id.toString())
                            .isNotEmpty;

                        if (!isAdded) {
                          favouriteAllsongs.add(Songsdb(
                            title: allSongs[index].title,
                            artist: allSongs[index].artist,
                            duration: allSongs[index].duration.toString(),
                            id: allSongs[index].id.toString(),
                            songUri: allSongs[index].uri,
                          ));

                          box.put('favourites', favouriteAllsongs);

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
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                         else {
                          final snackBar = SnackBar(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            backgroundColor: Colors.white,
                            content: const Text(
                              'Already added to favourites',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      trailingIcon: const Icon(Icons.favorite)),
                  FocusedMenuItem(
                      title: const Text("Add to playlists "),
                      onPressed: () {
                        {
                          dialogBox(context, allSongs, index);
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
                    leading: buildImageSong(index),
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(dbSongs[index].title!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  QueryArtworkWidget buildImageSong(int index) {
    return QueryArtworkWidget(
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
