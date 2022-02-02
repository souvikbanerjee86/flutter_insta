import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_insta/models/post.dart';
import 'package:flutter_insta/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(Uint8List file, String description, String uid,
      String username, String profImage) async {
    String res = "Some Error Occured";
    try {
      String postUrl =
          await StorageMethods().uploadImageToStorage("post", file, true);
      String postId = Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postUrl: postUrl,
        likes: [],
        datePublished: DateTime.now(),
        postId: postId,
        profImage: profImage,
      );

      await _firestore.collection("posts").doc(postId).set(post.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection("posts").doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection("posts").doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComment(String postId, String text, String uid,
      String username, String profImage) async {
    try {
      if (text.isNotEmpty) {
        String commentId = Uuid().v1();
        await _firestore
            .collection("posts")
            .doc(postId)
            .collection("comment")
            .doc(commentId)
            .set({
          "commentId": commentId,
          "postId": postId,
          "uid": uid,
          "comment": text,
          "datePublished": DateTime.now(),
          "profImage": profImage,
          "username": username
        });
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection("posts").doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> followers(String uid, String followId) async {
    DocumentSnapshot<Map<String, dynamic>> snap =
        await _firestore.collection("users").doc(uid).get();
    List following = snap.data()!['following'];
    if (following.contains(followId)) {
      await _firestore.collection("users").doc(uid).update({
        "following": FieldValue.arrayRemove([followId])
      });
      await _firestore.collection("users").doc(followId).update({
        "followers": FieldValue.arrayRemove([uid])
      });
    } else {
      await _firestore.collection("users").doc(uid).update({
        "following": FieldValue.arrayUnion([followId])
      });
      await _firestore.collection("users").doc(followId).update({
        "followers": FieldValue.arrayUnion([uid])
      });
    }
  }
}
