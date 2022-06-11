import 'package:audio3/Model/model.dart';
import 'package:audio3/Model/playlist_model.dart';
import 'package:audio3/music_home.dart';
import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

void dialogBox(
  BuildContext context,
  List<SongModel> allsongs,
  int songIndex,
) {
  showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(builder: (context, setState) {
            return SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                    createPlaylist(
                      ctx,
                      setState,
                    );
                  },
                  child: const Text('New Playlist'),
                ),
                SimpleDialogOption(
                    child: SizedBox(
                  height: 120,
                  width: 200,
                  child: ValueListenableBuilder<Box<ModelPlaylist>>(
                      valueListenable:
                          Hive.box<ModelPlaylist>('playlists').listenable(),
                      builder: (context, box, _) {
                        List<ModelPlaylist> playlistDetails =
                            box.values.toList();

                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: playlistDetails.length,
                          itemBuilder: (ctx, index) => ListTile(
                            onTap: () {
                              ModelPlaylist? modelPlaylist = box.getAt(index);

                              List<Songsdb> playlistNewSongs =
                                  modelPlaylist!.playlistSongs;

                              bool isAlreadyAdded = playlistNewSongs
                                  .where((element) =>
                                      element.id ==
                                      allSongs[songIndex].id.toString())
                                  .isNotEmpty;

                              if (!isAlreadyAdded) {
                                playlistNewSongs.add(Songsdb(
                                  title: allsongs[songIndex].title,
                                  artist: allsongs[songIndex].artist,
                                  duration:
                                      allsongs[songIndex].duration.toString(),
                                  id: allsongs[songIndex].id.toString(),
                                  songUri: allsongs[songIndex].uri,
                                ));

                                box.putAt(
                                  index,
                                  ModelPlaylist(
                                      playlistSongs: playlistNewSongs,
                                      playlistName:
                                          playlistDetails[index].playlistName),
                                );

                                final snackBar = SnackBar(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  backgroundColor: Colors.white,
                                  content: const Text(
                                    ' Added to playlists',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                final snackBar = SnackBar(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  backgroundColor: Colors.white,
                                  content: const Text(
                                    'Already exists!!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }

                              Navigator.pop(ctx);
                            },
                            title: Text(playlistDetails[index].playlistName!),
                          ),
                          separatorBuilder: (ctx, index) => const SizedBox(
                            height: 18,
                          ),
                        );
                      }),
                ))
              ],
            );
          }));
}

void createPlaylist(
  BuildContext ctx,
  void Function(void Function()) setState,
) {}

//ADD NEW PLAYLIST BUTTON

void createPlaylistFrom(
  BuildContext ctx,
  VoidCallback refresh,
) {
  final playlistNameController = TextEditingController();

  showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (ctx1) => AlertDialog(
            content: TextField(
                controller: playlistNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  //filled: true,
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  hintText: 'Playlist Name',
                )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    final box = Hive.box<ModelPlaylist>('playlists');

                    box.add(
                      ModelPlaylist(
                        playlistSongs: [],
                        playlistName: playlistNameController.text,
                      ),
                    );

                    refresh();
                    Navigator.pop(ctx);
                  },
                  child: const Text('Ok'))
            ],
          ));
}

// void createNewPlaylist(String name,) {
//   if (name.isEmpty && name == '') {
//     print(".......................Alalalaallaalalal.....");
//     SnackBar(
//       content: Text('Name Something'),
//       action: SnackBarAction(label: ('Type Something'), onPressed: () {}),
//     );
//   } else {
//     print('Creeeeeeeeeeated');
//   }
// }
