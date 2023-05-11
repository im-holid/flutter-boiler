import 'package:flutter/material.dart';
import 'package:hiro_app/theme/index.dart';
import 'package:hiro_app/widget/loading.dart';

class AntiButton extends StatelessWidget {
  final String text;
  final String? type; // solid, outline
  final double? buttonWidth;
  final double? buttonHeight;
  final void Function() onPressed;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final bool? loading;
  const AntiButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.type,
      this.buttonWidth,
      this.buttonHeight,
      this.backgroundColor,
      this.textStyle,
      this.loading})
      : super(key: key);

  Widget _buildSolidButton(BuildContext context) {
    return ElevatedButton(
      onPressed: loading == true ? () {} : onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: backgroundColor ?? hiroSwatch),
      child: loading == true
          ? const AntiLoading()
          : Text(
              text.toUpperCase(),
              textAlign: TextAlign.center,
              style:
                  textStyle ?? Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
            ),
    );
  }

  Widget _buildOutlineButton(BuildContext context) {
    return OutlinedButton(
      onPressed: loading == true ? () {} : onPressed,
      child: loading == true
          ? const AntiLoading()
          : Text(
              textAlign: TextAlign.center,
              text.toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 32;
    return SizedBox(
      height: buttonHeight ?? 56,
      width: buttonWidth ?? width,
      child: type == 'outline' ? _buildOutlineButton(context) : _buildSolidButton(context),
    );
  }
}
