import 'package:ashesi_bus/helper/widgets/future_builder.dart';
import 'package:ashesi_bus/helper/widgets/list_tile.dart';
import 'package:ashesi_bus/requests/parking_space.dart';
import 'package:ashesi_bus/requests/vehicle.dart';
import 'package:flutter/material.dart';
import '../../helper/widgets/app_bar.dart';

class Parking extends StatefulWidget {

  const Parking(
    {
      super.key
    }
  );

  @override
  ParkingState createState() => ParkingState();

}

class ParkingState extends State<Parking> {

  Future<List<Map<String, dynamic>>> _getAllParkingSpaces () async {

    return await getAllParkingSpaces();

  }

  Future<List<Map<String, dynamic>>> _getAllVehicles () async {

    return await getAllVehicles();

  }

  Future<List<List<Map<String, dynamic>>>> _getAllParkingSpacesAndVehicles () async {

    List<Map<String, dynamic>> parkingSpaces = await _getAllParkingSpaces();
    List<Map<String, dynamic>> vehicles = await _getAllVehicles();

    return [parkingSpaces, vehicles];

  }

  int vehicleId = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RegularAppBarNoBack(
        title: "Parking"
      ),
      body: AppFutureBuilder(
        future: _getAllParkingSpacesAndVehicles(), 
        builder: (data) {
          return ListView.builder(
            itemCount: data[0].length,
            itemBuilder: (context, index) {

              Map<String,dynamic> parkingSpace = data[0][index];

              if (parkingSpace['parking_vehicle_id'] == null) {
                parkingSpace['parking_vehicle_name'] = "No vehicle parked";
              }

              return ParkingSpaceListTile(
                parkingSpace: parkingSpace,
                vehicles: data[1],
                vehicleId: vehicleId,
              );
            }
          );
        },
        couldNotLoadText: "parking spaces",
        reloadPageFunction: () {
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(
              builder: (context) => const Parking()
            )
          );
        },
      )
    );
  }

}