import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'shimmer.dart';

class AntiImage extends StatelessWidget {
  const AntiImage(
      {Key? key,
      required this.imageUrl,
      required this.width,
      required this.height,
      this.file,
      this.margin,
      this.borderRadius,
      this.colorFilter,
      this.fit,
      this.children})
      : super(key: key);
  final String imageUrl;
  final double height;
  final double width;
  final File? file;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Widget? children;
  final ColorFilter? colorFilter;
  final BoxFit? fit;

  Widget _buildImage(BuildContext context, ImageProvider<Object> imageProv) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        image: DecorationImage(
          image: imageProv,
          fit: fit ?? BoxFit.cover,
          colorFilter: colorFilter,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isAssets = imageUrl.contains('assets/') && !imageUrl.contains('http');
    return Container(
      height: height,
      width: width,
      margin: margin,
      child: Stack(
        children: [
          file != null
              ? _buildImage(context, FileImage(file!))
              : isAssets
                  ? _buildImage(context, AssetImage(imageUrl))
                  : CachedNetworkImage(
                      imageUrl: imageUrl,
                      imageBuilder: (context, imageProvider) => _buildImage(context, imageProvider),
                      placeholder: (context, url) => AntiShimmer(
                        height: height,
                        width: width,
                      ),
                      errorWidget: (context, url, error) =>
                          _buildImage(context, const AssetImage('assets/broken_image.jpeg')),
                      height: height,
                      width: width,
                      fit: fit ?? BoxFit.cover,
                    ),
          children ?? Container()
        ],
      ),
    );
  }
}
