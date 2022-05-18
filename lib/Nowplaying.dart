import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Nowplaying extends StatefulWidget {
  int? index = 0;
  List<SongModel>? songModel2;
  List<Audio> allSongs;
  Nowplaying({Key? key, required this.allSongs, this.index, this.songModel2})
      : super(key: key);

  @override
  _NowplayingState createState() => _NowplayingState();
}

class _NowplayingState extends State<Nowplaying> {
  final assetAudioplayer = AssetsAudioPlayer.withId('music');
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    assetAudioplayer.open(
      Playlist(
        audios: widget.allSongs,
        startIndex: widget.index!,
      ),
      autoStart: true,
      notificationSettings: const NotificationSettings(stopEnabled: false),
      showNotification: true,
    );
  }

  // double _currentSliderValue = 20;
  @override
  Widget build(BuildContext context) {
    List<SongModel> songmodel = [];
    if (widget.songModel2 == null) {
      _audioQuery.querySongs().then((value) {
        songmodel = value;
      });
    } else {
      songmodel = widget.songModel2!;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Now Playing"),
        centerTitle: true,
        // leading: Icon(Icons.settings),
        actions: [
          Icon(
            Icons.arrow_drop_down_sharp,
            size: 40,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 128, 120, 120), Colors.white])),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: assetAudioplayer.builderCurrent(builder: ((context, playing) {
            return Center(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Text(
                      '${playing.playlist.current.metas.title}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 250,
                    width: 250,
                    child: QueryArtworkWidget(
                        artworkBorder: BorderRadius.circular(12),
                        artworkFit: BoxFit.cover,
                        nullArtworkWidget: Icon(Icons.music_note, size: 400),
                        size: 200,
                        id: int.parse(playing.playlist.current.metas.id!),
                        type: ArtworkType.AUDIO),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${playing.playlist.current.metas.artist}',
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  assetAudioplayer.builderRealtimePlayingInfos(
                      builder: (context, RealtimePlayingInfos? infos) {
                    if (infos == null) {
                      return SizedBox();
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: ProgressBar(
                        progress: infos.currentPosition,
                        total: infos.duration,
                        onSeek: (duration) {
                          assetAudioplayer.seek(duration);
                        },
                      ),
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.playlist_add),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.skip_previous_rounded),
                      ),
                      assetAudioplayer.builderIsPlaying(
                          builder: ((context, isPlaying) {
                        return IconButton(
                            onPressed: () {
                              if (isPlaying) {
                                assetAudioplayer.pause();
                              } else {
                                assetAudioplayer.play();
                              }
                            },
                            icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow));
                      })),
                      IconButton(
                        onPressed: () {
                          assetAudioplayer.next();
                        },
                        icon: Icon(Icons.skip_next),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                    ],
                  ),
                ],
              ),
            ));
          })),
        ),
      ),
    );
  }
}
