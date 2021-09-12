import 'package:chin_chin/widgets/simple_appbar.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          children: const [
            SimpleAppBar(),

            // Header
            Padding(
              padding: EdgeInsets.only(top: 32, left: 16, right: 16),
              child: Text(
                "Jeg har Aldri...", 
                textScaleFactor: 6,
                style: TextStyle(fontFamily: 'MouseMemoirs', color: Colors.white),
              ),
            ),

            // PageView()

          ],
        ),
      ),
    );
  }
}