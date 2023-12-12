import 'get.dart';

String _path = '/vehicle/';


/// Retrieves a list of all vehicles
/// Returns a Future that resolves to a List of Maps, where each Map represents a vehicle and contains
/// vehicle information in key-value pairs
Future<List<Map<String,dynamic>>> getAllVehicles () async {
  
    return fetchListWithQueryParams(
      '${_path}get_all/',
      {}
    );

}


