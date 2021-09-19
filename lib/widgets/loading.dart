import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.height * 0.20,
                      child: const Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(strokeWidth: 12, color: Colors.white),
                      )
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Laster inn Spørsmål...\nSørg for at internet er på.',
                          textScaleFactor: 1.5,
                          style: TextStyle(fontFamily: 'MouseMemoirs', color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      )
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: const BorderRadius.all(Radius.circular(20))
                ),
              ),
            )
          )
        )
      ),
    );
  }
}