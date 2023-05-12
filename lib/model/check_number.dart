import 'dart:convert';

CheckNumber checkNumberFromJson(String str) => CheckNumber.fromJson(json.decode(str)['data']);

String checkNumberToJson(CheckNumber data) => json.encode(data.toJson());

class CheckNumber {
  String? token;
  String? status;

  CheckNumber({this.status, this.token});

  factory CheckNumber.fromJson(Map<String, dynamic> json) => CheckNumber(
        status: json["status"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {"status": status, "token": token};
}
