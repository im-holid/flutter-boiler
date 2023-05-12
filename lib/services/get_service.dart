import 'package:flutter_config/flutter_config.dart';
import 'package:hiro_app/store/store.dart';
import 'package:hiro_app/store/store_constants.dart';
import 'package:http/http.dart';

class FetchServices {
  static Future<Response> fetchData({required String urlPath, Map<String, String>? query}) async {
    Client client = Client();

    final String baseUrl = FlutterConfig.get('API_URL') + '/' + FlutterConfig.get('API_VERSION');
    Uri url = Uri.parse(baseUrl + (urlPath));

    if (query != null) {
      url.replace(queryParameters: query);
    }
    String token = '';
    dynamic loginToken = await Store.read(StoreConstans.loginToken);
    if (loginToken != null) {
      token = loginToken['token'];
    }

    Map<String, String> requestHeader = {
      'Authorization': 'Bearer $token',
      'api-version': '1.0.0',
      'Content-Type': 'application/json',
    };
    return client.get(url, headers: requestHeader);
  }
}
