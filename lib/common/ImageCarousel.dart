import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatefulWidget {
  final List<Widget> images;
  final bool autoSlide;
  final Brightness brightness;
  final double? aspectRatio;
  final bool flat;
  final double? height;

  ImageCarousel(
      {required this.images,
      this.autoSlide = true,
      this.brightness = Brightness.dark,
      this.aspectRatio,
      this.height,
      this.flat = false});

  @override
  ImageCarouselState createState() => ImageCarouselState();
}

class ImageCarouselState extends State<ImageCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  Widget getImageContainer(Widget img) => ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: img,
      );

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: widget.images.map(getImageContainer).toList(),
        carouselController: _controller,
        options: CarouselOptions(
            autoPlay: widget.autoSlide,
            autoPlayInterval: Duration(seconds: 5),
            enlargeCenterPage: !widget.flat,
            height: widget.height,
            aspectRatio: widget.aspectRatio ?? (16 / 9),
            disableCenter: true,
            pageSnapping: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
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
                  color: (widget.brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
