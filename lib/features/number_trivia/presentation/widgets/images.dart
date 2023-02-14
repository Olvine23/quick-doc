import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:test/features/number_trivia/data/models/images.dart';
import 'package:test/services.dart';

class MyWidget extends StatelessWidget {
  final List images;
  const MyWidget({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: images.length,
        itemBuilder: ((context, index) {
          return Image.network(images[index].url);
        }));
  }
}
