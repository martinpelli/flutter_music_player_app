import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/src/pages/music_player_page.dart';
import 'package:flutter_music_player_app/src/providers/audio_player_provider.dart';
import 'package:flutter_music_player_app/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => AudioPlayerProvider())],
        child: MaterialApp(debugShowCheckedModeBanner: false, theme: myTheme, title: 'Music Player', home: MusicPlayerScreen()));
  }
}
