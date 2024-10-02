import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCacheImage extends StatelessWidget {
  const CustomCacheImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit,
  });

  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: fit,
      placeholder: (context, url) => const CircularProgressIndicator(
        color: Colors.white,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
