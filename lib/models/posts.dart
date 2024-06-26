import 'package:cloud_firestore/cloud_firestore.dart';


class PostModel {
  final String uid;
  final String postId;
  final String postUrl;
  final String profImage;
  final List<dynamic> likes;
  final DateTime datePublished;
  final String username;
  final String caption;

  PostModel({
    required this.uid,
    required this.postId,
    required this.postUrl,
    required this.profImage,
    required this.likes,
    required this.datePublished,
    required this.username,
    required this.caption
  });

  factory PostModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snapshotData = snapshot.data() as Map<String, dynamic>;
    return PostModel(
      uid: snapshotData['uid'],
      postId: snapshotData['postId'],
      postUrl: snapshotData['postUrl'],
      profImage: snapshotData['profImage'],
      likes: snapshotData['likes'],
      // TODO: Normalize timestamp
      datePublished: snapshotData['datePublished'],
      username: snapshotData['username'],
      caption: snapshotData['caption']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'postId': postId,
      'postUrl': postUrl,
      'profImage': profImage,
      'likes': likes,
      'datePublished': datePublished,
      'username': username,
      'caption': caption
    };
  }
}