import 'driver_login.dart';
import 'get.dart';

String _path = '/driver/';


/// This function send a POST request for driver login. The driver logs in with their driver ID.
Future<Map<String, dynamic>> loginDriver (

  String driverAshesiId,
  
) async {

  DriverAuthProvider authProvider = DriverAuthProvider();

  return authProvider.login(driverAshesiId, '${_path}login/');
  
}


/// This function sends a GET request to obtain all drivers.
Future<Map<String,dynamic>> getDrivers () async {
  
    return fetchMap(
      '${_path}get_all/',
      {}
    );
    
}


/// This function sends a GET request to obtain a driver by his/her ID.
Future<Map<String,dynamic>> getDriverById (int driverId) async {
  
    return fetchMap(
      '${_path}get',
      {
        'driver_id': driverId.toString()
      } 
    );
}
