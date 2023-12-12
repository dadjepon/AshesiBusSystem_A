import 'driver_login.dart';
import 'get.dart';

String _path = '/driver/';

Future<Map<String, dynamic>> loginDriver (

  String driverAshesiId,
  
) async {

  DriverAuthProvider authProvider = DriverAuthProvider();

  return authProvider.login(driverAshesiId, '${_path}login/');
  
}


Future<Map<String,dynamic>> getDrivers () async {
  
    return fetchMap(
      '${_path}get_all/',
      {}
    );
    
}


Future<Map<String,dynamic>> getDriverById (int driverId) async {
  
    return fetchMap(
      '${_path}get',
      {
        'driver_id': driverId.toString()
      } 
    );
}