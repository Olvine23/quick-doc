import 'package:flutter/material.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/core/styles/styles.dart';
import 'package:test/features/number_trivia/presentation/widgets/schedule_card.dart';

class CustomCard extends StatelessWidget {
  final String color;
  final String name;
  final String image;
  final int number;
  final String valid;

  CustomCard(
      {required this.color,
      required this.image,
      required this.number,
      required this.valid,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
      child: Container(
        height: 150,
        width: 300,
        decoration: BoxDecoration(
            color: Color(CustomColors.primary),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade600,
                  offset: Offset(3, 1),
                  blurRadius: 7,
                  spreadRadius: 2)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/doctor.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(name, style: kTitleStyleWithWhiteColor),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          number.toString(),
                          style: kTitleStyleWithWhiteColor,
                        )
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Wed 12 2023",
                    // formattedDate,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.access_alarm,
                    color: Colors.white,
                    size: 17,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text(
                      '11:00 ~ 12:10',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              // Row(
              //   children: <Widget>[
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: RichText(
              //           text: TextSpan(children: [
              //         TextSpan(
              //             text: name,
              //             style: TextStyle(color: Colors.white, fontSize: 18)),
              //       ])),
              //     ),
              //   ],
              // ),
              // Expanded(child: ScheduleCard())
            ],
          ),
        ),
      ),
    );
  }
}
