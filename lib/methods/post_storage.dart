import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:holbegram/methods/user_storage.dart';
import 'package:holbegram/models/posts.dart';
import 'package:holbegram/models/user.dart';
import 'package:uuid/uuid.dart';
import 'dart:typed_data';

// TODO: Batch some of the firestore operations here

class PostStorage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadPost(
    String caption,
    String uid,
    String username,
    String profImage,
    Uint8List image,
  ) async {
    try {
      final imageUrl =
          await _storageMethods.uploadImageToStorage(true, 'post', image);
      final newPost = PostModel(
          uid: uid,
          username: username,
          caption: caption,
          likes: [],
          postId: const Uuid().v1(),
          datePublished: DateTime.now(),
          postUrl: imageUrl,
          profImage: profImage);
      await _firestore
          .collection('posts')
          .doc(newPost.postId)
          .set(newPost.toFirestore());
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> deletePost(String postId) async {
    try {
      final postToDelete = PostModel.fromSnapshot(
          await _firestore.collection('posts').doc(postId).get());
      if (postToDelete.postUrl.isNotEmpty) {
        await _storageMethods.deleteImageFromStorage(postToDelete.postUrl);
      }
      await _firestore.collection('posts').doc(postId).delete();
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> likePost(String postId) async {
    try {
      final UserModel user = UserModel.fromSnapshot(
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get()
      );
      final post = PostModel.fromSnapshot(
        await _firestore.collection('posts').doc(postId).get()
      );
      String postRes = '';

      // Save to post
      if (post.likes.contains(_auth.currentUser!.uid)) {
        await _firestore
            .collection('posts')
            .doc(postId)
            .update({'likes': FieldValue.arrayRemove([_auth.currentUser!.uid])});
        postRes = 'Removed';
      } else {
        await _firestore
            .collection('posts')
            .doc(postId)
            .update({'likes': FieldValue.arrayUnion([_auth.currentUser!.uid])});
        postRes = 'Added';
      }


      // Save to users liked posts
      if (user.saved == null) {
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({'saved': [postId]});
        return 'Added';
      }

      if (postRes == 'Removed' && user.saved!.contains(postId)) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .update({'saved': FieldValue.arrayRemove([postId])});
        return 'Removed';
      } else if (postRes == 'Added' && !user.saved!.contains(postId)) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .update({'saved': FieldValue.arrayUnion([postId])});
        return 'Added';
      }
      return 'Error: $postRes likes from post but not user';
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<PostModel>> getLiked() async {
    final uid = _auth.currentUser!.uid;

    return await _firestore
        .collection('posts')
        .where('likes', arrayContains: uid)
        .orderBy('datePublished', descending: true)
        .get()
        .then((value) => value.docs
            .map((doc) => PostModel.fromSnapshot(doc))
            .toList());
  }
}
