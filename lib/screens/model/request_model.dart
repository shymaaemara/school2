import 'package:flutter/cupertino.dart';

class Requests {
  Requests({
    String? id,
    String? date,
    String? birthday,
    String? phone,
    String? age,
    String?  discrption,
    String? address,
    String? userName,
    String? userPhone,
    String? name,
    String? imageUrl,
  }) {
    _id = id;
    _date = date;
    _birthday = birthday;
    _phone = phone;
    _age = age;
    _discrption = discrption;
    _address = address;
    _userName = userName;
    _userPhone = userPhone;
    _name = name;
    _imageUrl = imageUrl;
  }

  Requests.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];

    _birthday = json['birthday'];
    _phone = json['phone'];
    _age = json['age'];
    _address  = json['address '];
    _discrption= json['discrption'];
    _userName = json['userName'];
    _userPhone = json['userPhone'];
    _name = json['name'];
    _imageUrl = json['imageUrl'];
  }

  String? _id;
  String? _date;
  String? _serviceName;
  String? _birthday;
  String? _phone;
  String? _age;
  String? _address;
  String? _discrption;
  String? _userName;
  String? _userPhone;
  String? _name;
  String? _imageUrl;

  String? get id => _id;

  String? get phone => _phone;
  String? get age => _age;
  String? get address => _address;
  String? get discrption => _discrption;
  String? get birthday => _birthday;
  String? get userName => _userName;
  String? get name => _name;
  String? get userPhone => _userPhone;

  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['phone'] = _phone;
    map['age'] = _age;
    map['address'] = _address;
    map['discrption'] = _discrption;
    map['birthday'] = _birthday;

    map['userName'] = _userName;
    map['userPhone'] = _userPhone;
    map['name'] = _name;
    map['imageUrl'] = _imageUrl;

    return map;
  }
}
