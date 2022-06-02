import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio3/Nowplaying.dart';
import 'package:audio3/music_home.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return player.builderCurrent(
      builder: (context, playing) {
        // final myAudio = find(songDetails, playing.audio.assetAudioPath);
        return Container(
          color: Colors.black,
          height: 70,
          child: ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NowPlaying()),
            ),
            title: SizedBox(
              height: 18,
              child: SizedBox(
                height: 30,
                width: 300,
                child: Marquee(
                  velocity: 20,
                  blankSpace: 20,
                  text: player.getCurrentAudioTitle,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ),
            subtitle: Text(
              player.getCurrentAudioArtist.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Wrap(
              alignment: WrapAlignment.center,
              children: [
                //  previous
                IconButton(
                  onPressed: () {
                    player.previous();
                  },
                  icon: const Icon(
                    Icons.skip_previous_rounded,
                    color: Colors.white,
                    size: 43,
                  ),
                ),

                // play pause
                PlayerBuilder.isPlaying(
                  player: player,
                  builder: (context, isPlaying) {
                    return IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle,
                        size: 43,
                      ),
                      onPressed: () {
                        player.playOrPause();
                      },
                      color: Colors.white,
                    );
                  },
                ),

                IconButton(
                  onPressed: playing.index == allSongs.length - 1
                      ? () {}
                      : () {
                          player.next();
                        },
                  icon: playing.index == allSongs.length - 1
                      ? const Icon(
                          Icons.skip_next_sharp,
                          size: 40,
                          color: Color.fromARGB(255, 241, 240, 225),
                        )
                      : const Icon(Icons.skip_next_sharp,
                          size: 40, color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
