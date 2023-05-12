import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hiro_app/helper/info.dart';
import 'package:hiro_app/model/check_number.dart';
import 'package:hiro_app/services/post_service.dart';
import 'package:hiro_app/widget/index.dart';
import 'package:http/http.dart';

enum EnumNumberStatus { registered, registiredNoPin, nonRegistered }

extension EnumNumberStatusExtension on EnumNumberStatus {
  String get value {
    switch (this) {
      case EnumNumberStatus.registered:
        return 'PIN';
      case EnumNumberStatus.registiredNoPin:
        return 'CREATE_PIN';
      case EnumNumberStatus.nonRegistered:
        return 'OTP';
    }
  }
}

Future<dynamic> postCheckPhone({
  required BuildContext context,
  required String phoneNumber,
  required String phoneCode,
}) async {
  String path = '/checkPhoneNumber';

  Map<String, dynamic> body = {
    'phoneCode': phoneCode,
    'phoneNumber': phoneNumber,
  };

  Response response = await PostServices().postData(urlPath: path, body: body, isAuth: true);
  if (response.statusCode >= 200 && response.statusCode < 300) {
    CheckNumber value = checkNumberFromJson(response.body);
    return value;
  } else {
    dynamic value = jsonDecode(response.body);
    print(value.toString());
    if (context.mounted) {
      Info.showAntiToast(context, ToastType.error, title: 'error di check number');
    }
    return;
  }
}
