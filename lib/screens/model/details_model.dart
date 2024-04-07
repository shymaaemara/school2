import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Details {
  Details({
    String? id,
    String? date,
    String? money1,
    String? money2,
    String? money3,
    String? userName,
    String? userPhone,
    String? condtion,

  }) {
    _id = id;
    _date = date;
    _money1 = money1;
    _money2 = money2;
    _money3 = money3;
    _name = name;
    _userName = userName;
    _userPhone = userPhone;
    _condtion = condtion;

  }

  Details.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];

    _money1 = json['money1'];
    _money2 = json['money2'];
    _money3 = json['money3'];
    _name = json['name'];
    _userName = json['userName'];
    _userPhone = json['userPhone'];
    _condtion = json['condtion'];

  }

  String? _id;
  String? _date;

  String? _money1;
  String? _money2;
  String? _money3;
  String? _name;
  String? _userName;
  String? _userPhone;
  String? _condtion;


  String? get id => _id;
  String? get date => _date;
  String? get name => _name;
  String? get money1 => _money1;
  String? get money2 => _money2;
  String? get money3 => _money3;
  String? get userName => _userName;
  String? get condtion => _condtion;
  String? get userPhone => _userPhone;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['name'] = _name;
    map['money1'] = _money1;
    map['money2'] = _money2;
    map['money3'] = _money3;
    map['userName'] = _userName;
    map['userPhone'] = _userPhone;
    map['condtion'] = _condtion;


    return map;
  }
}
