import 'package:ashesi_bus/helper/functions/date_time.dart';
import 'package:ashesi_bus/helper/widgets/future_builder.dart';
import 'package:flutter/material.dart';
import 'package:ashesi_bus/helper/widgets/app_bar.dart';
import 'package:ashesi_bus/helper/widgets/list_tile.dart';
import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:ashesi_bus/requests/trip.dart';

class TripPassengers extends StatefulWidget {

  const TripPassengers({
    super.key,
    required this.trip
  });

  @override
  TripPassengersState createState() => TripPassengersState();

  final Map<String, dynamic> trip;
}

class TripPassengersState extends State<TripPassengers> {


  Future<List<Map<String, dynamic>>> _getTripPassengers () async {
    List<Map<String, dynamic>> tripPassengers = await getTripPassengers(widget.trip['trip_taken_id']);

    return tripPassengers;
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: RegularAppBar(
          prevContext: context,
          title: "Trip Passengers",
        ),

        body: AppFutureBuilder(
          future: _getTripPassengers(),
          builder: (data) {
            
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {

                final passenger = data[index];

                return AppListTile(
                  title: "${passenger['fname']} ${passenger['lname']}",
                  subtitle: "Paid at ${parseTime(passenger['payment_date_time'])}",
                  leading: const Icon(Icons.person),
                  trailing: RegularText(text: "GHS ${passenger['amount']}"),
                  onTap: () {},
                );
              },
            );
          },

          couldNotLoadText: "passengers",

          reloadPageFunction: () {
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(
                builder: (context) => TripPassengers(trip: widget.trip)
              )
            );
          },
        ),
        
      ),
    );
  }
}
