import 'package:flutter/material.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/core/styles/styles.dart';
import 'package:test/features/number_trivia/presentation/pages/welcome/my_books.dart';

class Title_row extends StatelessWidget {
  const Title_row({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Upcoming Appointment',
          style: kTitleStyle,
        ),
        TextButton(
          child: Text(
            'See All',
            style: TextStyle(
              color: Color(CustomColors.yellow01),
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return MyBooks();
            })));
          },
        )
      ],
    );
  }
}
