import 'package:flutter/material.dart';

Widget makeFavoritesImage(String url) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Image.network(url),
  );
}

class Favorites extends StatelessWidget {
  const Favorites({super.key});

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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            for (var i = 0; i < 3; i++)
            // TODO: Fetch user favorites
              makeFavoritesImage(
                  'https://placehold.co/400x400/black/white.png')
          ]))),
    );
  }
}
