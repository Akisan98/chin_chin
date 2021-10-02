import 'package:chin_chin/data/api/trivia_api.dart';
import 'package:chin_chin/data/models/trivia_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  String? _chosenValue;
  String? _chosenDiff;
  String? _chosenNums;

  List<String> diffs = ['Any', 'Easy', 'Medium', 'Hard'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: TriviaAPI.getCategories(),
          builder: (context, AsyncSnapshot<List<TriviaCategory>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text('Category'),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: DropdownButton(
                            isExpanded: true,
                            value: _chosenValue,
                            items: [
                              for (var item in snapshot.data!) 
                              DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: Text(
                                  item.name, 
                                  style: const TextStyle(
                                    color: Colors.black
                                  ),
                                ),
                              ),
                            ],
                            hint: const Text(
                              'Choose Category',
                              style: TextStyle(
                                color: Colors.black,
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
                        child: Text('Difficulty'),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: DropdownButton(
                            isExpanded: true,
                            value: _chosenDiff,
                            items: [
                              for (var i = 0; i < diffs.length; i++) 
                              DropdownMenuItem<String>(
                                value: diffs[i].toLowerCase(),
                                child: Text(
                                  diffs[i], 
                                  style: const TextStyle(
                                    color: Colors.black
                                  ),
                                ),
                              ),
                            ],
                            hint: const Text(
                              'Choose Difficulty',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _chosenDiff = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(_chosenDiff != null ? _chosenDiff! : ''),


                  /* ---------------------------------- ----------------------------- */

                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text('Number Of Questions'),
                      ),
                     Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: const Center(child: Text('-'),),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: Center(
                                  child: Text(
                                    'Chy',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              child: const Center(child: Text('-'),),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),



                ],
              );
            }
            return const Text('Failed to Fetch Data!');
          }
        )
      ),
    );
  }
}
