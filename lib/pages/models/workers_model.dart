import 'package:flutter/cupertino.dart';

class Workers {
  Workers({
    String? id,
    String? serviceImage,
    String? serviceName,
    String? servicePrice,
    String? uid,
    String? type,
  }) {
    _id = id;
    _serviceImage = serviceImage;
    _serviceName = serviceName;
    _servicePrice = servicePrice;
    _uid = uid;
    _type = type;

  }

  Workers.fromJson(dynamic json) {
    _id = json['id'];
    _serviceImage = json['serviceImage'];
    _serviceName = json['serviceName'];
    _servicePrice = json['servicePrice'];
    _uid = json['uid'];
    _type = json['type'];

  }

  String? _id;
  String? _serviceImage;
  String? _serviceName;
  String? _servicePrice;
  String? _uid;
  String? _type;


  String? get id => _id;
  String? get serviceImage => _serviceImage;
  String? get serviceName => _serviceName;
  String? get servicePrice => _servicePrice;
  String? get uid => _uid;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['serviceImage'] = _serviceImage;
    map['serviceName'] = _serviceName;
    map['servicePrice'] = _servicePrice;
    map['uid'] = _uid;
    map['type'] = _type;

    return map;
  }
}
