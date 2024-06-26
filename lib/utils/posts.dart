import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/models/posts.dart';
import 'package:holbegram/methods/post_storage.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var data = snapshot.data!.docs;
          final posts = data.map((e) => PostModel.fromSnapshot(e)).toList();

          return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  for (var post in posts) Post.fromModel(post),
                  const Post(
                      profilePictureUrl:
                          "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png",
                      pictureUrl:
                          "https://placehold.co/400x400/black/white.png",
                      username: "Username",
                      caption: "Caption",
                      likes: 5,
                      postId: "test"),
                ],
              ));
        });
  }
}

class Post extends StatelessWidget {
  final String profilePictureUrl;
  final String pictureUrl;
  final String username;
  final String caption;
  final int likes;
  final String postId;

  const Post(
      {super.key,
      required this.profilePictureUrl,
      required this.pictureUrl,
      required this.username,
      required this.caption,
      required this.likes,
      required this.postId});

  factory Post.fromModel(PostModel post) {
    return Post(
        profilePictureUrl: post.profImage,
        pictureUrl: post.postUrl,
        username: post.username,
        caption: post.caption,
        likes: post.likes.length,
        postId: post.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipOval(
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  profilePictureUrl,
                  width: 50,
                  height: 50,
                ),
              ),
              Text(username)
            ],
          ),
          IconButton(
            icon: const Icon(Icons.more_outlined),
            onPressed: () async {
              if (postId == 'test') {
                return;
              }
              final String result = await PostStorage().deletePost(postId);
              if (result == 'Success') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Post Deleted')),
                );
                return;
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result)),
              );
            },
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        child: Column(
          children: [
            Text(caption),
            ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                  width: 380, height: 380, child: Image.network(pictureUrl)),
            )
          ],
        ),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.mode_comment_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () {},
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.bookmark_outline),
          onPressed: () {},
        )
      ]),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text('$likes likes')],
        ),
      )
    ]));
  }
}
