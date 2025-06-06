import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            context.go('/login');
          },
          child: Text(
            'Skip',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: MediaQuery.of(context).size.height > 800 &&
                          MediaQuery.of(context).size.width > 600
                      ? 35.0
                      : 20.0,
                ),
          ),
        ),
      ],
    );
  }
}
