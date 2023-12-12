import 'package:ashesi_bus/driver_pages/nav_tabs/entry.dart';
import 'package:ashesi_bus/driver_pages/trips/trip_passengers.dart';
import 'package:ashesi_bus/helper/functions/date_time.dart';
import 'package:ashesi_bus/helper/functions/string.dart';
import 'package:ashesi_bus/helper/widgets/app_bar.dart';
import 'package:ashesi_bus/helper/widgets/dialog_box.dart';
import 'package:ashesi_bus/helper/widgets/form.dart';
import 'package:ashesi_bus/helper/widgets/future_builder.dart';
import 'package:ashesi_bus/helper/widgets/list_tile.dart';
import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:ashesi_bus/requests/trip.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/widgets/app_container.dart';


class Home extends StatefulWidget {

  const Home(
    {
      super.key
    }
  );

  @override
  HomeState createState() => HomeState();

}

class HomeState extends State<Home> {

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

  Future<List<Map<String, dynamic>>> _getOngoingTripsByDriver () async {

    return await getOngoingTripsStartedByDriver(_driverId);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: const HomeAppBar(),

      body: ListView (

        children:  [

          AppFutureBuilder(
            future: _getOngoingTripsByDriver(),
            builder: (data) {
              if (data.length == 0) {
                return const SizedBox(height: 0);
              }
              
              Map<String, dynamic> trip = data[0];
              String startTime = formatTime(parseTime(trip['date_time_started']));


              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [

                  const SizedBox(height: 10),
                  
                  LeftAlignedText(
                    text: HeaderText(
                      text: "Ongoing Trip to ${getLastWord(trip['trip_name'])}",
                      color: Colors.black,
                    )
                  ),

                  const SizedBox(height: 10),

                  LeftAlignedText(
                    text: RegularText(
                      text: "${formatDateIntoWords(trip['date_time_started'])} at ${parseTime(trip['date_time_started'])}",
                    )
                  ),

                  const SizedBox(height: 20),

                  AppListTile(
                    title: trip['trip_name'], 
                    leading: const Icon(Icons.route),  
                    onTap: () {

                    }
                  ),

                  AppListTile(
                    title: "${trip['vehicle_name']}", 
                    leading: const Icon(Icons.directions_bus),  
                    onTap: () {
                    }
                  ),

                  AppListTile(
                    title: "Started at $startTime", 
                    leading: const Icon(Icons.access_time),  
                    onTap: () {
                    }
                  ),

                  // number of passengers
                  AppListTile(
                    title: "${trip['no_of_passengers'].toString()} passengers", 
                    leading: const Icon(Icons.people),  
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TripPassengers(trip: trip)
                        ),
                      );
                    }
                  ),

                  Builder(
                    builder: (BuildContext scaffoldContext) {
                      return SubmitFormButton(
                        text: "End Trip",
                        onPressed: () {

                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return  ConfirmDialogBox(
                                title: "End Trip",
                                message: "Are you sure you want to end this trip?",
                                onOk: () async {

                                  Map<String, dynamic> response = await endTrip(
                                    trip['trip_taken_id']
                                  );



                                  if (!mounted) return;

                                  if (response['status']) {
                                    ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                                      SnackBar(
                                        content: RegularText(
                                          text: '${response['message']}. Please wait while we redirect you to the entry page',
                                          color: Colors.white,
                                        ),
                                        duration: const Duration(seconds: 3),
                                        backgroundColor: Colors.black54,
                                      )
                                    );

                                    // wait for 3 seconds
                                    await Future.delayed(const Duration(seconds: 3));

                                    if (!mounted) return;

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const DriverEntry(),
                                      ),
                                    );
                                  }

                                  else {
                                    ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                                      SnackBar(
                                        content: RegularText(
                                          text: response['message'],
                                          color: Colors.white,
                                        ),
                                        backgroundColor: Colors.black54,
                                      )
                                    );
                                  }

                                },
                              );
                            }
                          );
                          
                        },
                      );
                    },
                  ),
                  
                ],
          
              );
            },
            reloadPageFunction: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            }, 
            couldNotLoadText: "loading ongoing trips",
          ),

          const SizedBox(height: 20),

          AppFutureBuilder(
            future: _getOngoingTripsByDriver(),
            builder: (data) {
              if (data.length > 0) {
                return const SizedBox(height: 0);
              }

              return const StartTripContainer();
            },
            reloadPageFunction: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            },
            couldNotLoadText: "ongoing trips",
          ),
          
      
          const BusScheduleContainer(),         
        ],
        
      ),
    );
  }

}