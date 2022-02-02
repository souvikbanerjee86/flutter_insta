import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String username;
  final String email;
  final String uid;
  final String bio;
  final List followers;
  final List following;
  final String photoUrl;

  AppUser(
      {required this.username,
      required this.email,
      required this.uid,
      required this.bio,
      required this.followers,
      required this.following,
      required this.photoUrl});

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "uid": uid,
        "bio": bio,
        "followers": followers,
        "following": following,
        "photoUrl": photoUrl
      };

  static AppUser fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return AppUser(
      username: snapShot['username'],
      email: snapShot['email'],
      uid: snapShot['uid'],
      bio: snapShot['bio'],
      followers: snapShot['followers'],
      following: snapShot['following'],
      photoUrl: snapShot['photoUrl'],
    );
  }
}
