import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Displayes Modal Sheet With Information About The Current Game,
/// Triggered By Pressing the Action Chip In AppBar.
class InfoSheet extends StatelessWidget {
  const InfoSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [

                // Close Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context), 
                    icon: const Icon(Icons.close)
                  ),
                ),

                // Header
                const Padding(
                  padding: EdgeInsets.only(top: 32, left: 16, right: 16),
                  child: Text(
                    "Jeg har Aldri...", 
                    textScaleFactor: 6,
                    style: TextStyle(fontFamily: 'MouseMemoirs', color: Colors.white),
                  ),
                ),

                // Text
                const Padding(
                  padding: EdgeInsets.only(top: 32, left: 32, right: 32),
                  child: Text(
                    "Den eldste spilleren starter med et utsagn, hvis folk har gjort det drikker dem, om ingen har drikker personen som leste.", 
                    textScaleFactor: 3.5,
                    style: TextStyle(fontFamily: 'MouseMemoirs', color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        );
      },
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      expand: false,
    );
  }
}