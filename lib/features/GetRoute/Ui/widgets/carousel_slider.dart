import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants/app_color.dart';

class MyCarousel extends StatefulWidget {

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  int currentIndex = 0;
  final images = ['assets/images/img_1.png', 'assets/images/img_3.png'
    , 'assets/images/img_4.png'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                images[index],
                fit: BoxFit.fill,
              ),
            );
          },
          options: CarouselOptions(
            scrollPhysics: NeverScrollableScrollPhysics(),
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 12),

        AnimatedSmoothIndicator(
          activeIndex: currentIndex,
          count: images.length,
          effect: WormEffect( // you can choose different effects
            dotHeight: 12,
            dotWidth: 12,
            activeDotColor: AppColor.primaryColor,
          ),
        ),
      ],
    );
  }
}
