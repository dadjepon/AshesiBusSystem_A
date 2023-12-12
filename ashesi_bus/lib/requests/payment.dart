import 'dart:convert';
import 'package:ashesi_bus/requests/api_uri.dart';
import 'package:http/http.dart' as http;

String _path = '/payment/';


/// This function send a POST request for making payment.
/// It allow a user with ID, busUserId to pay for an ongoing trip with ID, tripTakenId.
/// The amount is determined by the stop selected. All stops cost 3 cedis except those along the road from Ashesi to Kwabenya.
Future <Map<String, dynamic>> initiatePayment(int tripTakenId, double amount, int busUserId, int stopId) async {


  Map<String, dynamic> result = {};

  try {

    final response = await http.post(
      Uri.http(domain, '${_path}create_charge/'),
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String> {
        'trip_taken': tripTakenId.toString(),
        'amount': amount.toString(),
        'bus_user': busUserId.toString(),
        'stop': stopId.toString(),
      })
    );


    Map<String, dynamic> responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {

      result = {
        'status': true,
        'message': responseData["message"] ?? 'Success',
        'data': responseData["data"]
      };

    } 
    
    else {
      result = {
        'status': false,
        'message': responseData["message"] ?? 'An error occurred. Please try again.',
      };
    }

  } 
  
  catch (e) {
    result = {
      'status': false,
      'message': 'Request failed. Error: $e',
    };

    print(e);
  
  }



  return result;
}





