import 'package:ashesi_bus/models/driver.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class DriverPref {
  
  Future<void> saveDriver(Driver driver) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("driver_id", driver.driverId);
    prefs.setString("fname", driver.fname);
    prefs.setString("lname", driver.lname);
    prefs.setString("driver_ashesi_id", driver.driverAshesiId);
    prefs.setString("phone_number", driver.phoneNumber);
  }

  Future<Driver> getDriver() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int driverId = prefs.getInt("driver_id")!;
    String fname = prefs.getString("fname")!;
    String lname = prefs.getString("lname")!;
    String driverAshesiId = prefs.getString("driver_ashesi_id")!;
    String phoneNumber = prefs.getString("phone_number")!;

    Driver driver = Driver(
      driverId: driverId,
      fname: fname,
      lname: lname,
      driverAshesiId: driverAshesiId,
      phoneNumber: phoneNumber
    );

    return driver;

  }

  /// This method is used to clear the driver's data from the device.
  Future<Map<String, dynamic>> clearDriverData() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isRemoved = await prefs.clear();

    return {
      "isRemoved": isRemoved,
      "message": "You've been logged out successfully"
    };

  }

  /// This method is used to check if a user is logged in.
  Future<bool> isDriverLoggedIn() async {

    WidgetsFlutterBinding.ensureInitialized();

    SharedPreferences prefs = await SharedPreferences.getInstance();
  
    return prefs.containsKey('driver_id');

  }

}

