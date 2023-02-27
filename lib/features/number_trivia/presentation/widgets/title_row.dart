import 'package:flutter/material.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/core/styles/styles.dart';
import 'package:test/features/number_trivia/presentation/pages/schedule/appointment_page.dart';
import 'package:test/features/number_trivia/presentation/pages/welcome/my_books.dart';

class Title_row extends StatelessWidget {
  final String title;
  final String leading;
  const Title_row({
    Key? key,
    required this.title,
    required this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
         title,
          style: kTitleStyle,
        ),
        TextButton(
          child: Text(
           leading,
            style: TextStyle(
              color: Color(CustomColors.yellow01),
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return AppointmentPage();
            })));
          },
        )
      ],
    );
  }
}
