import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:test/core/styles/colors.dart';

import '../pages/schedule/models/books.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Books>('booksBox').listenable(),
      builder: ((context, Box<Books> date_field, _) {
        // var date = date_field.getAt(0)?.date;
        // String formattedDate = DateFormat('dd MMM yyyy').format(date!);

        return Container(
          decoration: BoxDecoration(
            color: Color(CustomColors.bg01),
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Row(
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
                size: 20,
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
        );
      }),
    );
  }
}
