import 'dart:convert';

import 'package:flutter_config/flutter_config.dart';
import 'package:hiro_app/model/auth_token.dart';
import 'package:hiro_app/services/post_service.dart';
import 'package:hiro_app/store/index.dart';
import 'package:http/http.dart';

Future<bool> postReqAuthToken() async {
  String path = '/requestAuthToken';

  Map<String, dynamic> body = {
    'clientId': FlutterConfig.get('CLIENT_ID'),
    'clientSecret': FlutterConfig.get('CLIENT_SECRET'),
  };

  Response response = await PostServices().postData(urlPath: path, body: body, isAuth: true);

  if (response.statusCode >= 200 && response.statusCode < 300) {
    AuthToken value = authTokenFromJson(response.body);
    await Store.write(StoreConstans.authToken, jsonEncode(value));
    return false;
  }

  return true;
}
