import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AdCarousel extends StatefulWidget {
  final List<Image> images;

  AdCarousel({required this.images});

  @override
  AdCarouselState createState() => AdCarouselState();
}

class AdCarouselState extends State<AdCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  Widget getImageContainer(Image img) => ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: img,
      );

  @override
  Widget build(BuildContext context) {
    return Flex(direction: Axis.vertical, children: [
      Expanded(
        child: CarouselSlider(
          items: widget.images.map(getImageContainer).toList(),
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              enlargeCenterPage: true,
              aspectRatio: 2.5,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.images.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
