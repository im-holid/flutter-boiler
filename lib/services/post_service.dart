import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:hiro_app/helper/index.dart';
import 'package:hiro_app/store/store.dart';
import 'package:hiro_app/store/store_constants.dart';
import 'package:http/http.dart';

class PostServices {
  Future<Response> postData({
    required String urlPath,
    Map<String, String>? query,
    Map<String, dynamic>? body,
    File? file,
    Map<String, String>? header,
  }) async {
    Client client = Client();
    final String baseUrl = FlutterConfig.get('API_URL') + '/' + FlutterConfig.get('API_VERSION');
    Uri url = Uri.parse(baseUrl + (urlPath));

    if (query != null) {
      url.replace(queryParameters: query);
    }
    String token = '';

    // TODO:
    // do not read directly from local storage, move to state management
    String authToken = await Store.read(StoreConstans.authToken);
    if (authToken != '') {
      token = authToken;
    }
    String loginToken = await Store.read(StoreConstans.loginToken);
    if (loginToken != '') {
      token = loginToken;
    }

    Map<String, String> requestHeader = {
      'Authorization': 'Bearer $token',
      'api-version': '1.0.0',
      'Content-Type': 'application/json',
    };

    return client.post(url, headers: requestHeader, body: jsonEncode(body));
  }

  Future<Response> postDataFields({
    required String urlPath,
    Map<String, String>? query,
    Map<String, String>? body,
    File? file,
    Map<String, String>? header,
  }) async {
    final String baseUrl = FlutterConfig.get('API_URL') + '/' + FlutterConfig.get('API_VERSION');
    Uri url = Uri.parse(baseUrl + (urlPath));

    if (query != null) {
      url.replace(queryParameters: query);
    }
    String token = '';

    // TODO:
    // do not read directly from local storage, move to state management
    String authToken = await Store.read(StoreConstans.authToken);
    if (authToken != '') {
      token = authToken;
    }
    String loginToken = await Store.read(StoreConstans.loginToken);
    if (loginToken != '') {
      token = loginToken;
    }

    Map<String, String> requestHeader = {
      'Authorization': 'Bearer $token',
      'api-version': '1.0.0',
      'Content-Type': 'multipart/form-data',
    };

    if (header != null) requestHeader = {...requestHeader, ...header};

    MultipartRequest request = MultipartRequest('POST', url);
    request.headers.addAll(requestHeader);
    if (body != null) {
      request.fields.addAll(body);
    }
    if (file != null) {
      String ext = Common.extensionRegex(path: file.path);
      String primaryMimeType = _primaryMimeType(type: ext);
      request.files.add(
        MultipartFile(
          primaryMimeType,
          file.readAsBytes().asStream(),
          file.lengthSync(),
          contentType: MediaType(primaryMimeType, ext),
        ),
      );
    }

    print(request.fields);
    // Convert StreamedResponse to Response
    StreamedResponse streamedResponse = await request.send();
    String responseBody = await streamedResponse.stream.transform(utf8.decoder).join();
    return Response(responseBody, streamedResponse.statusCode, headers: streamedResponse.headers);
  }

  String _primaryMimeType({required String type}) {
    switch (type) {
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'svg+xml':
        return 'image';
      case 'json':
      case 'xml':
      case 'pdf':
        return 'application';
      case 'html':
      case 'css':
      case 'plain':
      case 'csv':
        return 'text';
      case 'wav':
      case 'mpeg':
        return 'audio';
      case 'mp4':
        return 'video';
      default:
        return '';
    }
  }
}
