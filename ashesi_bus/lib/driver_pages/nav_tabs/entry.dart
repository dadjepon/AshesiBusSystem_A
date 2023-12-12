// ignore_for_file: must_be_immutable

import 'package:ashesi_bus/driver_pages/nav_tabs/parking.dart';

import 'home.dart';
import 'my_trips.dart';
import 'my_account.dart';
import 'package:flutter/material.dart';



class DriverEntry extends StatefulWidget {
  const DriverEntry(
    {
      super.key,
      this.initialTab = 0
    }
  );

  @override
  DriverEntryState createState() => DriverEntryState();

  final int initialTab;
}

class DriverEntryState extends State<DriverEntry> {

  int _currentIndex = 0;

  List<Widget> widgetOptions = [
    const Home(),
    const MyTrips(),
    const Parking(),
    const MyAccount(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTab;
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   initializeWidgetOptions();
  // }

  /// Checks if the user is logged in
  // Future<void> initializeWidgetOptions() async {

  //   SharedPreferences prefs = await SharedPreferences.getInstance();

    
  // }

  @override
  Widget build(BuildContext context) {
    
    List<BottomNavigationBarItem> bottomNavBarItems = [
      const BottomNavigationBarItem(
        label: "",
        icon: Icon(
          Icons.home,
          color: Color.fromRGBO(14, 66, 168, 1),
        ),
      ),
      const BottomNavigationBarItem(
        label: "",
        icon: Icon(
          Icons.directions_bus,
          color: Color.fromRGBO(14, 66, 168, 1),
        ),
      ),
      const BottomNavigationBarItem(
        label: "",
        icon: Icon(
          Icons.local_parking_rounded,
          color:  Color.fromRGBO(14, 66, 168, 1),
        ),
      ),
      const BottomNavigationBarItem(
        label: "",
        icon: Icon(
          Icons.account_circle,
          color:  Color.fromRGBO(14, 66, 168, 1),
        ),
      ),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: widgetOptions.elementAt(_currentIndex),
        bottomNavigationBar: Container(
          color: const Color.fromRGBO(14, 66, 168, 1),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: onTabTapped,
            items: bottomNavBarItems,
            selectedIconTheme: const IconThemeData(
              size: 40,
            ),
           
            backgroundColor: const Color.fromRGBO(14, 66, 168, 1),
    
          ),
        ),
      )
    );
  }

}
