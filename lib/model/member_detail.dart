import 'dart:convert';

MemberDetail memberDetailFromJson(String str) => MemberDetail.fromJson(json.decode(str)['data']);

String memberDetailToJson(MemberDetail data) => json.encode(data.toJson());

class MemberDetail {
  String? uuid;
  String? memberCode;
  String? fullname;
  String? phoneCode;
  String? phoneNumber;
  String? email;

  MemberDetail({
    this.uuid,
    this.memberCode,
    this.fullname,
    this.phoneCode,
    this.phoneNumber,
    this.email,
  });

  factory MemberDetail.fromJson(Map<String, dynamic> json) => MemberDetail(
        uuid: json["uuid"],
        memberCode: json["memberCode"],
        fullname: json["fullname"],
        phoneCode: json["phoneCode"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "memberCode": memberCode,
        "fullname": fullname,
        "phoneCode": phoneCode,
        "phoneNumber": phoneNumber,
        "email": email,
      };
}
