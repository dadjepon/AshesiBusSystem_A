import 'package:ashesi_bus/models/bus_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


/// This class is used to save and retrieve the user's data from the device.
class BusUserPref {
  

  /// This method is used to save the user's data to the device.
  Future<void> saveBusUser(BusUser busUser) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("bus_user_id", busUser.busUserId);
    prefs.setString("fname", busUser.fname);
    prefs.setString("lname", busUser.lname);
    prefs.setString("ashesi_email", busUser.emailAddress);
    prefs.setString("momo_no", busUser.momoNo);
    prefs.setString("ashesi_id", busUser.ashesiId);

  }


  /// This method is used to retrieve the user's data from the device.
  Future<BusUser> getBusUser() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int busUserId = prefs.getInt("bus_user_id")!;
    String fname = prefs.getString("fname")!;
    String lname = prefs.getString("lname")!;
    String emailAddress = prefs.getString("ashesi_email")!;
    String momoNo = prefs.getString("momo_no")!;
    String ashesiId = prefs.getString("ashesi_id")!;


    BusUser busUser = BusUser(
      busUserId: busUserId,
      fname: fname,
      lname: lname,
      emailAddress: emailAddress,
      momoNo: momoNo,
      ashesiId: ashesiId,
    );

    return busUser;

  }

  /// This method is used to clear the user's data from the device.
  Future<Map<String, dynamic>> clearBusUserData() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isRemoved = await prefs.clear();

    return {
      "isRemoved": isRemoved,
      "message": "You've been logged out successfully"
    };

  }

  /// This method is used to check if a user is logged in.
  Future<bool> isBusUserLoggedIn() async {

    WidgetsFlutterBinding.ensureInitialized();

    SharedPreferences prefs = await SharedPreferences.getInstance();
  
    return prefs.containsKey('bus_user_id');

  }

}

