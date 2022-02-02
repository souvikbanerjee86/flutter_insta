import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta/screens/add_post_screen.dart';
import 'package:flutter_insta/screens/feed_screen.dart';
import 'package:flutter_insta/screens/profile_screen.dart';
import 'package:flutter_insta/screens/search_screen.dart';

const WebScreenSize = 600;

final HomeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text("Favorite"),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
