import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio3/Model/model.dart';
import 'package:audio3/Model/playlist_model.dart';
import 'package:audio3/Nowplaying.dart';
import 'package:audio3/miniscreen.dart';
import 'package:audio3/music_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class PlaylistInfo extends StatefulWidget {
  List<Songsdb> songs;
  String title;
  int playlistIndex;

  PlaylistInfo({
    Key? key,
    required this.title,
    required this.songs,
    required this.playlistIndex,
  }) : super(key: key);

  @override
  State<PlaylistInfo> createState() => _PlaylistInfoState();
}

class _PlaylistInfoState extends State<PlaylistInfo> {
  @override
  Widget build(BuildContext context) {
    // List<Audio> songs = [];
    // for (var song in allSongs) {
    //   songs.add(
    //     Audio.file(
    //       song.uri.toString(),
    //       metas: Metas(
    //         title: song.title,
    //         artist: song.artist,
    //         id: song.id.toString(),
    //       ),
    //     ),
    //   );
    // }

    
    List<Audio> playlistSong = [];
    for (var song in widget.songs) {
      playlistSong.add(Audio.file(song.songUri!,
          metas: Metas(
              title: song.title, artist: song.artist, id: song.id.toString())));
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: Text(
          widget.title.capitalise(),
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
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
              ]),
        ),
        height: double.infinity,
        width: double.infinity,
        child: playlistSong.isEmpty
            ? const Center(
                child: Text('Nothing Found'),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 8, top: 8),
                      child: Divider(
                        thickness: 3,
                      ),
                    );
                  },
                  itemBuilder: (ctx, index) => Slidable(
                    endActionPane: ActionPane(
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            setState(() {
                              final box = Hive.box<ModelPlaylist>('playlists');

                              widget.songs.removeAt(index);

                              box.putAt(
                                widget.playlistIndex,
                                ModelPlaylist(
                                  playlistSongs: widget.songs,
                                  playlistName: widget.title,
                                ),
                              );
                            });
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 131, 33, 33),
                          foregroundColor:
                              const Color.fromARGB(255, 14, 12, 12),
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                      motion: const ScrollMotion(),
                    ),
                    child: ListTile(
                      onTap: () async {
                        await player.open(
                            Playlist(audios: playlistSong, startIndex: index),
                            showNotification: true,
                            loopMode: LoopMode.playlist,
                            notificationSettings:
                                const NotificationSettings(stopEnabled: false));
                      },
                      title: Text(
                        widget.songs[index].title!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 202, 197, 197),
                        ),
                      ),
                      // subtitle: Text(widget.songs[index].artist!),
                      leading: QueryArtworkWidget(
                        id: int.parse(widget.songs[index].id!),
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: ClipRRect(
                          child: Image.asset(
                            "assets/image.jpg",
                            fit: BoxFit.cover,
                            width: 40,
                            height: 40,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                    //itemCount: widget.songs.length,
                  ),
                  itemCount: widget.songs.length,
                ),
              ),
      ),
      bottomSheet: const MiniPlayer(),
    );
  }
}

//<<<<<Capitalize_First_Letter>>>>>//
extension CapitalExtension on String {
  String capitalise() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
