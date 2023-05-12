import 'package:flutter/material.dart';

import 'package:hiro_app/theme/index.dart';

class AntiHeader extends StatelessWidget implements PreferredSizeWidget {
  const AntiHeader({
    super.key,
    this.title,
    this.alignTitle,
    this.left,
    this.center,
    this.right,
    required this.context,
  });
  final BuildContext context;
  final AlignmentGeometry? alignTitle;
  final String? title;
  final Widget? left;
  final Widget? center;
  final Widget? right;

  @override
  Size get preferredSize => const Size.fromHeight(55);

  Widget _buildLeft() {
    if (left == null) {
      return GestureDetector(
        onTap: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
        child: Icon(
          Icons.arrow_back,
          color: hiroSwatch,
        ),
      );
    }
    return left!;
  }

  Widget _buildCenter() {
    if (center == null) {
      return Expanded(
        flex: 1,
        child: Align(
          alignment: alignTitle ?? Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              title ?? '',
              style: TextStyle(
                  fontFamily: 'Gotham',
                  fontSize: 18,
                  color: primaryBlack,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
    }
    return center!;
  }

  Widget _buildRight() {
    return right ??
        SizedBox(
          width: 24,
        );
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        padding: EdgeInsets.only(top: topPadding, left: 16, right: 16),
        height: 55 + topPadding,
        child: Row(
          children: [_buildLeft(), _buildCenter(), _buildRight()],
        ),
      ),
    );
  }
}
