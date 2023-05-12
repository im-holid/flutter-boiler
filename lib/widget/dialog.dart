import 'package:flutter/material.dart';
import 'package:hiro_app/widget/index.dart';

class AntiDialog extends StatelessWidget {
  const AntiDialog({
    Key? key,
    this.image,
    this.title,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.action,
    this.onSuccess,
    this.onFailed,
  }) : super(key: key);
  final String? image;
  final String? title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final void Function()? onSuccess;
  final void Function()? onFailed;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    return AlertDialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      content: Container(
        width: width,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image != null ? AntiImage(imageUrl: image!, width: 120, height: 120) : Container(),
            title != null
                ? Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      title!,
                      style: titleStyle ??
                          Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.green, fontWeight: FontWeight.w500),
                    ),
                  )
                : Container(),
            subtitle != null
                ? Container(
                    margin: EdgeInsets.only(top: 8.0),
                    child: Text(subtitle!,
                        textAlign: TextAlign.center,
                        style: subtitleStyle ??
                            Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey)),
                  )
                : Container(),
            action != null
                ? Container()
                : Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AntiButton(
                          buttonWidth: width * 0.36,
                          buttonHeight: 48,
                          text: 'OK',
                          onPressed: onSuccess ?? () {},
                          backgroundColor: Colors.green,
                        ),
                        AntiButton(
                          buttonWidth: width * 0.36,
                          buttonHeight: 48,
                          text: 'CANCEL',
                          onPressed: onFailed ??
                              () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                              },
                          backgroundColor: Colors.redAccent,
                        )
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
