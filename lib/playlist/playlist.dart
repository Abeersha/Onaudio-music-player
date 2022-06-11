import 'package:audio3/Model/playlist_model.dart';
import 'package:audio3/playlist/playlistfunction.dart';
import 'package:audio3/playlist/playlistinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: camel_case_types
class playlistscreen extends StatefulWidget {
  const playlistscreen({Key? key}) : super(key: key);

  @override
  State<playlistscreen> createState() => _playlistscreenState();
}

// ignore: camel_case_types
class _playlistscreenState extends State<playlistscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          title: Text(
            'Playlists',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  createPlaylistFrom(
                    context,
                    () {
                      setState(() {});
                    },
                  );
                  // _audioQuery.createPlaylist();
                },
                icon: const Icon(Icons.playlist_add))
          ],
        ),
        body: ValueListenableBuilder<Box<ModelPlaylist>>(
            valueListenable: Hive.box<ModelPlaylist>('playlists').listenable(),
            builder: (context, box, _) {
              List<ModelPlaylist> playlistDetails = box.values.toList();

              return Container(
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
                child: playlistDetails.isEmpty
                    ? const Center(
                        child: Text(
                          'No playlist',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemBuilder: (ctx, index) => Slidable(
                          endActionPane: ActionPane(
                            children: [
                              // SlidableAction(
                              //   onPressed: (context) {},
                              //   backgroundColor:
                              //       const Color.fromARGB(255, 53, 135, 218),
                              //   foregroundColor: Colors.white,
                              //   icon: Icons.edit,
                              //   label: 'Edit',
                              // ),
                              SlidableAction(
                                onPressed: (context) {
                                  setState(() {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: const Text(
                                            'Do you really want to delete?'),
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
                                                  box.deleteAt(index);
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('YES')),
                                        ],
                                      ),
                                    );
                                  });
                                },
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                            motion: const ScrollMotion(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlaylistInfo(
                                          playlistIndex: index,
                                          title: playlistDetails[index]
                                              .playlistName!,
                                          songs: playlistDetails[index]
                                              .playlistSongs,
                                        ),
                                      ),
                                    );
                                  },
                                  contentPadding:
                                      const EdgeInsets.only(left: 30),
                                  title: Text(
                                    playlistDetails[index]
                                        .playlistName!
                                        .capitalise(),
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white),
                                  ),
                                  leading: const Icon(
                                    Icons.music_note,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        separatorBuilder: (ctx, index) => const Divider(
                          thickness: 2,
                        ),
                        itemCount: playlistDetails.length,
                      ),
              );
            }));
  }
}
