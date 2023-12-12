import 'dart:convert';

import 'package:ashesi_bus/requests/patch.dart';

import 'get.dart';

String _path = '/parking_space/';


/// This function sends a GET request to get a list of all parking spaces as maps.
Future<List<Map<String,dynamic>>> getAllParkingSpaces () async {
  
    return fetchListWithoutQueryParams(
      '${_path}get_all/',
    );

}

/// This function sends a PATCH request to update the vehicle parked in the parking space with ID, parkingSpaceId.
Future<Map<String,dynamic>> parkVehicle (int vehicleId, int parkingSpaceId) async {

  return update(
    '${_path}park_vehicle/',
    jsonEncode(<String, dynamic> {
      'vehicle_id': vehicleId,
      'parking_space_id': parkingSpaceId
    })    
  );

}

/// This function sends a PATCH request to set the vehicle field in the parking space entry with ID, parkingSpaceId to null.
Future<Map<String,dynamic>> unparkVehicle (int parkingSpaceId) async {

  return update(
    '${_path}unpark_vehicle/',
    jsonEncode(<String, dynamic> {
      'parking_space_id': parkingSpaceId,
    })    
  );

}


/// This function sends a GET request to get a list of all vehicles parked.
Future<List<Map<String,dynamic>>> getVehiclesParked () async {
  
    return fetchListWithoutQueryParams(
      '${_path}get_vehicles_parked/',
    );

}
