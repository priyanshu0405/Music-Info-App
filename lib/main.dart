import 'package:flutter/material.dart';
import 'src/ui/musicDetails.dart';
import 'src/ui/musicList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicList(),
      routes: {
        MusicDetails.routeName: (context) => MusicDetails(), //Detail Screen
        MusicList.routeName: (context) => MusicList(), //Main Screen
      },
    );
  }
}
