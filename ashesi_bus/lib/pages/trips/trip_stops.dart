import 'package:ashesi_bus/helper/widgets/app_bar.dart';
import 'package:ashesi_bus/helper/widgets/form.dart';
import 'package:ashesi_bus/helper/widgets/list_tile.dart';
import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:ashesi_bus/requests/trip.dart';
import 'package:flutter/material.dart';


class TripStops extends StatefulWidget {

  const TripStops(
    {
      super.key,
      required this.trip
    }
  );

  final Map<String, dynamic> trip;

  @override
  TripStopsState createState() => TripStopsState();

}

class TripStopsState extends State<TripStops> {


  Future <List<Map<String, dynamic>>> _getStopsForTrips() async {
    return await getStopsForTrip(widget.trip['trip_id']);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: RegularAppBar(
          prevContext: context,
          title: "Trip ${widget.trip['trip_id']}",
        ),

        body: ListView(

          children: [

            const SizedBox(height: 20),

            AppListTile(
              title: widget.trip['trip_name'],
              leading: const Icon(Icons.route), 
              onTap: () {
              },
            ),

            AppListTile(
              title: "${widget.trip['trip_start_time'].toString().substring(0, 5)} - ${widget.trip['trip_end_time'].toString().substring(0, 5)}",
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

            FutureBuilder(

              future: _getStopsForTrips(),  
              builder:(context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } 

                else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RegularText(
                          text: "Could not load stops for this trip. Please try again later.",
                          color: Colors.black,
                        ),

                        const SizedBox(height: 10),

                        SubmitFormButton(
                          onPressed: () {
                            // Retry the operation
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TripStops(
                                  trip: widget.trip,
                                ),
                              ),
                            );
                          },
                          text: "Retry",
                        ),
                      ],
                    ),
                  );
                }

                else if (snapshot.hasData) {

                  List<Map<String, dynamic>> stops = snapshot.data!;
                  
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
                }

                else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

              },
            ),

          ],

        )
      ),
    );
  }
}
