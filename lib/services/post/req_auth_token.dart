import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:hiro_app/services/post_service.dart';
import 'package:http/http.dart';

Future<void> postReqAuthToken({
  required BuildContext context,
  Map<String, dynamic>? urlParams,
}) async {
  String path = '/requestAuthToken';
  Map<String, dynamic> body = {
    'clientId': FlutterConfig.get('CLIENT_ID'),
    'clientSecret': FlutterConfig.get('CLIENT_SECRET'),
  };
  Response response = await PostServices().postData(urlPath: path, body: body);
  debugPrint(response.body);
  return;
  // String parsedParams = Common.parseUrlParams(urlParams);
  // String fullPath = path + parsedParams;
  // PostServices().postData(fullPath, body).then((value) async {
  //   loading.value = false;
  //   if (value.body['statusCode'] == 200) {
  //     await Store.write(
  //       StoreConstans.authToken,
  //       {
  //         "token": value.body['data']['token'],
  //       },
  //     );
  //     Get.offNamed("/login");
  //   } else {
  //     Info.showAntiToast(
  //       context,
  //       ToastType.ERROR,
  //       title: value.body['message'][0],
  //     );
  //   }
  // });
}
