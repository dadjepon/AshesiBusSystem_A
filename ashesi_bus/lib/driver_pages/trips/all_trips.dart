import 'package:ashesi_bus/driver_pages/trips/start_trip.dart';
import 'package:flutter/material.dart';
import 'package:ashesi_bus/helper/widgets/app_bar.dart';
import 'package:ashesi_bus/helper/widgets/form.dart';
import 'package:ashesi_bus/helper/widgets/list_tile.dart';
import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:ashesi_bus/requests/trip.dart';

class AllTrips extends StatefulWidget {

  const AllTrips({
    super.key
  });

  @override
  AllTripsState createState() => AllTripsState();
}

class AllTripsState extends State<AllTrips> {

  late Future<List<List<Map<String, dynamic>>>> _tripsFuture;
  String _selectedTimeOfDay = 'Morning';

  @override
  void initState() {
    super.initState();
    _tripsFuture = _getAllTrips();
  }

  Future<List<List<Map<String, dynamic>>>> _getAllTrips() async {
    List<Map<String, dynamic>> morningTrips = await getMorningTrips();
    List<Map<String, dynamic>> afternoonTrips = await getAfternoonTrips();
    List<Map<String, dynamic>> eveningTrips = await getEveningTrips();

    return [morningTrips, afternoonTrips, eveningTrips];
  }

  String morningTripsNote = "Morning trips are from 6:00am to 11:59am";
  String afternoonTripsNote = "Afternoon trips are from 12:00pm to 5:59pm";
  String eveningTripsNote = "Evening trips are from 6:00pm to 11:59pm";

  Widget tripsListView(List<Map<String, dynamic>> trips) {

    return ListView.builder(
      shrinkWrap: true,
      itemCount: trips.length,
      itemBuilder: (context, index) {

        final trip = trips[index];

        return AppListTile(
          title: "${trip['trip_name']}",
          subtitle: "Tap to proceed to trip details",
          leading: const Icon(Icons.route),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StartTrip(trip: trip),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: RegularAppBar(
          prevContext: context,
          title: "All Trips",
        ),

        body: ListView(

          children: [

            AppDropDownButton(
              items: const ['Morning', 'Afternoon', 'Evening'],
              hintText: 'Select time of day',
              value: _selectedTimeOfDay,
              onChanged: (value) {
                setState(() {
                  _selectedTimeOfDay = value.toString();
                });
              },
            ),

            const SizedBox(height: 20),


            FutureBuilder(

              future: _tripsFuture,
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    strokeWidth: 2.0,
                  );
                } 
                
                else if (snapshot.hasError) {
                  return Center(
                    child: RegularText(
                      text: "An error occured while fetching trips",
                      color: Colors.black,
                    ),
                  );
                } 
                
                else {

                  List<List<Map<String, dynamic>>> allTrips = snapshot.data as List<List<Map<String, dynamic>>>;

                  List<Map<String, dynamic>> selectedTrips = [];

                  switch (_selectedTimeOfDay) {

                    case 'Morning':
                      selectedTrips = allTrips[0];
                      break;
                    case 'Afternoon':
                      selectedTrips = allTrips[1];
                      break;
                    case 'Evening':
                      selectedTrips = allTrips[2];
                      break;

                  }

                  return Column(
                    children: [
                      
                      LeftAlignedText (
                        text: RegularText(
                          text: _selectedTimeOfDay == 'Morning' ? morningTripsNote : _selectedTimeOfDay == 'Afternoon' ? afternoonTripsNote : eveningTripsNote,
                          color: Colors.black87,
                        )
                      ),

                      const SizedBox(height: 10),

                      tripsListView(selectedTrips),
                    ],
                  );
                  
                  
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
