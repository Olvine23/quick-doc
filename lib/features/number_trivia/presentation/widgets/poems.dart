// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test/features/number_trivia/data/models/poems_model.dart';
import 'package:test/features/number_trivia/presentation/pages/poems/poem_detail_screen.dart';
import 'package:test/main.dart';

class poems_future extends StatelessWidget {
  const poems_future({
    Key? key,
    required this.poems,
  }) : super(key: key);

  final List<Poems> poems;

  @override
  Widget build(BuildContext context) {
    print(poems.length);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: poems.length,
          itemBuilder: ((context, index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: (() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return Poem_Detail(
                          title: poems[index].title,
                          description: poems[index].author,
                          poem: poems[index].lines);
                    })));
                  }),
                  child: ListTile(
                    title: Text(
                      poems[index].title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(poems[index].author),
                    leading: Icon(Icons.mic, color: Colors.grey),
                    trailing: Icon(Icons.arrow_right_rounded),
                  ),
                ),
                Divider()
              ],
            );
          }),
        ));
  }
}
