import 'package:flutter/material.dart';

class ColorStream {
  Stream? colorStream;

  Stream<Color> getColors() async* {
    final List<Color> colors = [
      Colors.blueGrey,
      Colors.black,
      
      Colors.amber,
      Colors.deepPurple,
      Colors.lightBlue,
      Colors.teal
    ];
    yield* Stream.periodic(Duration(seconds: 3), (int t) {
      int index = t % 5;
      return colors[index];
    });
  }
}
