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
                  // for (var item in snapshot.data!) Text(item.name),
                  DropdownButton(
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
                  Text(_chosenValue != null ? _chosenValue! : ''),
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