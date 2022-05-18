import 'package:audio3/refactoring/drawer.dart';
import 'package:audio3/refactoring/fact_songs.dart';
import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Favourites"),
        centerTitle: true,
        // leading: const Icon(Icons.settings),
        actions: [Padding(
          padding: const EdgeInsets.only(right: 7),
          child: Icon(Icons.search),
        )],
      ),
      body: ListView(
        
        children: const [
          favoriteslist(
              Imagethump: 'assets/images/anne.jpg',
              Songtitle: 'Anne With An E'),
          favoriteslist(
              Imagethump: 'assets/images/anne.jpg',
              Songtitle: 'Anne With An E'),
          favoriteslist(
              Imagethump: 'assets/images/anne.jpg',
              Songtitle: 'Anne With An E'),
          favoriteslist(
              Imagethump: 'assets/images/anne.jpg',
              Songtitle: 'Anne With An E'),
              favoriteslist(
              Imagethump: 'assets/images/anne.jpg',
              Songtitle: 'Anne With An E'),
              favoriteslist(
              Imagethump: 'assets/images/anne.jpg',
              Songtitle: 'Anne With An E'),
              favoriteslist(
              Imagethump: 'assets/images/anne.jpg',
              Songtitle: 'Anne With An E'),
              favoriteslist(
              Imagethump: 'assets/images/anne.jpg',
              Songtitle: 'Anne With An E'),
        ],
      ),
    );
  }
}
