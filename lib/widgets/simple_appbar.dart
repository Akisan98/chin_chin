import 'package:chin_chin/widgets/info_modal_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Custom and Stylish Appbar to Replace The Standard One. 
class SimpleAppBar extends StatelessWidget {
  const SimpleAppBar({required this.game, required this.explaination, this.showTitle = false, Key? key}) : super(key: key);

  final String game;
  final String explaination;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).devicePixelRatio == 3 ? 55 : 60,
      width: double.infinity,
      child: Row(
        children: [
          const BackButton(),
          BarTitle(gameTitle: showTitle ? game : ''),
          HelpButton(game: game, explaination: explaination),
        ],
      ),
    );
  }
}

/// Displayes Back Arrow For Exiting Page
class BackButton extends StatelessWidget {
  const BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,), 
          onPressed: () {
            Navigator.pop(context);
          }
        ),
      )
    );
  }
}

/// Displayes The Title of Page
class BarTitle extends StatelessWidget {
  const BarTitle({required this.gameTitle, Key? key}) : super(key: key);

  final String gameTitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Text(
            gameTitle, 
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.white
            ),
            overflow: TextOverflow.ellipsis,
            textScaleFactor: 1.75,
            maxLines: 1,
          ), 
        )
      ),
    );
  }
}

/// For Displaying The Help Chip That Open The Info Sheet
class HelpButton extends StatelessWidget {
  const HelpButton({required this.game, required this.explaination, Key? key}) : super(key: key);

  final String game;
  final String explaination;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
        child: ActionChip(
          backgroundColor: Colors.grey[600],
          label: const Text('Hjelp', style: TextStyle(color: Colors.white)),
          avatar: const Icon(Icons.help_outline, color: Colors.white),
          onPressed: (){
            showModalBottomSheet(
              builder: (context) => InfoSheet(game: game, explaination: explaination), 
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))
              ),
              isScrollControlled: true,
              backgroundColor: Colors.grey[800],
            );
          }, 
        )
      )
    );
  }
}