import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final double screenWidth,screenHeight;
  final String url;
  const ImageWidget({Key? key,required this.screenHeight,required this.screenWidth,required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      width: screenWidth,
      height: screenHeight * 0.45,
      imageUrl:url,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
