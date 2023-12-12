import 'package:ashesi_bus/driver_pages/trips/all_trips.dart';
import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:ashesi_bus/pages/trips/bus_schedule.dart';
import 'package:ashesi_bus/pages/trips/ongoing_trips.dart';
import 'package:flutter/material.dart';


class AppContainer extends StatelessWidget {
  
  const AppContainer ({
    super.key,
    required this.text,
    required this.colour,
    required this.icon,
    this.onTap,
  });

  final String text;
  final Color colour;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeaderText(
                text: text,
                color: Colors.white,
              ),
              Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
        )


    );
  }

}


class JoinTripContainer extends StatelessWidget {

  const JoinTripContainer ({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      text: "Join Trip", 
      colour: const Color.fromARGB(255, 200, 65, 65), 
      icon: Icons.route,
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => const OngoingTrips(),
          ),
        );
      },
    );
  }

}


class BusScheduleContainer extends StatelessWidget {

  const BusScheduleContainer ({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      text: "Bus Schedule", 
      colour: const Color.fromARGB(255, 14, 127, 168),
      icon: Icons.directions_bus,
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => const BusSchedule(),
          ),
        );
      },
    );
  }

}


class StartTripContainer extends StatelessWidget {

  const StartTripContainer ({
    super.key,
  });


  @override
  Widget build(BuildContext context) {

    return AppContainer(
      text: "Start Trip", 
      colour: const Color.fromARGB(255, 200, 65, 65), 
      icon: Icons.route,
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => const AllTrips(),
          ),
        );
      }
    );
  }

}