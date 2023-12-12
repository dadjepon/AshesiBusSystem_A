import 'package:ashesi_bus/helper/widgets/list_tile.dart';
import 'package:ashesi_bus/pages/account/help.dart';
import 'package:ashesi_bus/pages/account/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/widgets/app_bar.dart';
import '../../helper/widgets/text.dart';

class MyAccount extends StatefulWidget {

  const MyAccount(
    {
      super.key
    }
  );

  @override
  MyAccountState createState() => MyAccountState();

}

class MyAccountState extends State<MyAccount> {

  String _name = "";
  String _ashesiId = "";

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _name = "${prefs.getString('fname')!} ${prefs.getString('lname')!}";
        _ashesiId = prefs.getString('ashesi_id')!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RegularAppBarNoBack(
        title: "My Account"
      ),
      body: ListView (

        children: [

          UsernameAndId(
            userName: _name,
            userId: _ashesiId,
          ),

          const SizedBox(height: 20),

          AppListTile(
            title: "Payment", 
            leading: const Icon(Icons.payment),
            onTap: () {
            }
          ),

          AppListTile(
            title: "Profile", 
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                ),
              );
            }
          ),

          AppListTile(
            title: "Settings",
            leading: const Icon(Icons.settings),
            onTap: () {
            }
          ),

          AppListTile(
            title: "Help", 
            leading: const Icon(Icons.help),
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const Help())
              );
            }
          ),

          

        ],
        
      ),
    );
  }

}