import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holbegram/methods/user_storage.dart';
import 'package:holbegram/models/posts.dart';
import 'package:uuid/uuid.dart';
import 'dart:typed_data';

class PostStorage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();

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
}
