import 'package:ashesi_bus/helper/functions/date_time.dart';
import 'package:ashesi_bus/helper/widgets/app_bar.dart';
import 'package:ashesi_bus/helper/widgets/future_builder.dart';
import 'package:ashesi_bus/helper/widgets/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:ashesi_bus/requests/trip.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// Displays a list of trips that have been completed by a driver.
class MyTrips extends StatefulWidget {

  const MyTrips(
    {
      super.key
    }
  );

  @override
  MyTripsState createState() => MyTripsState();

}

class MyTripsState extends State<MyTrips> {

  int _driverId = 0;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _driverId = prefs.getInt('driver_id')!;
      });
    });
  }

  Future<Map<String, List<Map<String, dynamic>>>> _getTripsCompleted() async {

    List<Map<String, dynamic>> trips = await getTripsCompletedByDriver(_driverId);

    // Organize trips by month
    Map<String, List<Map<String, dynamic>>> organizedTrips = {};

    for (var trip in trips) {
      String month = trip['date_time_started'].substring(0, 7); // Get the month part of the date
      organizedTrips.putIfAbsent(month, () => []).add(trip);
    }

    return organizedTrips;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: const RegularAppBarNoBack(
          title: "My Trips",
        ),

        body: AppFutureBuilder(

          future: _getTripsCompleted(),
          builder: (data) {

            Map<String, List<Map<String, dynamic>>> organizedTrips = data;

              return ListView.builder(
                itemCount: organizedTrips.length,
                itemBuilder: (context, index) {

                  String month = organizedTrips.keys.elementAt(index);


                  List<Map<String, dynamic>> trips = organizedTrips[month]!;

                  // String startTime = trip['trip_start_time'].substring(0, 5);
                  // String endTime = trip['trip_end_time'].substring(0, 5);

                  // String timeTripStarted = parseDateTime(trip['date_time_started'])[1];


                  return Column(
                    children: [

                      const SizedBox(height: 20),
                      
                      LeftAlignedText(
                        text: HeaderText(
                          text: formatMonth(month)
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Trips for the month
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: trips.length,
                        itemBuilder: (context, index) {
                          final trip = trips[index];
                          return TripCompletedInfoListTile(
                            trip: trip,
                          );
                        },
                      ),
                    ],
                  );
                },
              );
          },
          reloadPageFunction: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MyTrips(),
              ),
            );
          },
          couldNotLoadText: "your trips completed",
        ),
      ),
    );
  }
}
