// To parse this JSON data, do
//
//     final addtofav = addtofavFromJson(jsonString);

import 'dart:convert';

Addtofav addtofavFromJson(String str) => Addtofav.fromJson(json.decode(str));

String addtofavToJson(Addtofav data) => json.encode(data.toJson());

class Addtofav {
    String msg;

    Addtofav({
        required this.msg,
    });

    factory Addtofav.fromJson(Map<String, dynamic> json) => Addtofav(
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
    };
}
