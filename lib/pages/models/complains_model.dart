import 'package:flutter/cupertino.dart';

class Complains {
  Complains({
    String? id,
    String? userUid,
    String? description,
    String? date,
    String? userName,
    String? UserPhone,
    String? Order,


  }) {
    _id = id;
    _userUid = userUid;
    _description = description;
    _date = date;
    _userName=userName;
    _UserPhone=UserPhone;
    _Order=Order;
  }

  Complains.fromJson(dynamic json) {
    _id = json['id'];
    _userUid = json['userUid'];
    _description = json['description'];
    _date = json['date'];
    _userName = json['userName'];
    _UserPhone = json['UserPhone'];
    _Order = json['Order'];
  }

  String? _id;
  String? _userUid;
  String? _description;
  String? _date;
  String? _userName;
  String? _UserPhone;
  String? _Order;

  String? get id => _id;
  String? get userUid => _userUid;
  String? get description => _description;
  String? get date => _date;
  String? get userName => _userName;
  String? get UserPhone => _UserPhone;
  String? get Order => _Order;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userUid'] = _userUid;
    map['description'] = _description;
    map['date'] = _date;
    map['userName'] = _userName;
    map['UserPhone'] = _UserPhone;
    map['Order'] = _Order;
    return map;
  }
}
