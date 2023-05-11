import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiro_app/theme/index.dart';

class AntiLoading extends StatelessWidget {
  const AntiLoading({Key? key, this.height, this.width, this.color, this.margin}) : super(key: key);
  final double? height;
  final double? width;
  final Color? color;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      alignment: Alignment.center,
      child: SizedBox(
          width: width ?? 8.0,
          height: height ?? 8.0,
          child: Platform.isAndroid
              ? CircularProgressIndicator(
                  color: color ?? hiroSwatch,
                  strokeWidth: 2.0,
                )
              : CupertinoActivityIndicator(color: color ?? hiroSwatch)),
    );
  }
}
