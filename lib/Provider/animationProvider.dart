import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class ConfettiProvider extends ChangeNotifier {
  late ConfettiController _controller;

  ConfettiProvider() {
    _controller = ConfettiController(duration: const Duration(seconds: 2));
  }

  ConfettiController get controller => _controller;

  void playConfetti() {
    _controller.play();
    notifyListeners();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void showPopUP()
  {
}

}
