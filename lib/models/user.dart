import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String? username;
  final String? email;
  final String? bio;
  final String? photoUrl;
  final String? searchKey;
  final List<dynamic>? following;
  final List<dynamic>? followers;
  final List<dynamic>? posts;
  final List<dynamic>? saved;


  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    this.bio,
    this.photoUrl,
    this.searchKey,
    this.following,
    this.followers,
    this.posts,
    this.saved
  });

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snapshotData = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshotData['uid'],
      username: snapshotData['username'],
      email: snapshotData['email'],
      bio: snapshotData['bio'],
      photoUrl: snapshotData['photoUrl'],
      searchKey: snapshotData['searchKey'],
      following: snapshotData['following'],
      followers: snapshotData['followers'],
      posts: snapshotData['posts'],
      saved: snapshotData['saved']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      if (bio != null) 'bio': bio,
      if (photoUrl != null) 'photoUrl': photoUrl,
      if (searchKey != null) 'searchKey': searchKey,
      if (following != null) 'following': following,
      if (followers != null) 'followers': followers,
      if (posts != null) 'posts': posts,
      if (saved != null) 'saved': saved
    };
  }
}