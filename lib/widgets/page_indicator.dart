import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controllers/landing_screen_controller.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: SmoothPageIndicator(
        controller:
        Provider.of<LandingScreenControllerManager>(context, listen: false)
            .controller,
        count: 3,
        effect: ExpandingDotsEffect(
          dotHeight: 6.0,
          dotWidth: 6.0,
          activeDotColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}