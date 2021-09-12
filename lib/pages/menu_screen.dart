import 'package:chin_chin/pages/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  static const images =  ["card44.png", "card11.png", "card33.png", "card22.png"];
  static const gameNames =  ["Jeg har aldri...", "Hvem i rommet", "Vil du heller", "Nødt eller Sannhet"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
          children: [
            
            // Header
            const Padding(
              padding: EdgeInsets.only(top: 48, left: 16, right: 16),
              child: Text(
                "Chin Chin", 
                textScaleFactor: 6.5,
                style: TextStyle(fontFamily: 'MouseMemoirs', color: Colors.white),
              ),
            ),

            // List
           for (int i = 0; i < 4; i++)
              GameCard(image:images[i], gameName: gameNames[i], cardIndex: i,),

          ],
        ),
        )
      ),
    );
  }
}


class GameCard extends StatelessWidget {
  const GameCard({required this.image, required this.gameName, required this.cardIndex, Key? key}) : super(key: key);

  final String image;
  final String gameName;
  final int cardIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GameScreen(gameNumber: cardIndex)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          child: Center(
            child: Text(
              gameName, 
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'MouseMemoirs'
              ),
              textScaleFactor: 3,
            ),
          ),
          height: 175,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/$image"),
              fit: BoxFit.fill
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))
          ),
        ),
      ),
    );
  }
}