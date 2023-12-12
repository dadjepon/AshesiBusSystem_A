import 'dart:convert';
import 'package:ashesi_bus/models/driver.dart';
import 'package:ashesi_bus/models/driver_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'api_uri.dart';


class DriverAuthProvider with ChangeNotifier {


  Future<Map<String, dynamic>> login(String driverAshesiId, String path) async {

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
          'driver_ashesi_id': driverAshesiId,
        }),

      );

      if (response.statusCode == 200) {

        Map<String, dynamic> responseData = json.decode(response.body);

        Map<String, dynamic> driverData = responseData['data'];

        Driver driver = Driver.fromJson(driverData);

        DriverPref().saveDriver(driver);

        result = {
          'status': true, 
          'message': responseData['message'],
          'driver': driver
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
