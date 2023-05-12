import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hiro_app/helper/info.dart';
import 'package:hiro_app/model/auth_token.dart';
import 'package:hiro_app/services/post_service.dart';
import 'package:hiro_app/store/store.dart';
import 'package:hiro_app/store/store_constants.dart';
import 'package:hiro_app/widget/index.dart';
import 'package:http/http.dart';

Future<bool> postLogin({
  required String phoneNumber,
  required String phoneCode,
  required String pin,
  required BuildContext context,
}) async {
  String path = '/login';

  Map<String, dynamic> body = {'phoneCode': phoneCode, 'phoneNumber': phoneNumber, 'pin': pin};

  Response response = await PostServices().postData(urlPath: path, body: body, isAuth: true);
  if (response.statusCode >= 200 && response.statusCode < 300) {
    AuthToken value = authTokenFromJson(response.body);
    await Store.write(StoreConstans.loginToken, jsonEncode(value));
    return true;
  } else {
    dynamic value = jsonDecode(response.body);
    if (context.mounted) {
      print(value.toString());
      Info.showAntiToast(
        context,
        ToastType.error,
        title: 'error di login',
      );
    }
  }
  return false;
}
