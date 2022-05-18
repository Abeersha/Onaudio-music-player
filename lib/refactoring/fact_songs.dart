
import 'package:audio3/Nowplaying.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SongsList extends StatelessWidget {
  final songthumb;
  final songname;
  final songartist;
  final songicon;

  const SongsList({
    Key? key,
    required this.songthumb,
    required this.songname,
    required this.songartist,
    this.songicon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 25, 5, 0),
      child: GestureDetector(onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Nowplaying()));
      },
        child: Container(
       
          
          width: MediaQuery.of(context).size.width,
          height: 90,
          decoration: BoxDecoration(color: Colors.grey[300]),
          
          child: Row(
            children: [
              Container(
                
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(songthumb))),
              ),
              Spacer(
                flex: 1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    songname,
                    style: GoogleFonts.roboto(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone_android,size: 9,),
                      Text(
                        songartist,
                        style: GoogleFonts.roboto (
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert_rounded,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// album

class Albumgrid extends StatelessWidget {
  final albumthump;
  final albumname;

  const Albumgrid({
    Key? key,
    required this.albumthump,
    required this.albumname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(5),
      width: 100,
      height: 130,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Container(
            height: 170,
            width: 210,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(albumthump),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
          Text(albumname),
        ],
      ),
    );
  }
}

//  playlist

class favoriteslist extends StatelessWidget {
  final String Imagethump;
  final String Songtitle;

  const favoriteslist(
      {Key? key, required this.Imagethump, required this.Songtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Color.fromARGB(255, 236, 234, 227),
        height: 80,
        width: size.width * 0.955,
        child: Row(
          children: [
            // image container

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 65,
                width: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Imagethump), fit: BoxFit.fill)),
              ),
            ),
            // songtitle

            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Songtitle,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.phone_android,
                        size: 15,
                      ),
                      Text('Unknown Artist'),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            const SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
    );
  }
}
