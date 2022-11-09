import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/src/helpers/helpers.dart';
import 'package:flutter_music_player_app/src/providers/audio_player_provider.dart';
import 'package:flutter_music_player_app/src/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class MusicPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const _Background(),
        Column(
          children: const [CustomAppbar(), _CDAndDuration(), _TitlePlay(), Expanded(child: _Lyrics())],
        ),
      ],
    ));
  }
}

class _Background extends StatelessWidget {
  const _Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: screenHeight * 0.8,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50.0)),
          gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.center, colors: [Color(0xff33333E), Color(0xff201E28)])),
    );
  }
}

class _Lyrics extends StatelessWidget {
  const _Lyrics({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lyrics = getLyrics();
    return ListWheelScrollView(
        itemExtent: 42,
        diameterRatio: 1.5,
        physics: const BouncingScrollPhysics(),
        children: lyrics.map((line) => Text(line, style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.6)))).toList());
  }
}

class _TitlePlay extends StatefulWidget {
  const _TitlePlay({
    Key? key,
  }) : super(key: key);

  @override
  State<_TitlePlay> createState() => _TitlePlayState();
}

class _TitlePlayState extends State<_TitlePlay> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  bool isPlaying = false;
  bool isfirstTime = true;
  final assetAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void open() {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context, listen: false);
    assetAudioPlayer.open(Audio('assets/Breaking-Benjamin-Far-Away.mp3'), autoStart: true, showNotification: true);

    assetAudioPlayer.currentPosition.listen((duration) {
      audioPlayerProvider.currentSongDuration = duration;
    });

    assetAudioPlayer.current.listen((playingAudio) {
      audioPlayerProvider.songDuration = playingAudio?.audio.duration ?? const Duration(seconds: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      margin: const EdgeInsets.only(top: 40),
      child: Row(children: [
        Column(
          children: [
            Text('Far away ', style: TextStyle(fontSize: 30, color: Colors.white.withOpacity(0.8))),
            Text('--Breaking Benjamin--', style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.5)))
          ],
        ),
        const Spacer(),
        FloatingActionButton(
          elevation: 0,
          highlightElevation: 0,
          onPressed: () {
            if (isPlaying) {
              animationController.reverse();
              isPlaying = false;
              audioPlayerProvider.animController!.stop();
            } else {
              animationController.forward();
              isPlaying = true;
              audioPlayerProvider.animController!.repeat();
            }

            if (isfirstTime) {
              open();
              isfirstTime = false;
            } else {
              assetAudioPlayer.playOrPause();
            }
          },
          backgroundColor: const Color(0xffF8CB51),
          child: AnimatedIcon(icon: AnimatedIcons.play_pause, progress: animationController),
        )
      ]),
    );
  }
}

class _CDAndDuration extends StatelessWidget {
  const _CDAndDuration({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.symmetric(vertical: 70),
      child: Row(children: const [
        _CD(),
        SizedBox(width: 30),
        _ProgressBar(),
        SizedBox(
          width: 10,
        )
      ]),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: Colors.white.withOpacity(0.4));
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    final percentaje = audioPlayerProvider.percentaje;
    return Column(children: [
      Text(audioPlayerProvider.songTotalDuration, style: textStyle),
      const SizedBox(
        height: 10,
      ),
      Stack(children: [
        Container(
          width: 3,
          height: 230,
          color: Colors.white.withOpacity(0.1),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: 3,
            height: 230 * percentaje,
            color: Colors.white.withOpacity(0.8),
          ),
        )
      ]),
      const SizedBox(
        height: 10,
      ),
      Text(audioPlayerProvider.songCurrentDuration, style: textStyle)
    ]);
  }
}

class _CD extends StatelessWidget {
  const _CD({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      height: 250,
      width: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200.0),
          gradient: const LinearGradient(begin: Alignment.topLeft, colors: [Color(0xff484750), Color(0xff1E1C24)])),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SpinPerfect(
                animate: false,
                controller: (controller) => audioPlayerProvider.animController = controller,
                manualTrigger: true,
                infinite: true,
                duration: const Duration(seconds: 10),
                child: const Image(image: AssetImage('assets/aurora.jpg'))),
            Container(
              width: 25.0,
              height: 25.0,
              decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(200.0)),
            ),
            Container(
              width: 18.0,
              height: 18.0,
              decoration: BoxDecoration(color: const Color(0xff1C1C25), borderRadius: BorderRadius.circular(200.0)),
            )
          ],
        ),
      ),
    );
  }
}
