import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  String? location; // location name for UI
  String? time; // the time in that location
  String? url; // location url for api endpoint
  String? isDaytime; // true or false if daytime or not

  WorldTime({this.location, this.url});

  Future<void> getTime() async {
    try {
      // make the request
      Response response = await get(Uri.https('dummyjson.com', '/products/1'));
      Map data = jsonDecode(response.body);

      // create DateTime object

      // set the time property
      location = data['description'];
      time = data['brand'];
      isDaytime = data['category'];
    } catch (e) {
      time = 'could not get time';
    }
  }
}
