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
    return ImageCarousel(
      //aspectRatio: 2.5,
      height: MediaQuery.of(context).size.width * (1 / 2.6),
      images: this.images,
      flat: true,
    );
  }
}