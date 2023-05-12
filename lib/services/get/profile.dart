// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hiro_app/helper/info.dart';
import 'package:hiro_app/model/index.dart';
import 'package:hiro_app/services/get_service.dart';
import 'package:hiro_app/widget/index.dart';
import 'package:http/http.dart';

Future<dynamic> fetchProfile({required BuildContext context}) async {
  String path = '/member/profile';

  Response response = await FetchServices.fetchData(urlPath: path);
  if (response.statusCode >= 200 && response.statusCode < 300) {
    MemberDetail value = memberDetailFromJson(response.body);
    return value;
  } else {
    dynamic value = jsonDecode(response.body);
    if (context.mounted) {
      Info.showAntiToast(
        context,
        ToastType.error,
        title: 'error get profile',
      );
    }
  }
  return null;
}
