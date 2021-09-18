import 'dart:developer' as dev;
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chin_chin/data/api/questions_api.dart';
import 'package:chin_chin/pages/communal_toast.dart';
import 'package:chin_chin/widgets/simple_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({required this.gameNumber, Key? key}) : super(key: key);

  final int gameNumber;

  @override
  Widget build(BuildContext context) {
    return gameNumber < 3 ? FutureBuilder(
      future: Questions.getQuestions(gameNumber),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          return GameScreenBody(gameNumber: gameNumber, questions: snapshot.data!);
        }
        return const Text('Fetching Data!');
      }
    ) : FutureBuilder(
      future: Questions.getTruthAndDareQuestions(),
      builder: (context, AsyncSnapshot<List<List<String>>> snapshot) {
        if (snapshot.hasData) {
          return TruthAndDare(gameNumber: gameNumber, truths: snapshot.data![0], dares: snapshot.data![1]);
        }
        return const Text('Fetching Data!');
      }
    );
  }
}

class GameScreenBody extends StatelessWidget {
  const GameScreenBody({required this.gameNumber, required this.questions, Key? key}) : super(key: key);

  final int gameNumber;
  final List<String> questions;

  static const images =  ['card44.png', 'card11.png', 'card33.png'];
  static const gameNames =  ['Jeg har aldri...', 'Hvem i rommet', 'Vil du heller'];
  static const descriptions =  [
    'Den eldste spilleren starter med et utsagn, hvis folk har gjort det drikker dem, om ingen har drikker personen som leste.',
    'Spill ved å sende rundt en objekt eller peke på personen du tror det er.',
    'Den yngste spilleren starter spillet og stiller spørsmålet til spilleren som står ved siden av ham og så videre...'
  ];

  static Random rng = Random();

  @override
  Widget build(BuildContext context) {
    questions.add('INGEN FLERE SPØRSMÅL! -  Prøve gjerne en annen lek');
    
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
              GameTitle(gameName: gameNames[gameNumber]),

              // Question Cards
              PaddedCard(
                child:  PageView.builder(
                  controller: _controller,
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return QuestionCard(
                      image: images[gameNumber], 
                      question: questions[index]//'$index TEXT',
                    );
                  } 
                )
              ),

              // Button
              NextButton(
                lable: 'Neste',
                onPressed: () {
                  if (rng.nextInt(6) == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CommunalToast()),
                    );
                  }
                  _controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                }            
              ),
            ],
          ),
        )
      ),
    );
  }
}



class TruthAndDare extends StatefulWidget {
  const TruthAndDare({required this.gameNumber, required this.truths, required this.dares, Key? key}) : super(key: key);

  final int gameNumber;
  final List<String> truths;
  final List<String> dares;

  @override
  _TruthAndDareState createState() => _TruthAndDareState();
  
}

class _TruthAndDareState extends State<TruthAndDare> {

  late final int gameNumber;
  late final List<String> truths;
  late final List<String> dares;

  late final PageController _controllerTruth;
  late final PageController _controllerDare;
  
  @override
  void initState() {
    super.initState();
    gameNumber = widget.gameNumber;
    truths = widget.truths;
    dares = widget.dares;

    _controllerTruth = PageController();
    _controllerDare = PageController();
  }

  // Logic For Truth and Dare
  static bool showTruths = false;
  static bool showDares = false;

  static String gameTitle = 'Nødt eller Sannhet';
  final String backgroundImage = 'card22.png';

  static int stackIndex = 2;

  static Random rng = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // AppBar
              const SimpleAppBar(game: 'Nødt eller Sannhet', explaination: 'Alle spillerne sitter i en sirkel og den første snur en flaske i midten, den Flaskehalsen peker på blir stilt spørsmålet: Nødt eller sannhet?'),

              // Header
              GameTitle(gameName: gameTitle),
              
              // Question Card
              PaddedCard(
                child: IndexedStack(
                  index: stackIndex,
                  children: [
                    FixedCardSize(
                      child: PageView(
                        controller: _controllerTruth,
                        children: [
                          for (var truth in truths) QuestionCard(
                            image: backgroundImage, 
                            question: truth//'$index TEXT',
                          ),
                        ],
                      ),
                    ),

                    FixedCardSize(
                      child: PageView(
                        controller: _controllerDare,
                        children: [
                          for (var dare in dares) QuestionCard(
                            image: backgroundImage, 
                            question: dare//'$index TEXT',
                          ),
                        ],
                      ),
                    ),

                    const FixedCardSize(
                      child: TruthAndDareDefault(),
                    ),
                  ],
                ),
              ),

              // Buttons
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 48, 16, 48),
                child:  SizedBox(
                  height: 75,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextButton(
                          onPressed: () {
                            if (rng.nextInt(6) == 2) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CommunalToast()),
                              );
                            }

                            if (showTruths == false && showDares == true) {
                              dev.log(_controllerDare.page.toString());
                              _controllerDare.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                            } else {
                             setState(() {
                                stackIndex = 1;
                                gameTitle = 'Nødt';
                                showTruths = false;
                                showDares = true;
                                _controllerDare.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                             });
                            }
                          }, 
                          child: const Text('Nødt'), 
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
                      ),

                      const Spacer(flex: 1),
                      
                      Expanded(
                        flex: 5,
                        child: TextButton(
                          onPressed: () {
                            if (rng.nextInt(6) == 2) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const CommunalToast()),
                                );
                              }

                            if (showTruths == true) {
                              _controllerTruth.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                            } else {
                              setState(() {
                                stackIndex = 0;
                                gameTitle = 'Sannhet';
                                showTruths = true;
                                showDares = false;
                               _controllerTruth.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                              });
                            }
                          }, 
                          child: const Text('Sannhet'), 
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
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}

class GameTitle extends StatelessWidget {
  const GameTitle({required this.gameName, Key? key}) : super(key: key);

  final String gameName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).devicePixelRatio == 3.0 ? 16 : 32, left: 16, right: 16),
      child: AutoSizeText(
        gameName,
        style: const TextStyle(fontSize: 80, fontFamily: 'MouseMemoirs', color: Colors.white),
        maxLines: 1,
        textAlign: TextAlign.left,
        //overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class PaddedCard extends StatelessWidget {
  const PaddedCard({required this.child, Key? key}) : super(key: key);

  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).devicePixelRatio == 3.0 ? 24.0 : 48.0),
      child: FixedCardSize(
        child: child
      ),
    );
  }
}

class FixedCardSize extends StatelessWidget {
  const FixedCardSize({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).devicePixelRatio == 3.0 ? MediaQuery.of(context).size.height * 0.38 : MediaQuery.of(context).size.height * 0.4,
      child: child
    );
  }
  
}


class QuestionCard extends StatelessWidget {
  const QuestionCard({required this.image, required this.question, Key? key}) : super(key: key);

  final String image;
  final String question;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(24), 
          child: AutoSizeText(
            question,
            style: const TextStyle(fontSize: 60, fontFamily: 'MouseMemoirs', color: Colors.white),
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$image'),
            fit: BoxFit.fill
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))
        ),
      ),
    );
  }
}

class TruthAndDareDefault extends StatelessWidget {
  const TruthAndDareDefault({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const QuestionCard(
      image: 'card22.png',
      question: 'Trykk en knapp for å starte!'
    );
  }
  
}

class NextButton extends StatelessWidget {
  const NextButton({required this.lable, required this.onPressed, Key? key}) : super(key: key);

  final String lable;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        height: 75,
        child: TextButton(
          onPressed: onPressed, 
          child: Text(lable), 
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
    );
  }
}