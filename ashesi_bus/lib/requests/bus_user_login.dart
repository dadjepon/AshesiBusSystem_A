import 'dart:convert';
import 'package:ashesi_bus/models/bus_user.dart';
import 'package:ashesi_bus/models/bus_user_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'api_uri.dart';


class BusUserAuthProvider with ChangeNotifier {


  Future<Map<String, dynamic>> login(String ashesiEmail, String password, String path) async {

    Map<String, dynamic> result;

    // RESPONSE
    try {

      final response = await http.post(

        Uri.http(domain, path),

        headers: <String, String> {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },

        body: jsonEncode(<String, String> {
          'ashesi_email': ashesiEmail,
          'passwd': password,
        }),

      );

      if (response.statusCode == 200) {

        Map<String, dynamic> responseData = json.decode(response.body);

        Map<String, dynamic> busUserData = responseData['data'];

        BusUser busUser = BusUser.fromJson(busUserData);

        BusUserPref().saveBusUser(busUser);

        result = {
          'status': true, 
          'message': responseData['message'],
          'busUser': busUser
        };
      
        return result;
      
      }
         
      else {

        result = {
          'status': false,
          'message': "An error occurred"
        };

      }
      
      return result;

    }

    catch (e) {
      return result = {
        'status': false,
        'message': "An error occurred"
      };
    }

    
  }
}
