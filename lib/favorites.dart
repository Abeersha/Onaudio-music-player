import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio3/Model/model.dart';
import 'package:audio3/Nowplaying.dart';
import 'package:audio3/main.dart';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
        )),
        height: double.infinity,
        width: double.infinity,
        child: ValueListenableBuilder<Box<List>>(
            valueListenable: Boxes.getInstance(boxname).listenable(),
            builder: (context, box, _) {
              List favSongs = box.get('favourites') ?? [];

              return Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 8, top: 8),
                      child: Divider(
                        thickness: 3.0,
                      ),
                    );
                  },
                  itemCount: favSongs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () async {
                        List<Audio> convertedFavouritesSongs = [];

                        for (var song in favSongs) {
                          convertedFavouritesSongs.add(
                            Audio.file(
                              song.songUri!,
                              metas: Metas(
                                title: song.title,
                                artist: song.artist,
                                id: song.id.toString(),
                              ),
                            ),
                          );
                        }

                        await player.open(
                            Playlist(
                                audios: convertedFavouritesSongs,
                                startIndex: index),
                            showNotification: true,
                            loopMode: LoopMode.playlist,
                            notificationSettings:
                                const NotificationSettings(stopEnabled: false));
                      },
                      title: Text(
                        favSongs[index].title!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 202, 197, 197),
                        ),
                      ),
                      leading: QueryArtworkWidget(
                        id: int.parse(favSongs[index].id!),
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
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content:
                                  const Text('Do you really want to delete?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('NO'),
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        favSongs.removeAt(index);

                                        box.put('favourites', favSongs);
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('YES')),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    );
                  },
                ),
              );
            }),
      ),
    );
  }
}
