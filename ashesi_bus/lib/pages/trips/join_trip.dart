import 'package:ashesi_bus/helper/functions/date_time.dart';
import 'package:ashesi_bus/helper/widgets/app_bar.dart';
import 'package:ashesi_bus/helper/widgets/dialog_box.dart';
import 'package:ashesi_bus/helper/widgets/form.dart';
import 'package:ashesi_bus/helper/widgets/future_builder.dart';
import 'package:ashesi_bus/helper/widgets/list_tile.dart';
import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:ashesi_bus/pages/account/transaction.dart';
import 'package:ashesi_bus/requests/payment.dart';
import 'package:ashesi_bus/requests/trip.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OngoingTripsDetails extends StatefulWidget {

  const OngoingTripsDetails(
    {
      super.key,
      required this.trip
    }
  );

  final Map<String, dynamic> trip;

  @override
  OngoingTripsState createState() => OngoingTripsState();

}

class OngoingTripsState extends State<OngoingTripsDetails> {

  int _selectedStopId = 0;
  double _fare = 0.0;
  int _busUserId = 0;

  @override
  void initState() {

    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _busUserId = prefs.getInt('bus_user_id')!;
      });
    });
  }


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
          title: "Trip Details",
        ),

        body: ListView(

          children: [

            const SizedBox(height: 20),

            LeftAlignedText(
              text: HeaderText(
                text: "Ongoing trip with ${widget.trip['fname']} ${widget.trip['lname']}",
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

            AppFutureBuilder(
              future: _getStopsForTrips(),
              builder: (data) {

                List<Map<String, dynamic>> stops = data;
                List <String> stopNames = [];

                for (var stop in stops) {
                  stopNames.add(stop['stop_name']);
                }

                
                // Create a mapping between license numbers and vehicle IDs
                Map<String, dynamic> stopNametoIdMap = {};
                for (var stop in stops) {
                  stopNametoIdMap[stop['stop_name']] = stop['stop_id'];
                }
                

                return AppDropDownButton(
                  items: stopNames,
                  hintText: "Where are you joining/alighting?",
                  onChanged: (value) {
                    setState(() {
                      _selectedStopId = stopNametoIdMap[value!]!;
                      _fare = stops.where((stop) => stop['stop_id'] == _selectedStopId).toList()[0]['price'];
                    });
                  },
                );

              }, 
              reloadPageFunction: () { 

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OngoingTripsDetails(
                      trip: widget.trip,
                    ),
                  ),
                ); 
              },
              couldNotLoadText: "stops for trip"
            ),

            const SizedBox(height: 20),

            Builder(
        
              builder: (BuildContext scaffoldContext) { 

                return SubmitFormButton(
                  text: "Proceed to Payment",
                  onPressed: () {

                    if (_selectedStopId == 0) {
                      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                        SnackBar(
                          content: RegularText(
                            text: "Please select a stop",
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.black87,
                        )
                      );
                      return;
                    }

                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return ConfirmDialogBox(
                          message: "Proceed to payment?", 
                          title: "You'll be charged GHS $_fare for this trip.", 
                          onOk: () async {

                            Map<String, dynamic> response = await initiatePayment(
                              widget.trip['trip_taken_id'],
                              _fare,
                              _busUserId,
                              _selectedStopId
                            );
                            
                            if (!mounted) return;

                            if (response['status']) {
                              
                              ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                                SnackBar(
                                  content: RegularText(
                                    text: response['message'],
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Colors.black87,
                                )
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Transaction(
                                    authorizationUrl: response['authorization_url'],
                                  ),
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
                                  backgroundColor: Colors.black87,
                                )
                              );
                            }

                          }
                        );

                      }

                    );

                
                  },
                );

              }
            )

          ],

        )
      ),
    );
  }
}
