import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetImageWidget extends StatelessWidget {
  final String imageData;
  final double imageWidth;
  final double imageHeight;
  final BoxFit? boxFit;
  final Color? color;

  const AssetImageWidget({
    super.key,
    required this.imageData,
    required this.imageWidth,
    required this.imageHeight,
    this.boxFit = BoxFit.contain,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return imageData.isNotEmpty
        ? imageData.contains(".png") || imageData.contains(".jpg")
            ? Image.asset(
                imageData,
                width: imageWidth,
                height: imageHeight,
                fit: boxFit,
                errorBuilder: (context, error, _) {
                  return IgnorePointer();
                },
              )
            : SvgPicture.asset(
                imageData,
                width: imageWidth,
                height: imageHeight,
                fit: boxFit!,
                placeholderBuilder: (_) {
                  return IgnorePointer();
                },
              )
        : const IgnorePointer();
  }
}

class CacheImageWidget extends StatelessWidget {
  final double imageHeight;
  final double imageWidth;
  final String imageUrl;
  final BoxFit? boxFit;
  final Color? color;
  final bool? shouldShowShimmer;

  const CacheImageWidget({
    super.key,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageUrl,
    this.boxFit = BoxFit.fill,
    this.color,
    this.shouldShowShimmer = true,
  });

  @override
  Widget build(BuildContext context) {
    return imageUrl.isNotEmpty
        ? CachedNetworkImage(
            key: ValueKey(imageUrl),
            height: imageHeight,
            width: imageWidth,
            imageUrl: imageUrl,
            color: color,
            placeholder: (context, url) => const IgnorePointer(),
            fit: boxFit,
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) => const IgnorePointer(),
          )
        : const IgnorePointer();
  }
}
