import 'package:flutter/material.dart';

enum ToastType { error, warning, success, info }

class AntiToast extends StatelessWidget {
  const AntiToast({Key? key, this.onClose, this.onTap, this.subtitle, this.title, this.type})
      : super(key: key);
  final void Function()? onClose;
  final void Function()? onTap;
  final ToastType? type;
  final String? title;
  final String? subtitle;

  Color getBgColor() {
    switch (type) {
      case ToastType.error:
        return const Color(0xFFFF3333);
      case ToastType.warning:
        return const Color(0xFFFFCC00);
      case ToastType.success:
        return const Color(0xFF467FD0);
      default:
        return const Color(0xFF82A40C);
    }
  }

  Widget getTitle(BuildContext context) {
    if (subtitle == '' || subtitle == null) {
      return Text(
        title ?? '',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: [
          Text(
            title ?? '',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
          ),
          Text(
            subtitle ?? '',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        height: 70,
        width: width,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(color: getBgColor()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: width * 0.7,
              alignment: Alignment.centerLeft,
              child: getTitle(context),
            ),
            IconButton(
                onPressed: onClose,
                icon: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
