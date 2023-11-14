import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String url;
  const ImageContainer({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50,
        width: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Center(
              child: ClipRRect(
            child: FancyShimmerImage(
              imageUrl: url,
              boxFit: BoxFit.fill,
            ),
          )),
        ),
      ),
    );
  }
}
