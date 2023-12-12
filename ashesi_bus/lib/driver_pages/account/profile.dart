import 'package:ashesi_bus/helper/widgets/app_bar.dart';
import 'package:ashesi_bus/helper/widgets/dialog_box.dart';
import 'package:ashesi_bus/helper/widgets/form.dart';
import 'package:ashesi_bus/helper/widgets/list_tile.dart';
import 'package:ashesi_bus/models/driver_pref.dart';
import 'package:ashesi_bus/pages/account/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  
  const Profile({
    super.key,
  });

  @override
  ProfileState createState() => ProfileState();

}


class ProfileState extends State<Profile> {

  String _name = "";
  String _driverAshesiId = "";
  String _phoneNumber = "";



  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _name = "${prefs.getString('fname')!} ${prefs.getString('lname')!}";
        _driverAshesiId = prefs.getString('driver_ashesi_id')!;
        _phoneNumber = prefs.getString('phone_number')!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: RegularAppBar(
          prevContext: context,
          title: "Profile",
        ),

        body: ListView(

          children: [

            const SizedBox(height: 20),

            AppFormField(
              controller: TextEditingController(text: _name), 
              hintText: " ",
              readOnly: true,
              labelText: "Name",
            ),

            AppFormField(
              controller: TextEditingController(text: _driverAshesiId), 
              hintText: " ",
              readOnly: true,
              labelText: "Ashesi ID",
            ),

            AppFormField(
              controller: TextEditingController(text: _phoneNumber), 
              hintText: " ",
              readOnly: true,
              labelText: "Phone Number",
            ),

            AppListTile(
            title: "Sign Out", 
            color: Colors.red,
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onTap: () {
              
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return ConfirmDialogBox(
                    message: "Tap OK to sign out",
                    title: "Sign Out", 
                    onOk: () async {

                      Map<String, dynamic> logout = await DriverPref().clearDriverData();

                      if (!mounted) return;

                      if (logout['isRemoved']) {

                        Navigator.pushReplacement(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => const Login()
                          )
                        );

                      }
                                   
                    }
                  );
                }
              );
            }
          ),

          ]


        ),
      )
    );

  }

}