import 'package:ashesi_bus/helper/functions/date_time.dart';
import 'package:ashesi_bus/helper/widgets/app_bar.dart';
import 'package:ashesi_bus/helper/widgets/form.dart';
import 'package:ashesi_bus/helper/widgets/list_tile.dart';
import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:ashesi_bus/pages/receipt.dart';
import 'package:flutter/material.dart';


class TripTakenDetails extends StatefulWidget {

  const TripTakenDetails(
    {
      super.key,
      required this.trip
    }
  );

  final Map<String, dynamic> trip;

  @override
  TripTakenDetailsState createState() => TripTakenDetailsState();

}

class TripTakenDetailsState extends State<TripTakenDetails> {


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

            const SizedBox(height: 10),


            LeftAlignedText(
              text: RegularText(
                text: "GHS ${widget.trip['amount'].toString()[0]}",
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

            AppListTile(
              title: "${widget.trip['no_of_passengers'].toString()} passengers", 
              leading: const Icon(Icons.people), 
              onTap: () {
              }
            ),

            AppListTile(
              title: "Joined at ${widget.trip['stop_name']}", 
              leading: const Icon(Icons.location_on),
              onTap: () {
              }
            ),
            

            const SizedBox(height: 10),


            SubmitFormButton(
              text: "Generate Receipt",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Receipt(
                      trip: widget.trip,
                    )
                  )
                );
              },
            )
            

          ],

        )
      ),
    );
  }
}
