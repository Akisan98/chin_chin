import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chin_chin/pages/game_screen.dart';
import 'package:chin_chin/widgets/simple_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommunalToast extends StatelessWidget {
  const CommunalToast({Key? key}) : super(key: key);

  static Random rng = Random();

  static List<String> emojis = ['🥤', '🥃', '🥂', '🍻', '🍺', '🍹', '🍸', '🍷', '🍾', '🍶'];
  static List<String> rules = ['Waterfall', 'Alle tar en slurk', 'Gutta tar en slurk', 'Damene tar en slurk', 'Alle med sort klesplagg tar en slurk', 'Alle som ikke drikker øl tar en slurk', 'Alle som drikker øl tar en slurk', 'Petter må drikke, om Petter ikke er med må alle drikke'];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              // AppBar
              const SimpleAppBar(game: 'Chin Chin - Skål', explaination: 'Alle følger regelene som dukker opp her.'),

              // Header
              const GameTitle(gameName: 'Chin Chin - Skål'),

              RuleCard(emoji: emojis[rng.nextInt(emojis.length)], rule: rules[rng.nextInt(rules.length)]),


              NextButton(
                lable: 'Fortsett', 
                onPressed: () {
                  Navigator.of(context).pop();
                }
              ),
            ],
          ),
        )
      ),
    );
  }
}

class RuleCard extends StatelessWidget {
  const RuleCard({required this.emoji, required this.rule, Key? key}) : super(key: key);

  final String emoji;
  final String rule;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: PaddedCard(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).devicePixelRatio == 3.0 ? 160 : 200,
              child: AutoSizeText(
                emoji,
                style: const TextStyle(fontSize: 200),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).devicePixelRatio == 3.0 ? 80 : 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: AutoSizeText(
                  rule,
                  style: const TextStyle(fontSize: 60, fontFamily: 'MouseMemoirs', color: Colors.white),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}