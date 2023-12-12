// ignore_for_file: must_be_immutable
import 'package:ashesi_bus/driver_pages/trips/trip_completed_details.dart';
import 'package:ashesi_bus/helper/functions/date_time.dart';
import 'package:ashesi_bus/helper/widgets/dialog_box.dart';
import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:ashesi_bus/driver_pages/nav_tabs/entry.dart';
import 'package:ashesi_bus/pages/trips/join_trip.dart';
import 'package:ashesi_bus/pages/trips/trip_taken_details.dart';
import 'package:ashesi_bus/requests/parking_space.dart';
import 'package:flutter/material.dart';

class AppListTile extends StatelessWidget {

  AppListTile(
    {
      super.key, 
      required this.title,
      this.color = Colors.black,
      this.subtitle = "",
      required this.leading,
      this.trailing,
      required this.onTap
    }
  );

  final String title;
  final Color? color;
  String subtitle;
  final Widget leading;
  Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: SubHeaderText(text: title, color: color!,),
      subtitle: RegularText(text: subtitle),
      leading: leading,
      trailing: trailing,
      onTap: onTap,
    );
  }

}


class MyTripListTile extends StatelessWidget{

  MyTripListTile({

    super.key,
    required this.tripName,
    required this.dateOfTrip,
    required this.tripFee

  });

  String tripName;
  String dateOfTrip;
  int tripFee;

  @override 
  Widget build (BuildContext context){
    return AppListTile(

      title: tripName,
      subtitle: dateOfTrip,
      leading: const Icon(
        Icons.route,
        size: 20,
        color: Colors.grey,
      ),
      trailing: RegularText(
        text: '${tripFee.toString()} GHC'
      ),    
      onTap: () {

      },

    );
  }

}


class OngoingTripInfoListTile extends StatelessWidget{

  OngoingTripInfoListTile({

    super.key,

    required this.trip

  });

  Map<String, dynamic> trip;

  @override 
  Widget build (BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.1,
          ),
        ),
      ),
      child: AppListTile(

        title: trip['trip_name'],
        subtitle: "Started at ${parseTime(trip['date_time_started'])}",
        leading: const Icon(
          Icons.route,
          size: 20,
          color: Colors.grey,
        ),
        trailing: HeaderText(
          text: trip['trip_id'].toString()
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OngoingTripsDetails(
                trip: trip,
              ),
            ),
          );
        },

      ),
    );
    
  }

}



class TripCompletedInfoListTile extends StatelessWidget{

  TripCompletedInfoListTile({

    super.key,

    required this.trip

  });

  Map<String, dynamic> trip;

  @override 
  Widget build (BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.1,
          ),
        ),
      ),
      child: AppListTile(

        title: trip['trip_name'],
        subtitle: "${formatDateIntoWords(trip['date_time_started'])}, ${parseTime(trip['date_time_started'])}",
        leading: const Icon(
          Icons.route,
          size: 20,
          color: Colors.grey,
        ),
        trailing: HeaderText(
          text: trip['trip_id'].toString()
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TripCompletedDetails(
                trip: trip,
              ),
            ),
          );
        },

      ),
    );
    
  }

}


class TripTakenInfoListTile extends StatelessWidget{

  TripTakenInfoListTile({

    super.key,

    required this.trip

  });

  Map<String, dynamic> trip;

  @override 
  Widget build (BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.1,
          ),
        ),
      ),
      child: AppListTile(

        title: trip['trip_name'],
        subtitle: "${formatDateIntoWords(trip['date_time_started'])}, ${parseTime(trip['date_time_started'])}",
        leading: const Icon(
          Icons.route,
          size: 20,
          color: Colors.grey,
        ),
        trailing: HeaderText(
          text: trip['trip_id'].toString()
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TripTakenDetails(
                trip: trip,
              ),
            ),
          );
        },

      ),
    );
    
  }

}


class ParkingSpaceListTile extends StatefulWidget{

  ParkingSpaceListTile({

    super.key,

    required this.parkingSpace,
    required this.vehicles,
    required this.vehicleId

  });

  Map<String, dynamic> parkingSpace;
  List<Map<String, dynamic>> vehicles;
  int vehicleId;

  @override
  ParkingSpaceListTileState createState() => ParkingSpaceListTileState();

}


class ParkingSpaceListTileState extends State<ParkingSpaceListTile>{



  @override 
  Widget build (BuildContext context){
    return AppListTile(

      title: widget.parkingSpace['parking_space_name'],
      subtitle: (widget.parkingSpace['vehicle_id'] != null)
      ? '${widget.parkingSpace['vehicle_name']} - ${widget.parkingSpace['license_no']}'
      : "No vehicle parked",
      leading: const Icon(
        Icons.local_parking,
        size: 20,
        color: Colors.grey,
      ),
      trailing: PopupMenuButton(
        itemBuilder: (BuildContext subcontext) {
          if (widget.parkingSpace['vehicle_id'] == null) {
            return <PopupMenuEntry>[
              PopupMenuItem(
                value: 'Park',
                child: RegularText(text: 'Park Vehicle'),
                onTap: () {

                  showDialog(
                    context: context, 
                    builder: (BuildContext context) {
                      return DialogBoxWithDropDown(
                        hintText: "Select vehicle to park",
                        message: "", 
                        title: "Park Vehicle", 
                        onOk: () async {

                          Map <String, dynamic> response = await parkVehicle(
                            widget.vehicleId,
                            widget.parkingSpace['parking_space_id'],
                          );

                          if (!mounted) return;

                          if (response['status']) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DriverEntry(initialTab: 2,)
                              )
                            );
                          } 
                          
                          else {
                            Builder(
                              builder: (BuildContext context) {

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: RegularText(text: response['message']),
                                    backgroundColor: Colors.black87
                                  )
                                );

                                return const SizedBox.shrink();
                              }
                            );
                
                          }

                          Navigator.pop(context);
                        },
                        items: widget.vehicles.map((vehicle) {
                          return vehicle['license_no'] as String;
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            widget.vehicleId = widget.vehicles.firstWhere((vehicle) => vehicle['license_no'] == value)['vehicle_id'];
                          });
                        }
                        
                      );
                      
                    }
                  );
              
                },
              ),
            ];
          } 
          
          
          else {
            return <PopupMenuEntry>[
              
              PopupMenuItem(
                value: 'Unpark',
                child: RegularText(text: 'Unpark Vehicle'),
                onTap: () async {

                  showDialog(
                    context: context, 
                    builder: (BuildContext context) {
                      return ConfirmDialogBox(
                        message: "Are you sure you want to unpark this vehicle?",
                        title: "Unpark Vehicle", 
                        onOk: () async {

                          Map <String, dynamic> response = await unparkVehicle(widget.parkingSpace['parking_space_id']);

                          if (!mounted) return;

                          if (response['status']) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DriverEntry(initialTab: 2,)
                              )
                            );
                          } 
                          
                          else {
                            Builder(
                              builder: (BuildContext context) {

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: RegularText(text: response['message']),
                                    backgroundColor: Colors.black87
                                  )
                                );

                                return const SizedBox.shrink();
                              }
                            );
                
                          }

                          Navigator.pop(context);
                        },
                      );
                    }
                  );
                  
                  
                },
              ),
            ];
          }
        },
      ),
      onTap: () {

      },

    );
    
  }

}