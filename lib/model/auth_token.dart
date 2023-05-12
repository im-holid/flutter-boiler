import 'dart:convert';

AuthToken authTokenFromJson(String str) => AuthToken.fromJson(json.decode(str)['data']);

String authTokenToJson(AuthToken data) => json.encode(data.toJson());

class AuthToken {
  String? tokenType;
  String? token;
  String? expiredDate;

  AuthToken({this.tokenType, this.token, this.expiredDate});

  factory AuthToken.fromJson(Map<String, dynamic> json) => AuthToken(
        tokenType: json["tokenType"],
        token: json["token"],
        expiredDate: json["expiredDate"],
      );

  Map<String, dynamic> toJson() =>
      {"tokenType": tokenType, "token": token, "expiredDate": expiredDate};
}
