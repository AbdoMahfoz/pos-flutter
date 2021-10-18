import 'package:flutter/material.dart';

import '../../common/ImageCarousel.dart';

class CarouselHeader extends StatelessWidget {
  final List<Image> images;

  CarouselHeader({
    Key? key,
    required this.images
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ImageCarousel(
        //aspectRatio: 2.5,
        height: 200,
        images: this.images,
      ),
    );
  }
}