import 'get.dart';

String _path = '/vehicle/';

Future<List<Map<String,dynamic>>> getAllVehicles () async {
  
    return fetchListWithQueryParams(
      '${_path}get_all/',
      {}
    );

}


