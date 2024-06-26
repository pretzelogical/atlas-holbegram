import 'package:flutter/material.dart';
import 'package:holbegram/utils/posts.dart';

class Feed extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Holbegram', style: TextStyle(fontFamily: 'Billabong', fontSize: 32)),
            Image(
              image: AssetImage('assets/images/logo.webp'),
              width: 50,
              height: 50,
            )
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () {},
          )
        ],
      ),
      // TODO: Add feed widget
      body: const Posts(),
    );
  }
}