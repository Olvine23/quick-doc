import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test/features/number_trivia/data/models/poems_model.dart';

class Poem_Detail extends StatelessWidget {
  final String title;
  final List poem;

  final String description;
  const Poem_Detail(
      {required this.title,
      required this.description,
      super.key,
      required this.poem});

  @override
  Widget build(BuildContext context) {
    print(poem.length);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network('https://random.imagecdn.app/900/500'),
            Text(
              title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: poem.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(poem[index]),
                  );
                }))
          ],
        ),
      ))),
    );
  }
}
