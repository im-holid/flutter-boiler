import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:hiro_app/widget/index.dart';

class Info {
  static void showAntiToast(BuildContext context, ToastType type,
      {String? title, String? subtitle, void Function()? onTap}) {
    FToast().init(context);
    FToast().showToast(
      child: AntiToast(
        onClose: () => FToast().removeCustomToast(),
        title: title ?? '',
        subtitle: subtitle ?? '',
        onTap: onTap,
        type: type,
      ),
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 3),
    );
  }

  static void showAntiDialog(BuildContext context,
      {String? image,
      String? title,
      TextStyle? titleStyle,
      String? subtitle,
      TextStyle? subtitleStyle,
      void Function()? onSuccess,
      void Function()? onFailed,
      Widget? action}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AntiDialog(
          image: image,
          title: title,
          titleStyle: titleStyle,
          subtitle: subtitle,
          subtitleStyle: subtitleStyle,
          onFailed: onFailed,
          onSuccess: onSuccess,
          action: action,
        );
      },
    );
  }

  static void adaptiveTimePicker(BuildContext context,
      {required DateTime initialTime, void Function(DateTime)? onChangeTime}) {
    if (Platform.isIOS) {
      showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => Container(
                height: 300,
                padding: const EdgeInsets.only(top: 6.0),
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                color: CupertinoColors.systemBackground.resolveFrom(context),
                child: SafeArea(
                  top: false,
                  child: CupertinoDatePicker(
                    initialDateTime: initialTime,
                    use24hFormat: true,
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: onChangeTime ?? (DateTime newDateTime) {},
                  ),
                ),
              ));
    } else {
      showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(initialTime))
          .then((value) => {
                if (onChangeTime != null && value != null)
                  {
                    onChangeTime(DateTime(DateTime.now().day, DateTime.now().month,
                        DateTime.now().day, value.hour, value.minute))
                  }
              });
    }
  }

  static void adaptiveDatePicker(BuildContext context,
      {required DateTime initialDate,
      required DateTime maximumDate,
      void Function(DateTime)? onChangeDate}) {
    if (Platform.isIOS) {
      showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => Container(
                height: 300,
                padding: const EdgeInsets.only(top: 6.0),
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                color: CupertinoColors.systemBackground.resolveFrom(context),
                child: SafeArea(
                  top: false,
                  child: CupertinoDatePicker(
                    initialDateTime: initialDate,
                    maximumDate: maximumDate,
                    minimumDate: DateTime(1970),
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: onChangeDate ?? (DateTime newDateTime) {},
                  ),
                ),
              ));
    } else {
      showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1970),
        lastDate: maximumDate,
      ).then((value) => {
            if (onChangeDate != null && value != null) {onChangeDate(value)}
          });
    }
  }
}
