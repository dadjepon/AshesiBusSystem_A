import 'package:flutter/material.dart';

import 'form.dart';
import 'text.dart';

class AppFutureBuilder extends StatelessWidget {

  const AppFutureBuilder(
    {
      super.key,
      required this.future,
      required this.builder,
      required this.reloadPageFunction,
      required this.couldNotLoadText
    }
  );

  final Future future;
  final Function builder;
  final Function reloadPageFunction;
  final String couldNotLoadText;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {

        if (snapshot.hasData) {
          return builder(snapshot.data);
        }

        else if (snapshot.hasError) {
          return Center(
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RegularText(
                  text: "Could not load $couldNotLoadText. Please try again later.",
                  color: Colors.black,
                ),

                const SizedBox(height: 10),

                SubmitFormButton(
                  onPressed: () {
                    // Retry the operation
                    reloadPageFunction();
                  },
                  text: "Retry",
                ),
              ],
            ),
          );
        }

        else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

      },
    );
  }
}