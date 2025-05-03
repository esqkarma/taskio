import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SoundProvider extends ChangeNotifier{
  
  final AudioPlayer player = AudioPlayer();
  
  Future<void> startTimerSound() async{
    // player.setVolume(10);
    await player.play(
        AssetSource('sounds/startTimer.mp3'));
  }
  Future<void> stopTimerSound() async{
await player.play(AssetSource('sounds/stopTimer.mp3'));
  }
  Future<void> pauseTimerSound() async{
    await player.play(AssetSource('sounds/pause.mp3'));
  }
  Future<void> resumeTimerSound() async{
    await player.play(AssetSource('sounds/resume.mp3'));
  }
  Future<void> taskCompletedsound() async{
    await player.play(AssetSource('sounds/taskCompleted.mp3'));
  }
  Future<void> taskDeletedsound() async{
    await player.play(AssetSource('sounds/taskDeleted.mp3'));
  }
  Future<void>lastFiveSecondSound() async{

    await player.play(AssetSource('sounds/tickSound6Sec.mp3'));

  }
  Future<void>timeOverSound() async{

    await player.play(AssetSource('sounds/timeOver.mp3'));

  }
  Future<void>taskAddedSound() async{

    await player.play(AssetSource('sounds/taskAdded.mp3'));

  }

  
}
