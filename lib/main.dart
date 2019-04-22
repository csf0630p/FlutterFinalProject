import 'authentication.dart';
import 'browse_posts_activity.dart';
import 'new_post_activity.dart';
import 'post_detail_activity.dart';
import 'posts.dart';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> main() async{

  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  final FirebaseStorage storage = new FirebaseStorage();
  final PostDetail postDetail = null;

  runApp(MaterialApp(
    title: 'HyperGarageSale',
    home: LoginPage(),
    routes: {
      LoginPage.routeName: (context) => new LoginPage(),
      BrowsePage.routeName: (context) => new BrowsePage(),
      PostPage.routeName: (context) => new PostPage(),
      DetailPage.routeName: (context) => new DetailPage(postDetail: postDetail),
      TakePictureScreen.routeName : (context) => new TakePictureScreen(camera: firstCamera),
    },
  ));
}