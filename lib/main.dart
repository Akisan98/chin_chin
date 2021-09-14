import 'package:chin_chin/pages/test.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: TestPage(),
      debugShowCheckedModeBanner: false,
    )
  );
}

class PartyBud extends StatelessWidget {
  const PartyBud({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.red,),
    );
  }
}
