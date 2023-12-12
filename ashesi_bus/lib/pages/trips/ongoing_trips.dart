import 'package:ashesi_bus/helper/widgets/app_bar.dart';
import 'package:ashesi_bus/helper/widgets/form.dart';
import 'package:ashesi_bus/helper/widgets/list_tile.dart';
import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:ashesi_bus/requests/trip.dart';
import 'package:flutter/material.dart';


class OngoingTrips extends StatefulWidget {

  const OngoingTrips(
    {
      super.key
    }
  );

  @override
  OngoingTripsState createState() => OngoingTripsState();

}

class OngoingTripsState extends State<OngoingTrips> {
  Future<List<Map<String, dynamic>>> _getOngoingTrips() async {
    return await getOngoingTrips();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: RegularAppBar(
          prevContext: context,
          title: "Ongoing Trips",
        ),

        body: FutureBuilder(

          future: _getOngoingTrips(),
          builder: (context, snapshot) {

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
                      text: "An error occurred. Please try again later.",
                      color: Colors.black,
                    ),

                    const SizedBox(height: 10),

                    SubmitFormButton(
                      onPressed: () {
                        // Retry the operation
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OngoingTrips(),
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
              
              List<Map<String, dynamic>> trips = snapshot.data!;

              return ListView.builder(
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  final trip = trips[index];

                  // String startTime = trip['trip_start_time'].substring(0, 5);
                  // String endTime = trip['trip_end_time'].substring(0, 5);

                  // String timeTripStarted = parseDateTime(trip['date_time_started'])[1];


                  return OngoingTripInfoListTile(
                    trip: trip,
                    
                  );
                },
              );
            }   

            else if (snapshot.data!.isEmpty) {
              return Center(
                child: RegularText(
                  text: "No ongoing trips",
                  color: Colors.black, 
                )

              );
            }          
            
            else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
