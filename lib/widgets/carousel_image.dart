import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  final String imgPath;

  const CarouselImage({required this.imgPath,super.key});

  @override
  Widget build(BuildContext context) {
    return  Image(
      image: AssetImage(imgPath),
      fit: BoxFit.scaleDown,
    );
  }
}

// image: AssetImage('assets/image/Snakeplant.png'),