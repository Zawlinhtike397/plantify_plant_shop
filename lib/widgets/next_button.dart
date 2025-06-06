import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/landing_screen_controller.dart';

class NextButton extends StatelessWidget {
  final LandingScreenControllerManager pageControllerManager;

  const NextButton({required this.pageControllerManager, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 90,
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style,
        onPressed: () {
          if (pageControllerManager.currentPage < 2) {
            pageControllerManager.nextPage();
          } else {
            context.go('/login');
          }
        },
        child: const Icon(Icons.arrow_forward, size: 50),
      ),
    );
  }
}
