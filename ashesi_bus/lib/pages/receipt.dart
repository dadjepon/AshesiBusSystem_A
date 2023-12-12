import 'package:ashesi_bus/helper/functions/date_time.dart';
import 'package:ashesi_bus/helper/widgets/app_bar.dart';
import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Receipt extends StatefulWidget {

  const Receipt(
    {
      super.key,
      required this.trip
    }
  );

  final Map<String, dynamic> trip;

  @override
  ReceiptState createState() => ReceiptState();

}

class ReceiptState extends State<Receipt> {

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: RegularAppBar(
          prevContext: context,
          title: "Payment Receipt",
        ),

        body: ListView(

          children: [

            const SizedBox(height: 20),

            Image.asset(
              'assets/images/ashesi_bus.png',
              height: 50,
              width: 50,
            ),

            const SizedBox(height: 20),

            RightAlignedText(
              text: RegularText(
                text: "Date: ${parseDate(widget.trip['date_time_started'])}")),

            LeftAlignedText(
              text: RegularText(
                text: "Receipient:",
              )
            ),

            LeftAlignedText(
              text: SubHeaderText(
                text: _name
              )
            ),

            LeftAlignedText(
              text: SubHeaderText(
                text: _ashesiId
              )
            ),


            const SizedBox(height: 10),

            RightAlignedText(
              text: RegularText(
                text: "Driver:",
              )
            ),

            RightAlignedText(
              text: SubHeaderText(
                text: "${widget.trip['fname']} ${widget.trip['lname']}",
              )
            ),

            const SizedBox(height: 10),

            LeftAlignedText(
              text: RegularText(
                text: "Trip",
              )
            ),

            LeftAlignedText(
              text: SubHeaderText(
                text: "${widget.trip['trip_name']}",
              )
            ),

            const SizedBox(height: 10),

            RightAlignedText(
              text: RegularText(
                text: "Vehicle:",
              )
            ),

            RightAlignedText(
              text: SubHeaderText(
                text: "${widget.trip['vehicle_name']}",
              )
            ),

            LeftAlignedText(
              text: RegularText(
                text: "Joined/Alighted at:",
              )
            ),

            LeftAlignedText(
              text: SubHeaderText(
                text: "${widget.trip['stop_name']}",
              )
            ),


            const SizedBox(height: 30),

            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                defaultColumnWidth: const IntrinsicColumnWidth(),
                border: TableBorder.all(
                  color: Colors.black,
                  width: 1,
                ),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: LeftAlignedText(
                          text: RegularText(
                            text: "Amount",
                          )
                        )
                      ),
                      TableCell(
                        child: RightAlignedText(
                          text: RegularText(
                            text: "GHS ${widget.trip['amount'].toString()[0]}",
                          )
                        )
                      ),
                    ]
                  ),

                  TableRow(
                    children: [
                      TableCell(
                        child: LeftAlignedText(
                          text: RegularText(
                            text: "Ref",
                          )
                        )
                      ),
                      TableCell(
                        child: RightAlignedText(
                          text: RegularText(
                            text: widget.trip['ref'],
                          )
                        )
                      ),
                    ]
                  ),

                  TableRow(
                    children: [
                      TableCell(
                        child: LeftAlignedText(
                          text: RegularText(
                            text: "Paid at",
                          )
                        )
                      ),
                      TableCell(
                        child: RightAlignedText(
                          text: RegularText(
                            text: parseDate(widget.trip['payment_date_time']),
                          )
                        )
                      ),
                    ]
                  ),

                  TableRow(
                    children: [
                      TableCell(
                        child: LeftAlignedText(
                          text: RegularText(
                            text: "Time",
                          )
                        )
                      ),
                      TableCell(
                        child: RightAlignedText(
                          text: RegularText(
                            text: parseTime(widget.trip['payment_date_time']),
                          )
                        )
                      ),
                    ]
                  ),

                    
                  
                ],
              ),

            ),

          ],

        )
      )
    );

  }

}



  




