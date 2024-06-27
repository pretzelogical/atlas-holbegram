import 'package:flutter/material.dart';
import 'package:holbegram/methods/post_storage.dart';
import 'package:holbegram/models/posts.dart';

Widget makeFavoritesImage(String url) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Image.network(url),
  );
}

class Favorites extends StatefulWidget {
  final PostStorage _postStorage;
  const Favorites({
    super.key,
    required PostStorage postStorage,
  }) : _postStorage = postStorage;

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<PostModel>? posts;

  @override
  void initState() {
    super.initState();
    getFavorites();
  }

  Future<void> getFavorites() async {
    final posts = await widget._postStorage.getLiked();

    setState(() {
      this.posts = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Favorites',
                style: TextStyle(fontFamily: 'Billabong', fontSize: 32)),
          ],
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
          child: Center(
              child: posts == null
                  ? const CircularProgressIndicator()
                  : posts!.isEmpty
                      ? const Text("No favorites yet")
                      : Column(
                          children: posts!
                              .map((e) => makeFavoritesImage(e.postUrl))
                              .toList()))),
    );
  }
}
