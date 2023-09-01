import 'package:flutter/material.dart';

import 'package:cinemapedia/config/constants/assets.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer(
      {super.key,
      required this.imageUrl,
      required this.height,
      this.width,
      required this.radius});

  final String imageUrl;
  final double height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: FadeInImage(
        fit: BoxFit.cover,
        height: height,
        width: width,
        placeholder: AssetImage(Assets.fallbackImage),
        image: NetworkImage(imageUrl),
      ),
    );
  }
}
