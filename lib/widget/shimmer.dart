import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum ShimmerType {
  bodySmall,
  bodyMedium,
  bodyLarge,
  labelSmall,
  labelMedium,
  labelLarge,
  titleSmall,
  titleMedium,
  titleLarge,
  headlineSmall,
  headlineMedium,
  headlineLarge,
  displaySmall,
  displayMedium,
  displayLarge
}

class AntiShimmer extends StatelessWidget {
  const AntiShimmer(
      {Key? key,
      this.height,
      required this.width,
      this.borderRadius,
      this.margin,
      this.hide = false,
      this.type = ShimmerType.bodySmall,
      this.line = 1})
      : super(key: key);
  final double width;
  final double? height;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final bool? hide;
  final ShimmerType? type;
  final int? line;

  double getType() {
    switch (type) {
      case ShimmerType.bodySmall:
        return 16.0;
      case ShimmerType.bodyMedium:
        return 20.0;
      case ShimmerType.bodyLarge:
        return 24.0;
      case ShimmerType.labelSmall:
        return 16.0;
      case ShimmerType.labelMedium:
        return 16.0;
      case ShimmerType.labelLarge:
        return 20.0;
      case ShimmerType.titleSmall:
        return 20.0;
      case ShimmerType.titleMedium:
        return 24.0;
      case ShimmerType.titleLarge:
        return 28.0;
      case ShimmerType.headlineSmall:
        return 32.0;
      case ShimmerType.headlineMedium:
        return 36.0;
      case ShimmerType.headlineLarge:
        return 40.0;
      case ShimmerType.displaySmall:
        return 44.0;
      case ShimmerType.displayMedium:
        return 52.0;
      case ShimmerType.displayLarge:
        return 26.0;
      default:
        return 0.0;
    }
  }

  Widget _buildLineShimmer() {
    List<Widget> listShimmer = [];
    for (int i = 1; i <= line!; i++) {
      listShimmer.add(_buildShimmer());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listShimmer,
    );
  }

  Widget _buildShimmer() {
    return Shimmer(
      gradient: const LinearGradient(
        colors: [
          Color(0xffF5F5F4),
          Color(0xffE7E5E4),
          Color(0xffF5F5F4),
        ],
        stops: [
          0.0,
          0.5,
          0.0,
        ],
      ),
      period: const Duration(seconds: 2), // durasi animasi
      direction: ShimmerDirection.ltr, // arah animasi
      child: Container(
        width: width,
        height: height ?? getType(),
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (hide == true) {
      return Container();
    }
    return _buildLineShimmer();
  }
}
