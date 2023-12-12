import 'package:ashesi_bus/helper/functions/validate.dart';
import 'package:ashesi_bus/helper/widgets/app_bar.dart';
import 'package:ashesi_bus/helper/widgets/dialog_box.dart';
import 'package:ashesi_bus/helper/widgets/form.dart';
import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:ashesi_bus/pages/account/login.dart';
import 'package:ashesi_bus/requests/bus_user.dart';
import 'package:flutter/material.dart';


class SignUp extends StatefulWidget {

  const SignUp(
    {
      super.key
    }
  );


  @override
  SignUpState createState() => SignUpState();


}


class SignUpState extends State <SignUp> {

  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _mobileMoneyController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose () {
    _fnameController.dispose();
    _lnameController.dispose();
    _emailController.dispose();
    _idController.dispose();
    _mobileMoneyController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
          title: "Sign Up",
        ),

        body: Form (

          key: _formKey,

          child: ListView (

            children:  [

              const SizedBox(height: 20),

              Image.asset(
                'assets/images/ashesi_bus.png',
                width: 50,
                height: 50,
              ),

              const SizedBox(height: 20),

              const LeftAlignedText(
                text: SubHeaderText(
                  text: "First Name",
                )
              ),

              AppFormField(
                controller: _fnameController,
                hintText: "Enter your first name",
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your first name";
                  }
                  return null;
                },
              ),

              const LeftAlignedText(
                text: SubHeaderText(
                  text: "Last Name",
                )
              ),

              AppFormField(
                controller: _lnameController,
                hintText: "Enter your last name",
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your last name";
                  }
                  return null;
                },
              ),

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
                    return "Please enter your Ashesi email address";
                  }
                  
                  if (!isEmailValid(value)) {
                    return "Please enter a valid email address";
                  }

                  return null;
                },
              ),

              const LeftAlignedText(
                text: SubHeaderText(
                  text: "Ashesi ID",
                )
              ),

              AppFormField(
                controller: _idController,
                hintText: "Enter your Ashesi ID",
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Ashesi ID";
                  }
                  return null;
                },
              ),

              const LeftAlignedText(
                text: SubHeaderText(
                  text: "Mobile Money Number",
                )
              ),

              AppFormField(
                controller: _mobileMoneyController,
                hintText: "Example: 0541234567",
                keyboardType: TextInputType.phone,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your mobile money number";
                  }

                  if (!isValidPhoneNumber(value)) {
                    return "Please enter a valid mobile money number";
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
                    return "Please enter your password";
                  }

                  if (!isPasswordValid(value)) {
                    return "Please enter a valid password";
                  }

                  return null;
                },               
              ),

              const LeftAlignedText(
                text: SubHeaderText(
                  text: "Confirm Password",
                )
              ),

              PasswordFormField(
                controller: _confirmPasswordController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please confirm your password";
                  }

                  if (value != _passwordController.text) {
                    return "Passwords do not match";
                  }

                  return null;
                },
              ), 

              Builder(
                builder: (BuildContext context) {
                  return SubmitFormButton(
                    onPressed: () async {

                      if (_formKey.currentState!.validate()) {
                        Map <String, dynamic> response = await registerBusUser(
                          _fnameController.text,
                          _lnameController.text,
                          _idController.text,
                          _emailController.text,
                          _passwordController.text,
                          _mobileMoneyController.text
                        );

                        if (!mounted) return;

                        if (response['status']) {
                          
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return  MessageDialogBox(
                                title: "Verify Account",
                                message: "Tap the link sent to your email to verify your account.",
                                onOk: () {
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(
                                      builder: (context) => const Login()
                                    )
                                  );
                                }
                              );
                            }
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
                    text: "Sign Up",
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

              LinkText(
                text: const CenteredText(
                  text: SubHeaderText(
                    text: "Already have an account? Login"
                  )
                ), 
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => const Login()
                    )
                  );
                }
              )
            ]
          ),
        ),
      )
    );
  }

}