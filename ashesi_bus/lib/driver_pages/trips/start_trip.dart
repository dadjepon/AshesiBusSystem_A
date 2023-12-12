import 'package:ashesi_bus/helper/widgets/app_bar.dart';
import 'package:ashesi_bus/helper/widgets/form.dart';
import 'package:ashesi_bus/helper/widgets/future_builder.dart';
import 'package:ashesi_bus/helper/widgets/list_tile.dart';
import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:ashesi_bus/requests/trip.dart';
import 'package:ashesi_bus/requests/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StartTrip extends StatefulWidget {

  const StartTrip(
    {
      super.key,
      required this.trip
    }
  );

  final Map<String, dynamic> trip;

  @override
  StartTripState createState() => StartTripState();

}

class StartTripState extends State<StartTrip> {


  Future<List<Map<String, dynamic>>> _getStopsForTrips() async {
    return await getStopsForTrip(widget.trip['trip_id']);
  }

  Future<List<Map<String, dynamic>>> _getAllVehicles() async {
    return await getAllVehicles();
  }

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

  int _selectedVehicleId = 0;


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


            AppFutureBuilder(
              future: _getStopsForTrips(), 
              builder: (data) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final stop = data[index];

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
                    builder: (context) => StartTrip(
                      trip: widget.trip,
                    ),
                  ),
                );
              }, 
              couldNotLoadText: "stops for this trip",
            ),

            const SizedBox(height: 20),

            const LeftAlignedText(
              text: HeaderText(
                text: "Select Vehicle",
              )
            ),


            AppFutureBuilder(
              future: _getAllVehicles(), 
              builder: (data) {

                List<Map<String,dynamic>> vehicles = data;

                List<String> licenseNumbers = [];

                for (var vehicle in vehicles) {
                  licenseNumbers.add(vehicle['license_no']);
                }

                // Create a mapping between license numbers and vehicle IDs
                Map<String, dynamic> licenseToIdMap = {};
                for (var vehicle in vehicles) {
                  licenseToIdMap[vehicle['license_no']] = vehicle['vehicle_id'];
                }
                                            
                  return AppDropDownButton(
                    items: licenseNumbers,
                    hintText: "Which vehicle are you using?",
                    onChanged: (value) {
                      setState(() {
                        _selectedVehicleId = licenseToIdMap[value!]!;
                      });
                    },
                  );                 
                
              },
              reloadPageFunction: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StartTrip(
                      trip: widget.trip,
                    ),
                  ),
                );
              }, 
              couldNotLoadText: "vehicles.",
            ),


            const SizedBox(height: 20),

            SubmitFormButton(
              onPressed: () async {
                
                Map<String, dynamic> response = await startTrip(
                   widget.trip['trip_id'],
                  _driverId,     
                  _selectedVehicleId
                );

                if (!mounted) return;

                if (response['status']) {

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: RegularText(
                        text: "Trip started successfully!",
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.black87,
                      duration: const Duration(seconds: 5),
                    )
                  );

                  Navigator.pop(context);
                }

                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: RegularText(
                        text: response['message'],
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.black87,
                    )
                  );
                }

              },
              text: "Start Trip",
            ),

          ],

        )
      ),
    );
  }
}
