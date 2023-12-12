import 'dart:convert';

import 'bus_user_login.dart';

import 'post.dart';

String _path = '/bus_user/';

Future<Map<String, dynamic>> registerBusUser (

  String fname,
  String lname,
  String ashesiId,
  String ashesiEmail,
  String password,
  String momoNo,

) async {

  return postData(
    '${_path}register/',
    jsonEncode(<String, String> {
      'fname': fname,
      'lname': lname,
      'ashesi_id': ashesiId,
      'ashesi_email': ashesiEmail,
      'passwd': password,
      'momo_no': momoNo,
    })
  );
  
}


Future<Map<String, dynamic>> loginBusUser (

  String ashesiEmail,
  String password,

) async {

  BusUserAuthProvider authProvider = BusUserAuthProvider();

  return authProvider.login(ashesiEmail, password, '${_path}login/');
  
}