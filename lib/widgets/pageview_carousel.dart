import 'package:flutter/material.dart';

import '../controllers/landing_screen_controller.dart';
import 'carousel_image.dart';

const String snakePlantImage = 'assets/image/Snakeplant.webp';
const String luckyJadePlantImage = 'assets/image/LuckyJadePlant.webp';
const String smallPlantImage = 'assets/image/Smallplant.webp';

class PageViewCarousel extends StatelessWidget {
  final LandingScreenControllerManager pageControllerManager;

  const PageViewCarousel({required this.pageControllerManager, super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageControllerManager.controller,
      onPageChanged: (index) => 
          pageControllerManager.updateCurrentPage(index.toDouble()),
      children: const [
        CarouselImage(imgPath: snakePlantImage),
        CarouselImage(imgPath: luckyJadePlantImage),
        CarouselImage(imgPath: smallPlantImage),
      ],
    );
  }
}
