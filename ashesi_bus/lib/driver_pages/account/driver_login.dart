import 'package:ashesi_bus/driver_pages/nav_tabs/entry.dart';
import 'package:ashesi_bus/helper/widgets/app_bar.dart';
import 'package:ashesi_bus/helper/widgets/form.dart';
import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:ashesi_bus/pages/account/login.dart';
import 'package:ashesi_bus/requests/driver.dart';
import 'package:flutter/material.dart';

// SIGN IN INFO
// email address = kwaku.osafo@ashesi.edu.gh
// password = Kwakuosafo1!


class DriverLogin extends StatefulWidget {
  const DriverLogin(
    {
      super.key
    }
  );


  @override
  DriverLoginState createState() => DriverLoginState();


}


class DriverLoginState extends State <DriverLogin> {

  final TextEditingController _driverAshesiIdController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build (BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      highContrastDarkTheme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold (
        key: _scaffoldKey,
        appBar: const RegularAppBarNoBack(
          title: "Driver Login",
        ),

        body: Form (
          key: _formKey,
          child: ListView (
            children:  [

              const SizedBox(height: 20),

              const LeftAlignedText(
                text: SubHeaderText(
                  text: "Only drivers can log in here. Switch to passenger login if you are not a driver.",
                )
              ),

              const SizedBox(height: 20),

              Image.asset(
                'assets/images/ashesi_bus.png',
                width: 50,
                height: 50,
              ),

              const SizedBox(height: 20),

              const LeftAlignedText(
                text: SubHeaderText(
                  text: "Driver ID",
                )
              ),

              AppFormField(
                controller: _driverAshesiIdController,
                hintText: "Enter your Ashesi ID",
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Ashesi ID';
                  }

                  return null;
                },
              ),

              Builder(

                builder: (BuildContext context) {
                  return SubmitFormButton(
                    onPressed: () async {

                      if (_formKey.currentState!.validate()) {
                        Map <String, dynamic> response = await loginDriver(
                          _driverAshesiIdController.text,
                        );

                        if (!mounted) return;

                        if (response['status']) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 3),
                              content: RegularText(
                                text: "Login successful! Please wait...",
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.black87,
                            )
                          );

                          // Wait for 3 seconds
                          await Future.delayed(const Duration(seconds: 3));

                          if (!mounted) return;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DriverEntry(),
                            ),
                          );

                        }

                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: RegularText(
                                text: response['message'],
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.black54,
                            )
                          );
                        }
                      }
                    },
                    text: "Login",
                  );
                }
              ),
              

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: const Divider(
                  color: Colors.grey,
                  thickness: 0.4,
                )
              ),

              CenteredText(
                text: LinkText(
                  text: const SubHeaderText(
                    text: "Switch to passenger login",
                    color: Color.fromRGBO(14, 66, 168, 1),
                  ), 
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  }
                )
              )



            ]
          ),
        ),
      )
    );
  }

}