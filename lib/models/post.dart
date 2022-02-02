import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String postId;
  final String uid;
  final String username;
  final String profImage;
  final String postUrl;
  final datePublished;
  final List likes;

  Post({
    required this.description,
    required this.postId,
    required this.uid,
    required this.username,
    required this.profImage,
    required this.postUrl,
    required this.datePublished,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "description": description,
        "postId": postId,
        "uid": uid,
        "username": username,
        "profImage": profImage,
        "postUrl": postUrl,
        "datePublished": datePublished,
        "likes": likes
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return Post(
      description: snapShot['description'],
      postId: snapShot['postId'],
      uid: snapShot['uid'],
      username: snapShot['username'],
      profImage: snapShot['profImage'],
      postUrl: snapShot['postUrl'],
      datePublished: snapShot['datePublished'],
      likes: snapShot['likes'],
    );
  }
}
