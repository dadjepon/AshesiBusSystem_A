import 'package:ashesi_bus/helper/widgets/app_bar.dart';
import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:flutter/material.dart';

class Help extends StatelessWidget {

  const Help({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: RegularAppBar(
          prevContext: context,
          title: "Help",
        ),

        body: ListView(

          children: [

            const SizedBox(height: 20),

            LeftAlignedText(
              text: RegularText(
                text: "If you have any issues with the app, please contact the logistics office.",
              )
            ),

            const SizedBox(height: 20),

            // link to logistics office email
            

          ],

        ),

      )
    );

      

  }

}