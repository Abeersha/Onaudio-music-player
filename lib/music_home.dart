import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio3/Nowplaying.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'refactoring/drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final assetsaudioplayer = AssetsAudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),

      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 22, 20, 20),
        title: const Text("AUDIO WAVE"),
        centerTitle: true,
        // leading: Icon(Icons.settings),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: Icon(Icons.search),
          )
        ],
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder<List<SongModel>>(
            future: _audioQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true,
            ),
            builder: (context, allsongs) {
              if (allsongs.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (allsongs.data!.isEmpty) return const Text('No Songs Found');
              List<SongModel> songmodel = allsongs.data!;
              List<Audio> songs = [];
              for (var song in songmodel) {
                songs.add(Audio.file(
                  song.uri.toString(),
                  metas: Metas(
                    title: song.title,
                    artist: song.artist,
                    id: song.id.toString(),
                  ),
                ));
              }
              return ListView.builder(
                  itemCount: allsongs.data!.length,
                  itemBuilder: (context, index) {
                    String artist = songs[index].metas.artist.toString();

                    if (artist == "<unknown>" && artist == "") {
                      artist = "No artist";
                    } else {
                      artist = songs[index].metas.artist.toString();
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ListTile(
                        onTap: () {
                          // play(songs, index);
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> Nowplaying(index:index,allSongs: songs,),),);
                        },
                        title: Text(
                          allsongs.data![index].title,
                        ),
                        subtitle: Text(artist),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.favorite)),
                            IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                          ],
                        ),
                        leading: QueryArtworkWidget(
                          artworkFit: BoxFit.cover,
                          artworkHeight: 40,
                          artworkWidth: 40,
                            id: allsongs.data![index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget:
                            ClipRRect(child: Image.asset("assets/image.jpg",fit: BoxFit.cover,width: 40,height: 40,),borderRadius: const BorderRadius.all(Radius.circular(20)),),),
                          
                            ),
                      // ignore: dead_code
                      );
                    
                  });
            }),
      ),
      // songlist(),
    );
  }

  bool notification = true;
  void play(List<Audio> audio, int index) {
    assetsaudioplayer.open(Playlist(audios: audio, startIndex: index),
        showNotification: notification,
        notificationSettings: NotificationSettings(stopEnabled: false));
  }
}
