import 'package:flutter/material.dart';
import 'my_account.dart';
import 'my_trips.dart';
import 'home.dart';


class Entry extends StatefulWidget {
  const Entry(
    {
      super.key
    }
  );

  @override
  EntryState createState() => EntryState();
}

class EntryState extends State<Entry> {

  int _currentIndex = 0;

  List<Widget> widgetOptions = [
    const Home(),
    const MyTrips(),
    const MyAccount(),
  ];

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
          color: Colors.white,
        ),
      ),
      const BottomNavigationBarItem(
        label: "",
        icon: Icon(
          Icons.directions_bus,
          color: Colors.white,
        ),
      ),
      const BottomNavigationBarItem(
        label: "",
        icon: Icon(
          Icons.account_circle,
          color: Colors.white,
        ),
      ),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: widgetOptions.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: bottomNavBarItems,
          selectedIconTheme: const IconThemeData(
            size: 40,
          ),
          backgroundColor: const Color.fromRGBO(14, 66, 168, 1),
  
        ),
      ),
    );
  }

}
