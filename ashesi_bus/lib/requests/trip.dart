import 'dart:convert';

import 'get.dart';
import 'post.dart';

import 'patch.dart';

String _path = '/trip/';



/// Starts a trip with the given trip ID, driver ID, and vehicle ID.
/// Returns a Future of a Map containing a message field which tells whether the request was successful or not.
/// The Map has keys of type String and values of type dynamic.
/// The keys in the Map include:
///   - "message": A String which tells whether the request was successful or not.
Future<Map<String,dynamic>> startTrip (int tripId, int driverId, int vehicleId) async {

  return postData(
    '${_path}start/',
    jsonEncode(<String, String> {
      'trip': tripId.toString(),
      'driver': driverId.toString(),
      'vehicle': vehicleId.toString()
    })
  );

}


/// Ends a trip with the given trip ID.
/// Returns a Future of a Map containing a message field which tells whether the request was successful or not.
/// The Map has keys of type String and values of type dynamic.
/// The keys in the Map include:
///  - "message": A String which tells whether the request was successful or not.
Future<Map<String,dynamic>> getTripById (int tripId) async {

  return fetchMap(
    '${_path}get',
    {
      'trip_id': tripId.toString()
    } 
  );

}


/// Retrieves all trips from the database.
/// Returns a list of maps, where each map represents a trip with its associated data.
Future<List<Map<String, dynamic>>> getAllTrips () async {

  return fetchListWithoutQueryParams(
    '${_path}get_all/',
  );

}


/// Retrieves a list of morning trips.
/// Morning trips are trips that start between 6:00 AM and 11:59 AM.
/// Returns a Future that resolves to a List of Maps, where each Map represents a trip and contains
/// trip information in key-value pairs.
/// The key "dynamic" represents the type of the values in the Map.
Future<List<Map<String, dynamic>>> getMorningTrips () async {

  return fetchListWithoutQueryParams(
    '${_path}get_morning_trips/',
  );

}


/// Retrieves a list of afternoon trips.
/// Afternoon trips are trips that start between 12:00 PM and 5:59 PM.
/// Returns a Future that resolves to a List of Maps, where each Map represents a trip and contains
/// trip information in key-value pairs.
Future<List<Map<String, dynamic>>> getAfternoonTrips () async {

  return fetchListWithoutQueryParams(
    '${_path}get_afternoon_trips/',
  );

}


/// Retrieves a list of evening trips.
/// Evening trips are trips that start between 6:00 PM and 11:59 PM.
/// Returns a Future that resolves to a List of Maps, where each Map represents a trip and contains
/// trip information in key-value pairs.
Future<List<Map<String, dynamic>>> getEveningTrips () async {

  return fetchListWithoutQueryParams(
    '${_path}get_evening_trips/',
  );

}


/// Retrieves a list of ongoing trips.
/// Ongoing trips are trips in the TripTaken table that have been started today but have not been ended.
/// Returns a Future that resolves to a List of Maps, where each Map represents a trip and contains
/// trip information in key-value pairs
Future<List<Map<String, dynamic>>> getOngoingTrips () async {

  return fetchListWithoutQueryParams(
    '${_path}get_ongoing_trips/',
  );

}


/// Retrieves a list of ongoing trips that have been started by a driver.
/// Ongoing trips are trips in the TripTaken table that have not been ended.
/// Returns a Future that resolves to a List of Maps, where each Map represents a trip and contains
/// trip information in key-value pairs
Future<List<Map<String, dynamic>>> getOngoingTripsStartedByDriver (int driverId) async {

  return fetchListWithQueryParams(
    '${_path}get_ongoing_trips_started_by_driver',
    {
      'driver_id': driverId.toString()
    }
  );

}


/// Retrieves a list of ended trips that a bus user has joined.
/// Ended trips are trips in the TripTaken table that have is_ended set to 1.
/// Returns a Future that resolves to a List of Maps, where each Map represents a trip and contains
/// trip information in key-value pairs
Future<List<Map<String, dynamic>>> getBusUserEndedTrips (int busUserId) async {

  return fetchListWithQueryParams(
    '${_path}get_bus_user_ended_trips',
    {
      'bus_user_id': busUserId.toString()
    }
  );

}


/// Retrieves a list of ongoing trips that the bus user is on. The bus user is allowed to be on one trip at a time.
/// Ongoing trips are trips in the TripTaken table that have not been ended.
/// Returns a Future that resolves to a List of Maps, where each Map represents a trip and contains
/// trip information in key-value pairs
Future<List<Map<String, dynamic>>> getBusUserOngoingTrips (int busUserId) async {

  return fetchListWithQueryParams(
    '${_path}get_bus_user_ongoing_trips',
    {
      'bus_user_id': busUserId.toString()
    }
  );

}

/// Retrieves a list of stops for a trip with ID, tripId.
/// Returns a Future that resolves to a List of Maps, where each Map represents a stop and contains
/// stop details in key-value pairs
Future<List<Map<String, dynamic>>> getStopsForTrip (int tripId) async {

  return fetchListWithQueryParams(
    '${_path}get_stops_for_trip',
    {
      'trip_id': tripId.toString()
    } 
  );

}

/// Retrieves a list of all trips and their stops.
/// Returns a Future that resolves to a List of Maps, where each Map represents a trip and contains
/// trip details in key-value pairs, where one of the key-value pair's value is a list of maps, where 
/// each map represents a stop along the trip.
Future<List<Map<String, dynamic>>> getAllTripsAndStops () async {

  return fetchListWithoutQueryParams(
    '${_path}get_trips_and_stops/',
  );

}


/// Retrieves a list of all trips that have been started
/// Returns a Future that resolves to a List of Maps, where each Map represents a trip and contains
/// stop details in key-value pairs
Future<List<Map<String, dynamic>>> getAllTripsTaken () async {

  return fetchListWithoutQueryParams(
    '${_path}get_all_trips_taken/',
  );

}


/// Retrieves a list of all trips that have been completed by a driver with id, driverId.
/// A completed trip has its is_ended field set to 1.
/// Returns a Future that resolves to a List of Maps, where each Map represents a trip and contains
/// stop details in key-value pairs
Future<List<Map<String, dynamic>>> getTripsCompletedByDriver (int driverId) async {

  return fetchListWithQueryParams(
    '${_path}get_trips_completed_by_driver',
    {
      'driver_id': driverId.toString()
    }
  );

}


/// Retrieves a list of all bus users who have paid for a trip.
/// Returns a Future that resolves to a List of Maps, where each Map represents a bus user and contains
/// user details in key-value pairs
Future<List<Map<String, dynamic>>> getTripPassengers (int tripTakenId) async {

  return fetchListWithQueryParams(
    '${_path}get_trip_passengers',
    {
      'trip_taken_id': tripTakenId.toString()
    }
  );

}


/// Updates the is_ended field for an ongoing trip to 1.
Future<Map<String, dynamic>> endTrip (int tripTakenId) async {

  return update(
    '${_path}end/',
    jsonEncode(<String, dynamic> {
      'trip_taken_id': tripTakenId
    })
  );

}


