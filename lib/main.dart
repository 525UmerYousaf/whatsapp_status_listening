import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_check/story.dart';

void main() {
  runApp(const MyApp());
  //  Below is the code that helps to change the status bar color
//  this is above the AppBar and usually it's dim black.
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarColor: Colors.white,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: StoryApp(),
    );
  }
}
