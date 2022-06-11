import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio3/Model/model.dart';
import 'package:audio3/music_home.dart';
import 'package:audio3/playlist/playlistfunction.dart';
import 'package:audio3/splash_screen.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({
    Key? key,
  }) : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

bool isRepeat = false;

class _NowPlayingState extends State<NowPlaying>
    with SingleTickerProviderStateMixin {
  // bool _isPLaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      // ########## GRADIENT THEME ##########

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 78, 16, 13),
            Color.fromARGB(255, 66, 34, 34),
            Colors.black,
          ],
        ),
      ),

// ########## PLAY-PAUSE-NEXT-PREVIOUS ##########

      child: player.builderCurrent(
        builder: (context, playing) {
          int index = playing.index;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 30,
                width: 300,
                child: Marquee(
                  velocity: 20,
                  blankSpace: 50,

                  text: '${playing.playlist.current.metas.title}',
                  //textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              SizedBox(
                height: 30,
                width: 150,
                child: Marquee(
                  blankSpace: 20,
                  velocity: 20,
                  text: '${playing.playlist.current.metas.artist}',
                  //textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 3, 2, 2),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 43, right: 42, bottom: 20),
                child: SizedBox(
                  height: 400,
                  width: 450,
                  child: QueryArtworkWidget(
                      artworkBorder: BorderRadius.circular(20),
                      artworkFit: BoxFit.cover,
                      artworkQuality: FilterQuality.high,
                      quality: 100,
                      nullArtworkWidget: Image.asset("assets/image.jpg"),
                      size: 300,
                      id: int.parse(playing.playlist.current.metas.id!),
                      type: ArtworkType.AUDIO),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              //<<<<<+_Pl_&_Fav>>>>>//

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        dialogBox(context, allSongs, index);
                      },
                      icon: const Icon(
                        Icons.playlist_add_rounded,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    const Spacer(),
                    Builder(builder: (context) {
                      favouriteAllsongs = box.get('favourites') ?? [];

                      //  final box =    Boxes.getInstance(boxname);

                      bool isAdded = favouriteAllsongs
                          .where((element) =>
                              element.id == allSongs[index].id.toString())
                          .isNotEmpty;

                      return IconButton(
                        onPressed: () {
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            final snackBar = SnackBar(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              backgroundColor: Colors.white,
                              content: const Text(
                                'Song removed from favourites',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            int favoriteSongIndex =
                                favouriteAllsongs.indexWhere((element) =>
                                    element.id == dbSongs[index].id);

                            favouriteAllsongs.removeAt(favoriteSongIndex);

                            box.put('favourites', favouriteAllsongs);
                          }
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: isAdded ? Colors.red : Colors.white,
                          size: 30,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              //<<<<<SeekBar>>>>>//
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: seekBarWidget(context),
              ),
              const SizedBox(
                height: 20,
              ),

              //<<<<<Playing_Controls>>>>>//
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //
                    //<<<<<Shuffle>>>>>//
                    IconButton(
                      onPressed: () {
                        player.toggleShuffle();

                        setState(() {});
                      },
                      icon: Icon(
                        Icons.shuffle,
                        size: 28,
                        color: player.isShuffling.value
                            ? Colors.grey
                            : Colors.white,
                      ),
                    ),

                    //<<<<<Previous>>>>>//
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, right: 10),
                      child: IconButton(
                        onPressed: () {
                          player.previous();
                        },
                        icon: const Icon(
                          Icons.skip_previous_sharp,
                          size: 48,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    //<<<<<Play_Pause>>>>>//
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: player.builderIsPlaying(
                        builder: ((context, isPlaying) {
                          return IconButton(
                            icon: Icon(
                              isPlaying
                                  ? Icons.pause_circle
                                  : Icons.play_circle,
                              size: 58,
                            ),
                            onPressed: () {
                              player.playOrPause();
                            },
                            color: Colors.white,
                          );
                        }),
                      ),
                    ),

                    //<<<<<Next>>>>>//
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, right: 10),
                      child: IconButton(
                        onPressed: playing.index == allSongs.length - 1
                            ? () {}
                            : () {
                                player.next();
                              },
                        icon: playing.index == allSongs.length - 1
                            ? const Icon(
                                Icons.skip_next_sharp,
                                size: 48,
                                color: Color.fromARGB(255, 94, 91, 66),
                              )
                            : const Icon(
                                Icons.skip_next,
                                size: 48,
                                color: Colors.white,
                              ),
                      ),
                    ),

                    //<<<<<Repeat>>>>>//
                    IconButton(
                      onPressed: () {
                        if (isRepeat) {
                          player.setLoopMode(LoopMode.none);
                          isRepeat = false;
                        } else {
                          player.setLoopMode(LoopMode.single);
                          isRepeat = true;
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.repeat,
                        size: 28,
                        color: isRepeat ? Colors.grey : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    ));
  }

  // ########## SEEK BAR ##########

  Widget seekBarWidget(BuildContext ctx) {
    return player.builderRealtimePlayingInfos(
      builder: (ctx, infos) {
        Duration currentPosition = infos.currentPosition;
        Duration total = infos.duration;
        return Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ProgressBar(
              progress: currentPosition,
              total: total,
              onSeek: (to) {
                player.seek(to);
              },
              timeLabelTextStyle: const TextStyle(color: Colors.white),
              baseBarColor: const Color.fromARGB(255, 19, 0, 0),
              progressBarColor: const Color.fromARGB(255, 68, 16, 9),
              bufferedBarColor: Colors.red,
              thumbColor: const Color.fromARGB(255, 97, 2, 2)),
        );
      },
    );
  }
}
