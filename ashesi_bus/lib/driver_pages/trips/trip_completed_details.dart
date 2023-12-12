import 'package:ashesi_bus/helper/functions/date_time.dart';
import 'package:ashesi_bus/helper/widgets/app_bar.dart';
import 'package:ashesi_bus/helper/widgets/future_builder.dart';
import 'package:ashesi_bus/helper/widgets/list_tile.dart';
import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:ashesi_bus/requests/trip.dart';
import 'package:flutter/material.dart';


class TripCompletedDetails extends StatefulWidget {

  const TripCompletedDetails(
    {
      super.key,
      required this.trip
    }
  );

  final Map<String, dynamic> trip;

  @override
  TripCompletedDetailsState createState() => TripCompletedDetailsState();

}

class TripCompletedDetailsState extends State<TripCompletedDetails> {


  Future<List<Map<String, dynamic>>> _getStopsForTrips() async {
    return await getStopsForTrip(widget.trip['trip_id']);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: RegularAppBar(
          prevContext: context,
          title: "Trip Details",
        ),

        body: ListView(

          children: [

            const SizedBox(height: 20),

            LeftAlignedText(
              text: HeaderText(
                text: "Trip with ${widget.trip['fname']} ${widget.trip['lname']}",
              )
            ),

            const SizedBox(height: 20),

            LeftAlignedText(
              text: RegularText(
                text: "${formatDateIntoWords(widget.trip['date_time_started'])} at ${parseTime(widget.trip['date_time_started'])}",
              )
            ),

            const SizedBox(height: 20),

            AppListTile(
              title: widget.trip['trip_name'],
              leading: const Icon(Icons.route), 
              onTap: () {
              },
            ),

            AppListTile(
              title: widget.trip['vehicle_name'], 
              leading: const Icon(Icons.directions_bus), 
              onTap: () {
              }
            ),

            AppListTile(
              title: "${formatTime(parseTime(widget.trip['date_time_started']))} - ${formatTime(parseTime(widget.trip['date_time_ended']))}",
              leading: const Icon(Icons.access_time), 
              onTap: () {
              }
            ),

            

            const SizedBox(height: 20),

            const LeftAlignedText(
              text: HeaderText(
                text: "Stops",
              )
            ),

            const SizedBox(height: 10),

            AppFutureBuilder(
              future: _getStopsForTrips(), 
              builder: (data) {

                List<Map<String, dynamic>> stops = data;
                
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: stops.length,
                  itemBuilder: (context, index) {
                    final stop = stops[index];

                    return AppListTile(
                      title: stop['stop_name'],
                      leading: const Icon(Icons.location_on),
                      onTap: () {
                        
                      },
                    );
                  },
                );

              }, 
              reloadPageFunction: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TripCompletedDetails(
                      trip: widget.trip,
                    ),
                  ),
                );
              },
              couldNotLoadText: "trips for this driver"
            ),


          ],

        )
      ),
    );
  }
}
