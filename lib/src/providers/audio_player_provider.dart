import 'package:flutter/widgets.dart';

class AudioPlayerProvider with ChangeNotifier {
  bool _playing = false;
  Duration _songDuration = const Duration(microseconds: 0);
  Duration _currentSongDuration = const Duration(microseconds: 0);
  AnimationController? animController;

  String get songTotalDuration => printDuration(_songDuration);
  String get songCurrentDuration => printDuration(_currentSongDuration);

  double get percentaje => (_songDuration.inSeconds > 0) ? _currentSongDuration.inSeconds / songDuration.inSeconds : 0;

  bool get playing => _playing;

  set playing(bool value) {
    _playing = value;
    notifyListeners();
  }

  Duration get songDuration => _songDuration;

  set songDuration(Duration value) {
    _songDuration = value;
    notifyListeners();
  }

  Duration get currentSongDuration => _currentSongDuration;

  set currentSongDuration(Duration value) {
    _currentSongDuration = value;
    notifyListeners();
  }

  String printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
