import 'dart:convert';

import 'package:ashesi_bus/requests/patch.dart';

import 'get.dart';

String _path = '/parking_space/';

Future<List<Map<String,dynamic>>> getAllParkingSpaces () async {
  
    return fetchListWithoutQueryParams(
      '${_path}get_all/',
    );

}

Future<Map<String,dynamic>> parkVehicle (int vehicleId, int parkingSpaceId) async {

  return update(
    '${_path}park_vehicle/',
    jsonEncode(<String, dynamic> {
      'vehicle_id': vehicleId,
      'parking_space_id': parkingSpaceId
    })    
  );

}


Future<Map<String,dynamic>> unparkVehicle (int parkingSpaceId) async {

  return update(
    '${_path}unpark_vehicle/',
    jsonEncode(<String, dynamic> {
      'parking_space_id': parkingSpaceId,
    })    
  );

}

Future<List<Map<String,dynamic>>> getVehiclesParked () async {
  
    return fetchListWithoutQueryParams(
      '${_path}get_vehicles_parked/',
    );

}
