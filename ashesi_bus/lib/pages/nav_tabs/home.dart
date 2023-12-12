import 'package:ashesi_bus/helper/functions/date_time.dart';
import 'package:ashesi_bus/helper/functions/string.dart';
import 'package:ashesi_bus/helper/widgets/app_bar.dart';
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

  Future<List<Map<String, dynamic>>> _getBusUserOngoingTrips () async {

    return await getBusUserOngoingTrips(_busUserId);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: const HomeAppBar(),

      body: ListView (

        children: [

          AppFutureBuilder(
            future: _getBusUserOngoingTrips(), 
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

                  AppListTile(
                    title: "GHS ${trip['amount'].toString()[0]}", 
                    leading: const Icon(Icons.money),
                    onTap: () {
                    }
                  )
                  
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
            future: _getBusUserOngoingTrips(),
            builder: (data) {
              if (data.length > 0) {
                return const SizedBox(height: 0);
              }

              return const JoinTripContainer();
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