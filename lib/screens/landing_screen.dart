import 'package:flutter/material.dart';
import 'package:plantshop_app/widgets/page_indicator.dart';
import '../controllers/landing_screen_controller.dart';
import 'package:provider/provider.dart';

import '../widgets/next_button.dart';
import '../widgets/pageview_carousel.dart';
import '../widgets/skip_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LandingScreenControllerManager(),
      child: SafeArea(
        child: Scaffold(
          body: Consumer<LandingScreenControllerManager>(
            builder: (context, pageControllerManager, child) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  const SkipButton(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height > 800
                              ? MediaQuery.of(context).size.height * 0.45
                              : MediaQuery.of(context).size.height * 0.41,
                          child: PageViewCarousel(
                              pageControllerManager: pageControllerManager),
                        ),
                        const PageIndicator(),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Enjoy your\nlife with",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w100,
                                      fontSize:
                                          MediaQuery.of(context).size.height >
                                                      800 &&
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width >
                                                      600
                                              ? 50.0
                                              : Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .fontSize,
                                    ),
                              ),
                              TextSpan(
                                text: " plants",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize:
                                          MediaQuery.of(context).size.height >
                                                      800 &&
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width >
                                                      600
                                              ? 50.0
                                              : Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .fontSize,
                                    ),
                              )
                            ],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 38.0,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        NextButton(
                            pageControllerManager: pageControllerManager),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
