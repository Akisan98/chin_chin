import 'package:chin_chin/data/api/trivia_api.dart';
import 'package:chin_chin/data/models/trivia_category.dart';
import 'package:chin_chin/widgets/loading.dart';
import 'package:chin_chin/widgets/simple_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';

import 'game_screen.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  String? _chosenValue;
  String _chosenDiff = 'any';
  num _chosenNums = 10;

  List<String> diffs = ['Any', 'Easy', 'Medium', 'Hard'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: FutureBuilder( // TODO: Move to a Stateless One
          future: TriviaAPI.getCategories(),
          builder: (context, AsyncSnapshot<List<TriviaCategory>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [

                  // AppBar
                  SimpleAppBar(
                    game: 'Trivia', 
                    explaination: 'Trivia is a game where you are presented a number of question with answers, if you pick the correct answeer you get a point and if you pick the wrong once you don\'t get a point. The goal is to get highest score possible.', 
                    showTitle: MediaQuery.of(context).devicePixelRatio != 3.0 ? false : true
                  ),

                  // Header
                  MediaQuery.of(context).devicePixelRatio != 3.0 ? const GameTitle(gameName: 'Trivia Menu', shrink: true) : const SizedBox(),

                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).devicePixelRatio == 3.0 ? 24.0 : 48.0, left: 16, right: 16, bottom: 24),
                    child: const Text(
                      'Please choose desired Category, Difficulty & Number of Questions below.', 
                      style: TextStyle(fontSize: 30, fontFamily: 'MouseMemoirs', color: Colors.white),
                    ),
                  ),

                  // Dropdowns
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text('Category', style: TextStyle(color: Colors.white)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: DropdownButton(
                            dropdownColor: Colors.grey[700],
                            isExpanded: true,
                            value: _chosenValue,
                            items: [
                              for (var item in snapshot.data!) 
                              DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: Text(
                                  item.name, 
                                  style: const TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            ],
                            hint: const Text(
                              'Choose Category',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _chosenValue = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(_chosenValue != null ? _chosenValue! : ''),

                  /* ----------------------- ------------------------*/

                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text('Difficulty', style: TextStyle(color: Colors.white)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: DropdownButton(
                            dropdownColor: Colors.grey[700],
                            isExpanded: true,
                            value: _chosenDiff,
                            items: [
                              for (var i = 0; i < diffs.length; i++) 
                              DropdownMenuItem<String>(
                                value: diffs[i].toLowerCase(),
                                child: Text(
                                  diffs[i], 
                                  style: const TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            ],
                            hint: const Text(
                              'Choose Difficulty',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _chosenDiff = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(_chosenDiff),


                  /* ---------------------------------- ----------------------------- */

                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text('Nums', style: TextStyle(color: Colors.white)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: CustomNumberPicker<num>(
                            shape: const RoundedRectangleBorder(),
                            valueTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
                            customAddButton: const Padding(padding: EdgeInsets.only(left: 32, right: 32), child: Icon(Icons.add, color: Colors.white),),
                            customMinusButton: const Padding(padding: EdgeInsets.only(left: 32, right: 32), child: Icon(Icons.remove, color: Colors.white),),
                            initialValue: 10,
                            maxValue: 50,
                            minValue: 1,
                            step: 1,
                            onValue: (num value) {
                              setState(() {
                                _chosenNums = value;
                              });
                            },
                          )
                        ),
                      ),
                    ],
                  ),

                  const Spacer(flex: 1),

                  Padding(padding: const EdgeInsets.all(16), child: NextButton(lable: 'Start', onPressed: () { 
                    // TODO: NEW PAGE THEN QUERY
                    // TriviaAPI.getQuestions(_chosenNums.toInt(), _chosenValue != null ? int.parse(_chosenValue!) : null, _chosenDiff);
                   },),),
                ],
              );
            }

            return const LoadingScreen();
          }
        )
      ),
    );
  }
}
