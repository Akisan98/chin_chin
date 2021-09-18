import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Displayes Modal Sheet With Information About The Current Game,
/// Triggered By Pressing the Action Chip In AppBar.
class InfoSheet extends StatelessWidget {
  const InfoSheet({required this.game, required this.explaination, Key? key}) : super(key: key);

  final String game;
  final String explaination;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return Column(
          children: [
            
            // Close Button
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.pop(context), 
                icon: const Icon(Icons.close)
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [

                    // Header
                    Padding(
                      padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
                      child: Text(
                        game, 
                        textScaleFactor: 6,
                        style: const TextStyle(fontFamily: 'MouseMemoirs', color: Colors.white),
                      ),
                    ),

                    // Text
                    Padding(
                      padding: const EdgeInsets.only(top: 32, left: 32, right: 32, bottom: 32),
                      child: Text(
                        explaination, 
                        textScaleFactor: 3.5,
                        style: const TextStyle(fontFamily: 'MouseMemoirs', color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      expand: false,
    );
  }
}