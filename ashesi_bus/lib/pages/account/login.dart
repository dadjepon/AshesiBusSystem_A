import 'package:ashesi_bus/driver_pages/account/driver_login.dart';
import 'package:ashesi_bus/helper/functions/validate.dart';
import 'package:ashesi_bus/helper/widgets/app_bar.dart';
import 'package:ashesi_bus/helper/widgets/form.dart';
import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:ashesi_bus/pages/account/sign_up.dart';
import 'package:ashesi_bus/pages/nav_tabs/entry.dart';
import 'package:ashesi_bus/requests/bus_user.dart';
import 'package:flutter/material.dart';

// SIGN IN INFO
// email address = kwaku.osafo@ashesi.edu.gh
// password = Mariamjade1@


class Login extends StatefulWidget {
  const Login(
    {
      super.key
    }
  );


  @override
  LoginState createState() => LoginState();


}


class LoginState extends State <Login> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
          title: "Login",
        ),

        body: Form (
          key: _formKey,
          child: ListView (
            children:  [

              const SizedBox(height: 20),

              const LeftAlignedText(
                text: SubHeaderText(
                  text: "Enter your email and password to enrich your Ashesi\nbus experience",
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
                  text: "Email Address",
                )
              ),

              AppFormField(
                controller: _emailController,
                hintText: "Enter your Ashesi email address",
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }

                  if (!isEmailValid(value)) {
                    return 'Please enter a valid email address';
                  }

                  return null;
                },
              ),

              const LeftAlignedText(
                text: SubHeaderText(
                  text: "Password",
                )
              ),

              PasswordFormField(
                controller: _passwordController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }

                  if (!isPasswordValid(value)) {
                    return 'Please enter a valid password';
                  }

                  return null;
                },
              ),
              

              Builder(
                builder: (BuildContext context) {

                  return SubmitFormButton(
                    text: "Login",
                    onPressed: () async {

                      if (_formKey.currentState!.validate()) {
                        
                        Map <String, dynamic> response = await loginBusUser(
                          _emailController.text,
                          _passwordController.text,
                        );

                        if (!mounted) return;

                        if (response['status']) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 3),
                              content: RegularText(
                                text: "Logged in successfully! Please wait...",
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
                              builder: (context) => const Entry(),
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
                  );
                },
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
                    text: "Don't have an account? Sign up"
                  ), 
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUp(),
                      ),
                    );
                  }
                )
              ),

              const SizedBox(height: 20),

              CenteredText(
                text: LinkText(
                  text: const SubHeaderText(
                    text: "Switch to driver login",
                    color: Color.fromRGBO(14, 66, 168, 1),
                  ), 
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DriverLogin(),
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