import 'package:auto_size_text/auto_size_text.dart';
import 'package:chin_chin/widgets/simple_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({required this.gameNumber, Key? key}) : super(key: key);

  final int gameNumber;

  static const images =  ["card44.png", "card11.png", "card33.png", "card22.png"];
  static const gameNames =  ["Jeg har aldri...", "Hvem i rommet", "Vil du heller", "Nødt eller Sannhet"];
  static const descriptions =  [
    "Den eldste spilleren starter med et utsagn, hvis folk har gjort det drikker dem, om ingen har drikker personen som leste.",
    "Spill ved å sende rundt en objekt eller peke på personen du tror det er.",
    "Den yngste spilleren starter spillet og stiller spørsmålet til spilleren som står ved siden av ham og så videre...",
    ""
  ];

  @override
  Widget build(BuildContext context) {

    final PageController _controller = PageController();

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              // AppBar
              SimpleAppBar(game: gameNames[gameNumber], explaination: descriptions[gameNumber]),

              // Header
              Padding(
                padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
                child: Text(
                  gameNames[gameNumber], 
                  textScaleFactor: 6,
                  style: const TextStyle(fontFamily: 'MouseMemoirs', color: Colors.white),
                ),
              ),

              // Question Cards
              Padding(
                padding: const EdgeInsets.only(top: 48),
                child: SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: 1000,
                    itemBuilder: (context, index) {
                      return QuestionCard(image: images[gameNumber]);
                    } 
                  ),
                ),
              ),

              // Button
              Padding(
                padding: const EdgeInsets.all(48),
                child: SizedBox(
                  width: 275,
                  height: 75,
                  child: TextButton(
                    onPressed: () {
                      _controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                    }, 
                    child: const Text("Neste"), 
                    style: ButtonStyle(
                      backgroundColor:  MaterialStateProperty.all(Colors.white),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800
                        )
                      ),
                    )
                  ),
                )
              )
            ],
          ),
        )
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({required this.image, Key? key}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 300,
        width: double.infinity,
        child: const Padding(
          padding: EdgeInsets.all(16), 
          child: AutoSizeText(
            'Hei jeg er akisan o tekst',
            style: TextStyle(fontSize: 60, fontFamily: 'MouseMemoirs', color: Colors.white),
            maxLines: 5,
          ),
        ),
        

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/$image"),
            fit: BoxFit.fill
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))
        ),
      ),
    );
  }
}