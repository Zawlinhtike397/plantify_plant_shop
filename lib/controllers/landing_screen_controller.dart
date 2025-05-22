import 'package:flutter/material.dart';

class LandingScreenControllerManager extends ChangeNotifier {
  final PageController _controller = PageController();
  int _currentPage = 0;

  PageController get controller => _controller;
  int get currentPage => _currentPage;

  void updateCurrentPage(double? page) {
    _currentPage = page?.round() ?? 0;
    notifyListeners();
  }

  void nextPage() {
    if (_currentPage < 2) {
      _controller.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void disposeController() {
    _controller.dispose();
  }
}
