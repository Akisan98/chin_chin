import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget {
  const SimpleAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).devicePixelRatio == 3 ? 55 : 60,
      width: double.infinity,
      child: Row(
        children: const [
          BackButton(),
          BarTitle(),
          HelpButton(),
        ],
      ),
    );
  }
}

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

class BarTitle extends StatelessWidget {
  const BarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Text(
            " ", 
            style: TextStyle(
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

class HelpButton extends StatelessWidget {
  const HelpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
        child: ActionChip(
          label: Text("Help"),
          avatar: Icon(Icons.help_outline),
          onPressed: (){}, 

        )
      )
    );
  }
}