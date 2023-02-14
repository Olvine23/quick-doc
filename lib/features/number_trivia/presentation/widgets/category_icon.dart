import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/another.dart';

import '../pages/welcome/my_books.dart';

class CategoryIcon extends StatelessWidget {
  IconData icon;
  String text;

  CategoryIcon({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    if (text == "Critical") {
      return InkWell(
        splashColor: Color(CustomColors.bg01),
        onTap: () {
          if (text == "Pill") {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyBooks();
            }));
          } else if (text == "Hospital") {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TestLaunch();
            }));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(CustomColors.bg),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: AvatarGlow(
                  duration: Duration(milliseconds: 1000),
                  endRadius: 100,
                  glowColor: Colors.red,
                  child: Icon(
                    icon,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Color(CustomColors.primary),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    } else
      return InkWell(
        splashColor: Color(CustomColors.bg01),
        onTap: () {
          if (text == "Pill") {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyBooks();
            }));
          } else if (text == "Hospital") {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TestLaunch();
            }));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(CustomColors.bg),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  icon,
                  color: Color(CustomColors.primary),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Color(CustomColors.primary),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
  }
}
